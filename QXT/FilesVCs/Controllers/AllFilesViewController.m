//
//  AllFilesViewController.m
//  QXT
//
//  Created by LingLi on 16/3/21.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "AllFilesViewController.h"
#import "MessagesViewController.h"
#import "FileTableViewCell.h"
#import "CharActionSheet.h"
#import "FFNavbarMenu.h"
#import "NDSearchTool.h"
#import "FileModel.h"
@interface AllFilesViewController ()<ASIHTTPRequestDelegate,FFNavbarMenuDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,FileBtnSelectedDelegate>
{

}
@property (nonatomic, strong) NSArray *menuItems;
@property (assign, nonatomic) NSInteger numberOfItemsInRow;
@property (strong, nonatomic) FFNavbarMenu *menu;
@property (strong, nonatomic) FFNavbarMenu *menu1;
@property (nonatomic, assign) BOOL   isMenu;  //区别不同的按钮
@property (nonatomic, assign) BOOL   isNeedSort;//选择的时候relod tableview
@property (nonatomic, strong) UITableView *fileTableView;
@property (nonatomic, strong) NSMutableArray *requestDataArray;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchDisplayController;
@property (nonatomic, strong) NSMutableArray *searchDataSource;
@property (nonatomic, strong) UIView *editView;
@property (nonatomic, strong) UIButton *selectAllBtn;
@property (nonatomic, strong) MJRefreshHeader     *header;

@end

@implementation AllFilesViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    if (_isNeedSort) {
        
        self.navigationController.tabBarController.tabBar.hidden = 1;
        [self.view addSubview:self.editView];
        
    }else {
    
         self.navigationController.tabBarController.tabBar.hidden = !self.isRootVC;
        
    }
   
}

- (FFNavbarMenu *)menu {
    if (nil == _menu) {
        FFNavbarMenuItem *item1 = [FFNavbarMenuItem ItemWithTitle:@"新建文件夹" icon:[UIImage imageNamed:@"0"]];
        FFNavbarMenuItem *item2 = [FFNavbarMenuItem ItemWithTitle:@"新建笔记" icon:[UIImage imageNamed:@"1"]];
        FFNavbarMenuItem *item3 = [FFNavbarMenuItem ItemWithTitle:@"上传照片或视频" icon:[UIImage imageNamed:@"2"]];
        FFNavbarMenuItem *item4 = [FFNavbarMenuItem ItemWithTitle:@"拍摄照片或视频" icon:[UIImage imageNamed:@"3"]];
        _menu = [[FFNavbarMenu alloc] initWithItems:@[item1,item2,item3,item4] width:kScreenWidth maximumNumberInRow:_numberOfItemsInRow];
        _menu.backgroundColor = [UIColor whiteColor];
        _menu.separatarColor = [ConfigUITools colorWithR:164 G:164 B:164 A:1];
        _menu.textColor = [ConfigUITools colorWithR:23 G:116 B:204 A:1];
        _menu.delegate = self;
    }
    return _menu;
}

- (FFNavbarMenu *)menu1 {

    if (nil == _menu1) {
        
        if (self.isRootVC) {
           
            FFNavbarMenuItem *item1 = [FFNavbarMenuItem ItemWithTitle:@"选择" icon:[UIImage imageNamed:@"0"]];
            FFNavbarMenuItem *item2 = [FFNavbarMenuItem ItemWithTitle:@"排序" icon:[UIImage imageNamed:@"1"]];
            FFNavbarMenuItem *item3 = [FFNavbarMenuItem ItemWithTitle:@"更改团队" icon:[UIImage imageNamed:@"2"]];
            _menu1 = [[FFNavbarMenu alloc] initWithItems:@[item1,item2,item3] width:kScreenWidth maximumNumberInRow:_numberOfItemsInRow];
            
        }else {
            
            FFNavbarMenuItem *item1= [FFNavbarMenuItem ItemWithTitle:@"选择" icon:[UIImage imageNamed:@"0"]];
            FFNavbarMenuItem *item2 = [FFNavbarMenuItem ItemWithTitle:@"排序" icon:[UIImage imageNamed:@"1"]];
            FFNavbarMenuItem *item3 = [FFNavbarMenuItem ItemWithTitle:@"删除" icon:[UIImage imageNamed:@"2"]];
            FFNavbarMenuItem *item4= [FFNavbarMenuItem ItemWithTitle:@"移动" icon:[UIImage imageNamed:@"3"]];
            FFNavbarMenuItem *item5 = [FFNavbarMenuItem ItemWithTitle:@"复制" icon:[UIImage imageNamed:@"4"]];
            FFNavbarMenuItem *item6= [FFNavbarMenuItem ItemWithTitle:@"重命名" icon:[UIImage imageNamed:@"5"]];
            FFNavbarMenuItem *item7 = [FFNavbarMenuItem ItemWithTitle:@"协作共享" icon:[UIImage imageNamed:@"2"]];
            FFNavbarMenuItem *item8= [FFNavbarMenuItem ItemWithTitle:@"查看协作人" icon:[UIImage imageNamed:@"0"]];
            FFNavbarMenuItem *item9 = [FFNavbarMenuItem ItemWithTitle:@"分享文件夹" icon:[UIImage imageNamed:@"1"]];
            _menu1 = [[FFNavbarMenu alloc] initWithItems:@[item1,item2,item3,item4,item5,item6,item7,item8,item9] width:kScreenWidth maximumNumberInRow:2];
        
        
        }
        _menu1.backgroundColor = [UIColor whiteColor];
        _menu1.separatarColor = [ConfigUITools colorWithR:164 G:164 B:164 A:1];
        _menu1.textColor = [ConfigUITools colorWithR:23 G:116 B:204 A:1];
        _menu1.delegate = self;
    }
    return _menu1;

}

- (UIView *)editView {

    if (nil == _editView) {
        _editView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 49 - 64, kScreenWidth, 49)];
        _editView.backgroundColor = [UIColor whiteColor];
        NSArray *titleArray = @[@"下载",@"删除",@"移动",@"复制",@"全选",@"取消"];
        CGFloat btnWidth = (kScreenWidth  - 6) / 6;
        for (int i = 0; i < 6; i ++) {
            
            if (i == 4) {
                
                _selectAllBtn = [[UIButton alloc]initWithFrame:CGRectMake(1 + i * (1 + btnWidth ), 1, btnWidth, 47)];
                [_selectAllBtn setTitle:titleArray[i] forState:UIControlStateNormal];
                _selectAllBtn.layer.cornerRadius = 2;
                _selectAllBtn.layer.masksToBounds = 1;
                _selectAllBtn.titleLabel.numberOfLines = 0;
                [_selectAllBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [_selectAllBtn setTitle:@"取消全选" forState:UIControlStateSelected];
                _selectAllBtn.backgroundColor = [ConfigUITools colorWithR:90 G:192 B:246 A:1];
                _selectAllBtn.tag = i + 300;
                [_selectAllBtn addTarget:self action:@selector(selectedBottomBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [_editView addSubview:_selectAllBtn];
                
            }else {
            
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(1 + i * (1 + btnWidth ), 1, btnWidth, 47)];
                [btn setTitle:titleArray[i] forState:UIControlStateNormal];
                btn.layer.cornerRadius = 2;
                btn.layer.masksToBounds = 1;
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ConfigUITools colorWithR:90 G:192 B:246 A:1];
                btn.tag = i + 300;
                [btn addTarget:self action:@selector(selectedBottomBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [_editView addSubview:btn];
            }
            
        }
        
        
    }
    return _editView;
}


  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad {
    [super viewDidLoad];
    if([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.numberOfItemsInRow = 1;
    [self initArray];
    [self configNavBarElementsUI];
    [self.view addSubview:[self configTableView]];

}

- (void)initArray {

    if (nil == _requestDataArray) {
        
        _requestDataArray = [NSMutableArray arrayWithCapacity:0];
    }
   
    NSString *path = [[NSBundle mainBundle] pathForResource:@"stockList" ofType:@"plist"];
    NSArray *fileArray = [NSArray arrayWithContentsOfFile:path];

    for (NSDictionary *dict in fileArray) {

        FileModel *model = [[FileModel alloc]init];
        model.isSelected = NO;
        model.fileName = dict[@"name"];
        [_requestDataArray addObject:model];
    }

    

}
- (void)configNavBarElementsUI {
    
    UIBarButtonItem *rightAddBtn = [[UIBarButtonItem alloc]initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(presentMenuFromNav:)];
    rightAddBtn.tag = 120;
    UIBarButtonItem *rightMoreBtn = [[UIBarButtonItem alloc]initWithTitle:@"More" style:UIBarButtonItemStylePlain target:self action:@selector(presentMenuFromNav:)];
    rightMoreBtn.tag = 121;
    //    rightMoreBtn.image = [UIImage imageNamed:@"more"];
    UIBarButtonItem *fiexd = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fiexd.width = 20;
    self.navigationItem.rightBarButtonItems = @[rightMoreBtn,fiexd,rightAddBtn];
    
    
}

- (UISearchBar *)searchBar
{
    if (_searchBar) {
        return _searchBar;
    }
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    _searchBar.placeholder = @"请输入文件名";
    _searchBar.delegate = self;
    return _searchBar;
}

- (UISearchDisplayController *)searchDisplayController
{
    if (_searchDisplayController) {
        return _searchDisplayController;
    }
    
    _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    _searchDisplayController.searchResultsTableView.dataSource = self;
    _searchDisplayController.searchResultsTableView.delegate = self;
    
    return _searchDisplayController;
}
- (UITableView *)configTableView {


    if (!_fileTableView) {
        
        _fileTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 ) style:UITableViewStylePlain];
        _fileTableView.delegate = self;
        _fileTableView.dataSource = self;
        _fileTableView.contentOffset = CGPointMake(0, 44);
        _fileTableView.backgroundColor = [UIColor colorWithRed:239.0/255 green:237.0/255 blue:244.0/255 alpha:1];
        
    }
    
    
    _fileTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        

        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            [NSThread sleepForTimeInterval:4];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                
                [_fileTableView.mj_header endRefreshing];
                _isNeedSort = 1;
                [_fileTableView reloadData];
                
            });
        });
    }];

    _fileTableView.tableHeaderView = self.searchBar;
    
    return _fileTableView;

}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    if (_fileTableView == tableView) {
        
       return _requestDataArray.count;
    }
    
    return self.searchDataSource.count;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    
    FileTableViewCell *cell = (FileTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[FileTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }

    if (_fileTableView == tableView) {
       cell.model = _requestDataArray[indexPath.row];
    } else {
        cell.model = _searchDataSource[indexPath.row];

    }
    
    cell.isNeedSort = _isNeedSort;
    cell.btnCleckddelegate = self;
    cell.selectionStyle = 3;
    return cell;
}
#pragma mark --tableviewEditdelegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {


    
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //设置删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:0 title:@"删除"handler:^(UITableViewRowAction*action,NSIndexPath *indexPath) {
        
        if (_fileTableView == tableView) {
            
            [_requestDataArray removeObjectAtIndex:indexPath.row];
            
            [_fileTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
            
        }else {
            
            [_searchDataSource removeObjectAtIndex:indexPath.row];
            
            [_searchDisplayController.searchResultsTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
            
        }
        
    }];
    
    //设置收藏按钮
    UITableViewRowAction *collectRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"下载"handler:^(UITableViewRowAction*action,NSIndexPath *indexPath) {

        //dispatch_async(dispatch_get_main_queue(), ^{});
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"下载成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
        
    }];

    deleteRowAction.backgroundColor = [UIColor redColor];
    //    topRowAction.backgroundColor = [UIColor blueColor];
    collectRowAction.backgroundColor = [ConfigUITools colorWithR:88 G:171 B:42 A:1];
    
    return  @[deleteRowAction,collectRowAction];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

     [tableView deselectRowAtIndexPath:indexPath animated:NO];
    AllFilesViewController *allFvc = [[AllFilesViewController alloc]init];
    if (_fileTableView == tableView) {
        
        allFvc.dataSource = self.requestDataArray;
        
    }else {
        
        allFvc.dataSource = self.searchDataSource;
        
    }
    allFvc.isRootVC = NO;
    allFvc.title = [allFvc.dataSource[indexPath.row] fileName];
    NSLog(@"CLICKED : %@",[allFvc.dataSource[indexPath.row] fileName]);
    [self.navigationController pushViewController:allFvc animated:YES];
    
}



- (void)tableViewMoreBtnClickedWithModel:(FileModel *)model {

    NSLog(@"ai ?? - %i",model.isSelected);

    [self sheetViewWithModel:model];

}


#pragma mark - UISearchBarDelegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.searchDataSource = (NSMutableArray *)[[NDSearchTool tool] searchWithFieldArray:@[@"fileName"]
                                                                            inputString:searchText
                                                                                inArray:self.requestDataArray];
    [self.searchDisplayController.searchResultsTableView reloadData];
}




- (void)btnSelected:(UIButton *)btn withModel:(FileModel *)model {
    
    if ([model isKindOfClass:[FileModel class]]) {
        
        
    }
 
    
}
- (void)btnUnSelected:(UIButton *)btn withModel:(FileModel *)model {


    if ([model isKindOfClass:[FileModel class]]) {
        
        
    }
    
}

#pragma mark - 初始化导航 Btn clicked fun

- (void)presentMenuFromNav:(UIButton *)sender
{

    self.navigationController.tabBarController.tabBar.hidden = 1;

    if (sender.tag == 120) {
      
        _isMenu = YES;
        self.navigationItem.rightBarButtonItems[0].enabled = NO;
        if (self.menu.isOpen) {
            [self.menu dismissWithAnimation:YES];
        } else {
            [self.menu showInNavigationController:self.navigationController];
        }
        
    }else if (sender.tag == 121){
    
        _isMenu = NO;
        self.navigationItem.rightBarButtonItems[2].enabled = NO;
        if (self.menu1.isOpen) {
            [self.menu1 dismissWithAnimation:YES];
        } else {
            [self.menu1 showInNavigationController:self.navigationController];
        }
    }else {
    
        
        [self.navigationController popViewControllerAnimated:YES];
    }
  
}


- (void)didSelectedMenu:(FFNavbarMenu *)menu atIndex:(NSInteger)index {
   
    
    if (_isRootVC) { //这里其实是hiden是一直为No的，
        
        self.navigationController.tabBarController.tabBar.hidden = 0;
    }else {
        
        self.navigationController.tabBarController.tabBar.hidden = 1;
    }
    
    
    if (_isMenu) {
        

        
    }else {
    
        if (index == 0) {
//             self.navigationController.tabBarController.tabBar.hidden = 1;
            _isNeedSort = YES;
            [_fileTableView reloadData];
        }
        if (index == 1) {
//             self.navigationController.tabBarController.tabBar.hidden = 0;
            _isNeedSort = NO;
            [_fileTableView reloadData];
        }
    
    }
   
}
- (void)didShowMenu:(FFNavbarMenu *)menu {


}
- (void)didDismissMenu:(FFNavbarMenu *)menu {

    for (UIBarButtonItem *item in self.navigationItem.rightBarButtonItems) {
        
        item.enabled = YES;
    }
    
    if (_isNeedSort) {
        
         self.navigationController.tabBarController.tabBar.hidden = 1;
        [self.view addSubview:self.editView];
        
    }else {
    
        if (_isRootVC) {
            
            self.navigationController.tabBarController.tabBar.hidden = 0;
        }else {
        
            self.navigationController.tabBarController.tabBar.hidden = 1;
        }
        
        [self.editView removeFromSuperview];
    }


}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.editView removeFromSuperview];
    
    if (_isMenu) {
        if (self.menu) {
            [self.menu dismissWithAnimation:NO];
        }
        
    }else {
        if (self.menu1) {
            [self.menu1 dismissWithAnimation:NO];
        }
    }

}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    self.menu = nil;
    self.menu1 = nil;
}


- (void)sheetViewWithModel:(FileModel *)model {
    
    
    CharActionSheet *sheet = [CharActionSheet sheetWithEntry:model buttonTitles:@[@"协作共享", @"查看协作人",@"链接分享",@"重命名",@"移动",@"复制"] redButtonIndex:-1 clicked:^(NSInteger buttonIndex) {
        
        NSLog(@"> Block way -> Clicked Index: %ld", (long)buttonIndex);
        
    } ];
    
    [sheet show];
    
}


- (void)selectedBottomBtnClicked:(UIButton *)sender {

    switch (sender.tag - 300) {
        case 0:
            
            
            break;
        case 1:
            
            
            break;
        case 2:
            
            
            break;
        case 3:
            
            
            break;
        case 4:
        {
            _selectAllBtn.selected = !_selectAllBtn.selected;

            BOOL isSeleAll;
            if (_selectAllBtn.selected) {
                
                isSeleAll = YES;
            }else {
            
                isSeleAll = NO;
            }
            for (FileModel *model in _requestDataArray) {
                
                model.isSelected = isSeleAll;
            }
            _isNeedSort = YES;
            [_fileTableView reloadData];
            
        }
            
            break;
        case 5:
        {
        
            for (FileModel *model in _requestDataArray) {
                
                model.isSelected = NO;
            }
            _isNeedSort = NO;
            _selectAllBtn.selected = NO;
            [_fileTableView reloadData];
            [self.editView removeFromSuperview];
            
            if (_isRootVC) {
                
                self.navigationController.tabBarController.tabBar.hidden = 0;
            }else {
                
                self.navigationController.tabBarController.tabBar.hidden = 1;
            }
            
        }
            break;
            
        default:
            break;
    }
    

}

@end
