//
//  AllFilesViewController.m
//  QXT
//
//  Created by LingLi on 16/3/21.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "AllFilesViewController.h"
#import "MessagesViewController.h"
#import "UzysAssetsPickerController.h"
#import <AVFoundation/AVFoundation.h>
#import "FileTableViewCell.h"
#import "CharActionSheet.h"
#import "FFNavbarMenu.h"
#import "NDSearchTool.h"
#import "EntryModel.h"
#import "IDMPhoto.h"
#import "IDMPhotoBrowser.h"
#import "OtherFileController.h"
@interface AllFilesViewController ()<ASIHTTPRequestDelegate,FFNavbarMenuDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,FileBtnSelectedDelegate,UzysAssetsPickerControllerDelegate,IDMPhotoBrowserDelegate,QXTRequestDelegate>
{
    NSMutableArray  *photos;
    IDMPhotoBrowser *browser;
    NSInteger       indextPhontoDelete;
    QXTRequest      *qxtRequest;
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

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *labelDescription;

@end

@implementation AllFilesViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    indextPhontoDelete = 100;
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
        FFNavbarMenuItem *item3 = [FFNavbarMenuItem ItemWithTitle:@"上传照片" icon:[UIImage imageNamed:@"2"]];
        FFNavbarMenuItem *item4 = [FFNavbarMenuItem ItemWithTitle:@"上传视频" icon:[UIImage imageNamed:@"3"]];
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
                _selectAllBtn.backgroundColor = [ConfigUITools colorWithR:33 G:126 B:198 A:1];
                _selectAllBtn.tag = i + 300;
                [_selectAllBtn addTarget:self action:@selector(selectedBottomBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [_editView addSubview:_selectAllBtn];
                
            }else {
            
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(1 + i * (1 + btnWidth ), 1, btnWidth, 47)];
                [btn setTitle:titleArray[i] forState:UIControlStateNormal];
                btn.layer.cornerRadius = 2;
                btn.layer.masksToBounds = 1;
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btn.backgroundColor = [ConfigUITools colorWithR:33 G:126 B:198 A:1];
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
        self.edgesForExtendedLayout = UIRectEdgeBottom;
    }
    self.numberOfItemsInRow = 1;
    [self initArray];
    [self configNavBarElementsUI];
    [self.view addSubview:[self configTableView]];

    [self getObjListRequestAtLocalData];
}

- (void)initArray {

    if (nil == _dataSource) {
        
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
   
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"stockList" ofType:@"plist"];
//    NSArray *fileArray = [NSArray arrayWithContentsOfFile:path];
//
//    for (NSDictionary *dict in fileArray) {
//
//        EntryModel *model = [[EntryModel alloc]init];
//        model.isSelected = NO;
//        model.fileName = dict[@"name"];
//        [_requestDataArray addObject:model];
//    }
    if (self.isRootVC) {
        
//        for (int i = 0 ; i < 20; i ++) {
//            
//            EntryModel *model = [[EntryModel alloc]init];
//            model.isSelected = NO;
//            NSString *fileName;
//            NSString *fileArtb;
//            NSString *time;
//            NSInteger k = arc4random() % 11 + 1;
//            switch (k) {
//                case 1:
//                    fileName = [NSString stringWithFormat:@"测试笔记_1735.note"];
//                    fileArtb = @"note";
//                    time = @"2013-12-16";
//                    break;
//                    
//                case 2:
//                    fileName = [NSString stringWithFormat:@"测试Txt_12515.txt"];
//                    fileArtb = @"txt";
//                    time = @"2013-10-16";
//                    break;
//                case 3:
//                    fileName = [NSString stringWithFormat:@"关于习大大在莅临灵利的指导.doc"];
//                    fileArtb = @"doc";
//                    time = @"2013-12-16";
//                    break;
//                case 4:
//                    fileName = [NSString stringWithFormat:@"我的图片.jpg"];
//                    fileArtb = @"pic";
//                    time = @"2014-08-09";
//                    break;
//                case 5:
//                    fileName = [NSString stringWithFormat:@"线性规划形成.pdf"];
//                    fileArtb = @"pdf";
//                    time = @"2016-12-07";
//                    break;
//                case 6:
//                    
//                    fileName = [NSString stringWithFormat:@"文件夹的测试"];
//                    fileArtb = @"floder";
//                    time = @"2013-12-16";
//                    break;
//                case 7:
//                    fileName = [NSString stringWithFormat:@"分享文件夹的诞生"];
//                    fileArtb = @"isShareFloder";
//                    time = @"2013-12-26";
//                    break;
//                case 8:
//                    
//                    fileName = [NSString stringWithFormat:@"习大大的工资单.excel"];
//                    fileArtb = @"excel";
//                    time = @"2018-12-16";
//                    break;
//                case 9:
//                    
//                    fileName = [NSString stringWithFormat:@"种子压缩包.zip"];
//                    fileArtb = @"zip";
//                    time = @"2017-03-16";
//                    break;
//                    
//                case 10:
//                    
//                    fileName = [NSString stringWithFormat:@"李克强在灵利的演讲稿.ppt"];
//                    fileArtb = @"ppt";
//                    time = @"2013-12-16";
//                    break;
//                    
//                case 11:
//                    
//                    fileName = [NSString stringWithFormat:@"卧虎藏龙.video"];
//                    fileArtb = @"video";
//                    time = @"2013-12-16";
//                    break;
//                default:
//                    break;
//            }
//            
//            model.fileName = fileName;
//            model.time = time;
//            model.fileAttribute = fileArtb;
//            [_dataSource addObject:model];
//            
//        }
        
        
    }else {
    
    
    
    }
    
    

}
- (void)configNavBarElementsUI {
    
    UIBarButtonItem *rightAddBtn = [[UIBarButtonItem alloc]initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(presentMenuFromNav:)];
//    UIBarButtonItem *rightAddBtn = [[UIBarButtonItem alloc]init];
//    rightAddBtn.image = [UIImage imageNamed:@""]
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
        
       
        _fileTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        if (self.isRootVC) {
            
            _fileTableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64);
            
        }else {
            
             _fileTableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 15);
        }
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
        
       return _dataSource.count;
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
       cell.model = _dataSource[indexPath.row];
    } else {
        cell.model = _searchDataSource[indexPath.row];

    }
    
    cell.isNeedSort = _isNeedSort;
    cell.btnCleckddelegate = self;
    cell.selectionStyle = 3;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 60;
}
#pragma mark --tableviewEditdelegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {


    
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //设置删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:0 title:@"删除"handler:^(UITableViewRowAction*action,NSIndexPath *indexPath) {
        
        if (_fileTableView == tableView) {
            
            [_dataSource removeObjectAtIndex:indexPath.row];
            
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

    if (_fileTableView == tableView) {
        
            EntryModel *tableViewModel = self.dataSource[indexPath.row];

            if ([[tableViewModel isFolder] boolValue]) {//文件夹
                
                AllFilesViewController *allFvc = [[AllFilesViewController alloc]init];
                allFvc.isRootVC = NO;
                allFvc.folderId = tableViewModel.folder_id;
                allFvc.title = [tableViewModel.folder_name stringByDeletingPathExtension];
                [self.navigationController pushViewController:allFvc animated:YES];
                
            }else if ([self isPicWithFileName:tableViewModel.file_name] ) {
                
                
                NSArray *photosWithURL = [IDMPhoto photosWithURLs:[NSArray arrayWithObjects:[NSURL URLWithString:@"http://pic.to8to.com/attch/day_160218/20160218_6410eaeeba9bc1b3e944xD5gKKhPEuEv.png"], @"http://img15.3lian.com/2015/f2/50/d/75.jpg",@"http://g.hiphotos.baidu.com/image/pic/item/241f95cad1c8a7866f726fe06309c93d71cf5087.jpg", @"http://pic9.nipic.com/20100817/3320946_114627281129_2.jpg", nil]];
                
                photos = [NSMutableArray arrayWithArray:photosWithURL];
                
                if (indextPhontoDelete != 100) {
                    
                    [photos removeObjectAtIndex:indextPhontoDelete];
                }
                
                // Create and setup browser
                browser = [[IDMPhotoBrowser alloc] initWithPhotos:photos];
                browser.delegate = self;
                
                browser.actionButtonTitles      = @[@"打开", @"评论", @"分享", @"保存到相册",@"删除"];
                browser.displayCounterLabel     = YES;
                browser.useWhiteBackgroundColor = NO;
                browser.displayArrowButton = NO;
                browser.displayDoneButton = NO;
                browser.doneButtonImage         = [UIImage imageNamed:@"IDMPhotoBrowser_customDoneButton.png"];
                browser.view.tintColor          = [UIColor whiteColor];
                browser.progressTintColor       = [UIColor whiteColor];
                browser.trackTintColor          = [UIColor colorWithWhite:0.8 alpha:1];
                
                [self presentViewController:browser animated:YES completion:nil];
                
            }else {  //文件

                PRETTY_LOG(@"EXTR :%@",[tableViewModel.file_name pathExtension]);
//                OtherFileController *otherVc = [[OtherFileController alloc]init];
//                otherVc.
//
//                [self.navigationController pushViewController:otherVc animated:YES];
                
            }

        
        
      
        
    }else {
    
        EntryModel *searchTableViewModel = self.searchDataSource[indexPath.row];
        
        if ([[searchTableViewModel isFolder] boolValue]) {//文件夹
            
            AllFilesViewController *allFvc = [[AllFilesViewController alloc]init];
            allFvc.isRootVC = NO;
            allFvc.folderId = searchTableViewModel.folder_id;
            allFvc.title = [searchTableViewModel.folder_name stringByDeletingPathExtension];
            [self.navigationController pushViewController:allFvc animated:YES];
            
        }else if ([self isPicWithFileName:searchTableViewModel.file_name] ) {
            
            
            NSArray *photosWithURL = [IDMPhoto photosWithURLs:[NSArray arrayWithObjects:[NSURL URLWithString:@"http://pic.to8to.com/attch/day_160218/20160218_6410eaeeba9bc1b3e944xD5gKKhPEuEv.png"], @"http://img15.3lian.com/2015/f2/50/d/75.jpg",@"http://g.hiphotos.baidu.com/image/pic/item/241f95cad1c8a7866f726fe06309c93d71cf5087.jpg", @"http://pic9.nipic.com/20100817/3320946_114627281129_2.jpg", nil]];
            
            photos = [NSMutableArray arrayWithArray:photosWithURL];
            
            if (indextPhontoDelete != 100) {
                
                [photos removeObjectAtIndex:indextPhontoDelete];
            }
            
            // Create and setup browser
            browser = [[IDMPhotoBrowser alloc] initWithPhotos:photos];
            browser.delegate = self;
            
            browser.actionButtonTitles      = @[@"打开", @"评论", @"分享", @"保存到相册",@"删除"];
            browser.displayCounterLabel     = YES;
            browser.useWhiteBackgroundColor = NO;
            browser.displayArrowButton = NO;
            browser.displayDoneButton = NO;
            browser.doneButtonImage         = [UIImage imageNamed:@"IDMPhotoBrowser_customDoneButton.png"];
            browser.view.tintColor          = [UIColor whiteColor];
            browser.progressTintColor       = [UIColor whiteColor];
            browser.trackTintColor          = [UIColor colorWithWhite:0.8 alpha:1];
            
            [self presentViewController:browser animated:YES completion:nil];
            
        }else {  //文件
            
            //                allFvc.title = [[self.dataSource[indexPath.row] file_name] stringByDeletingPathExtension];
            PRETTY_LOG(@"SEARCHTEXTR :%@",[searchTableViewModel.file_name pathExtension]);
            
        }
        
        

    }
}
#pragma mark --ObjListRequest
- (void)getObjListRequestAtLocalData {

    NSString *url;
    if(_folderId)
    {
        url = [NSString stringWithFormat:@"%@folder/obj/list?folder_id=%@",SERVER_HOST,_folderId];
        
    }else
    {
        url = [NSString stringWithFormat:@"%@folder/obj/list",SERVER_HOST];
    }
    
    NSDictionary *dict = @{@"url":url,@"tag":@"1001"};
     qxtRequest    = [[QXTRequest alloc]init];
    [qxtRequest requestDataByDictionary:dict  requestType:RequestType_ObjList requsetMethod:REQUEST_METHOD_GET delegate:self];
    


}

- (void)requsetFinshedByResponseData:(NSData *)responseData requestType:(RequestType)requestType {

    
    switch (requestType) {
        case RequestType_ObjList:
        {
            
            NSString *dataString = [[NSString alloc] initWithData:responseData
                                                         encoding:NSUTF8StringEncoding];
            SBJSON *jsonParser = [[SBJSON alloc] init];
            
            NSError *parseError = nil;
            NSDictionary * result = [jsonParser objectWithString:dataString
                                                           error:&parseError];
            PRETTY_LOG(@"RequestType_ObjList:%@",result[@"result"]);
            
            PRETTY_LOG(@"###ffff %@",[result[@"result"] class]);
            
            for (NSDictionary *dict in result[@"result"]) {//处理数据模型
                
                
                //        PRETTY_LOG(@"### %@",[dictArray class]);
                
                
                EntryModel *requestModel = [[EntryModel alloc]init];
                
                [requestModel setValuesForKeysWithDictionary:dict];
                requestModel.isSelected = NO;
                PRETTY_LOG(@"### %@",requestModel.action);
                
                [_dataSource addObject:requestModel];
                
                
            }
            
            [_fileTableView reloadData];
            PRETTY_LOG(@"  type %d",requestType);

        }
            break;
        case RequestType_ChangeToken:
        {
            
            NSString *dataString = [[NSString alloc] initWithData:responseData
                                                         encoding:NSUTF8StringEncoding];
            SBJSON *jsonParser = [[SBJSON alloc] init];
            
            NSError *parseError = nil;
            NSDictionary * result = [jsonParser objectWithString:dataString
                                                           error:&parseError];
            PRETTY_LOG(@"RequestType_ChangeToken:%@",result[@"result"]);
            NSObject * obj = [result objectForKey:@"result"];
            if(obj == Nil)
            {
                return;
                
            }
            if( [obj isKindOfClass:[NSDictionary class]] )
            {
                
                PRETTY_LOG(@"classs:%@",result[@"result"]);
                NSDictionary *resultNew = (NSDictionary *)obj;
                NSString *newtoken = [resultNew objectForKey:@"access_token"];
                NSString *newRefreshToken = [resultNew objectForKey:@"refresh_token"];
                [[AppEngineManager sharedInstance]saveRefreshTokenInfoWithAccesstoken:newtoken refreshToken:newRefreshToken];
                [self getObjListRequestAtLocalData];//以上存储完新的token后再请求一次接口
            }
           
        
        }
            break;
        default:
            break;
    }
    
    
    

    

    
    
}

- (void)requestFailedByError:(NSError *)responseError errorCode:(NSInteger)code forRequest:(ASIHTTPRequest *)errorRequest withRequestType:(RequestType)requestType{

    switch (requestType) {
        case RequestType_ObjList:
        {
            
            PRETTY_LOG(@"------------ %@",responseError);
            NSString *dataString = [[NSString alloc] initWithData:[errorRequest responseData]
                                                         encoding:NSUTF8StringEncoding];
            SBJSON *jsonParser = [[SBJSON alloc] init];
            
            NSError *parseError = nil;
            NSDictionary * result = [jsonParser objectWithString:dataString
                                                           error:&parseError];
            PRETTY_LOG(@"errorlt:%@",result);
            NSObject * obj = [result objectForKey:@"result"];
            if(obj == Nil)
            {
                return;
                
            }
            if( [obj isKindOfClass:[NSDictionary class]] )
            {

                
            }else{
                
                NSString *result1 = [result objectForKey:@"result"];
                
                if ([result1 isEqualToString:@"Error: Token has expired"])
                {
                    [qxtRequest changeTokenWithDelegate:self requestType:RequestType_ChangeToken];
                }
                if ([result1 isEqualToString:@"Error: Token is invalid"])
                {
                    [qxtRequest changeTokenWithDelegate:self requestType:RequestType_ChangeToken];
                }
                
                if ([result1 isEqualToString:@"Not expired"])
                {

                }
                if ([result1 isEqualToString:@"expired"])
                {
//                    //置换token
                   
                                 }
            }


        }
            break;
            case RequestType_ChangeToken:
        {
           
            NSString *dataString = [[NSString alloc] initWithData:[errorRequest responseData]
                                                         encoding:NSUTF8StringEncoding];
            SBJSON *jsonParser = [[SBJSON alloc] init];
            
            NSError *parseError = nil;
            NSDictionary * result = [jsonParser objectWithString:dataString
                                                           error:&parseError];
            PRETTY_LOG(@"token:%@",result);
        }
            break;
        default:
            break;
    }
    
    
    



}









- (void)tableViewMoreBtnClickedWithModel:(EntryModel *)model {

    PRETTY_LOG(@"ai ?? - %i",model.isSelected);

    [self sheetViewWithModel:model];

}


#pragma mark - UISearchBarDelegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.searchDataSource = (NSMutableArray *)[[NDSearchTool tool] searchWithFieldArray:@[@"folder_name",@"file_name"]
                                                                            inputString:searchText
                                                                                inArray:self.dataSource];
    [self.searchDisplayController.searchResultsTableView reloadData];
}




- (void)btnSelected:(UIButton *)btn withModel:(EntryModel *)model {
    
    if ([model isKindOfClass:[EntryModel class]]) {
        
        
    }
 
    
}
- (void)btnUnSelected:(UIButton *)btn withModel:(EntryModel *)model {


    if ([model isKindOfClass:[EntryModel class]]) {
        
        
    }
    
}

#pragma mark - IDMPhotoBrowser Delegate

//- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didShowPhotoAtIndex:(NSUInteger)pageIndex
//{
//    id <IDMPhoto> photo = [photoBrowser photoAtIndex:pageIndex];
//    PRETTY_LOG(@"Did show photoBrowser with photo index: %zu, photo caption: %@", pageIndex, photo.caption);
//}
//
//- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser willDismissAtPageIndex:(NSUInteger)pageIndex
//{
//    id <IDMPhoto> photo = [photoBrowser photoAtIndex:pageIndex];
//    PRETTY_LOG(@"Will dismiss photoBrowser with photo index: %zu, photo caption: %@", pageIndex, photo.caption);
//}
//
//- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didDismissAtPageIndex:(NSUInteger)pageIndex
//{
//    id <IDMPhoto> photo = [photoBrowser photoAtIndex:pageIndex];
//    PRETTY_LOG(@"Did dismiss photoBrowser with photo index: %zu, photo caption: %@", pageIndex, photo.caption);
//}

- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didDismissActionSheetWithButtonIndex:(NSUInteger)buttonIndex photoIndex:(NSUInteger)photoIndex
{
    id <IDMPhoto> photo = [photoBrowser photoAtIndex:photoIndex];

//    if (buttonIndex == 4) {//这里是删除用的代码块
//      
//        [browser prepareForClosePhotoBrowser];
//        [browser dismissPhotoBrowserAnimated:YES];
//        indextPhontoDelete = photoIndex;
//    }

    PRETTY_LOG(@"Did dismiss actionSheet with photo index: %zu, photo caption: %@", photoIndex, photo.caption);
    
//    NSString *title = [NSString stringWithFormat:@"Option %zu", buttonIndex+1];

}



#pragma mark - UzysAssetsPickerControllerDelegate methods
- (void)uzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
//    self.imageView.backgroundColor = [UIColor clearColor];
//    DLog(@"assets %@",assets);
//    if(assets.count ==1)
//    {
//        self.labelDescription.text = [NSString stringWithFormat:@"%ld asset selected",(unsigned long)assets.count];
//    }
//    else
//    {
//        self.labelDescription.text = [NSString stringWithFormat:@"%ld assets selected",(unsigned long)assets.count];
//    }
    __weak typeof(self) weakSelf = self;
    if([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) //Photo
    {
        [assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALAsset *representation = obj;
            
            UIImage *img = [UIImage imageWithCGImage:representation.defaultRepresentation.fullResolutionImage
                                               scale:representation.defaultRepresentation.scale
                                         orientation:(UIImageOrientation)representation.defaultRepresentation.orientation];
//            weakSelf.imageView.image = img;
            *stop = YES;
        }];
        
        
    }
    else //Video
    {
        ALAsset *alAsset = assets[0];
        
        UIImage *img = [UIImage imageWithCGImage:alAsset.defaultRepresentation.fullResolutionImage
                                           scale:alAsset.defaultRepresentation.scale
                                     orientation:(UIImageOrientation)alAsset.defaultRepresentation.orientation];
//        weakSelf.imageView.image = img;
        
        
        
        ALAssetRepresentation *representation = alAsset.defaultRepresentation;
        NSURL *movieURL = representation.url;
        NSURL *uploadURL = [NSURL fileURLWithPath:[[NSTemporaryDirectory() stringByAppendingPathComponent:@"test"] stringByAppendingString:@".mp4"]];
        AVAsset *asset      = [AVURLAsset URLAssetWithURL:movieURL options:nil];
        AVAssetExportSession *session =
        [AVAssetExportSession exportSessionWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
        
        session.outputFileType  = AVFileTypeQuickTimeMovie;
        session.outputURL       = uploadURL;
        
        [session exportAsynchronouslyWithCompletionHandler:^{
            
            if (session.status == AVAssetExportSessionStatusCompleted)
            {
                DLog(@"output Video URL %@",uploadURL);
            }
            
        }];
        
    }
    
}

- (void)uzysAssetsPickerControllerDidExceedMaximumNumberOfSelection:(UzysAssetsPickerController *)picker
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:NSLocalizedStringFromTable(@"Exceed Maximum Number Of Selection", @"UzysAssetsPickerController", nil)
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


#pragma mark boolSubject--
- (int)compareOneDayDate:(NSString *)oneDayDate withAnotherDayDate:(NSString *)anotherDayDate
{
    
    
    NSComparisonResult result = [oneDayDate compare:anotherDayDate];
    PRETTY_LOG(@"date1 : %@, date2 : %@", oneDayDate, anotherDayDate);
    if (result == NSOrderedDescending) {
        //PRETTY_LOG(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //PRETTY_LOG(@"Date1 is in the past");
        return -1;
    }
    //PRETTY_LOG(@"Both dates are the same");
    return 0;

    return 1;
}

- (int)compareOneDayStr:(NSString *)oneDayStr withAnotherDayStr:(NSString *)anotherDayStr
{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];//df.dateFormat = @"yyyy-MM-dd HH:mm";
//    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
//    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
//    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"yyyy/MM/dd HH:mm";

    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    PRETTY_LOG(@"date1 : %@, date2 : %@", dateA, dateB);
    if (result == NSOrderedDescending) {
        //PRETTY_LOG(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //PRETTY_LOG(@"Date1 is in the past");
        return -1;
    }
    //PRETTY_LOG(@"Both dates are the same");
    return 0;
    
}

- (BOOL)isPicWithFileName:(NSString *)fileName{

    NSString *str = [fileName stringExestrWithInt:2 forString:fileName];
    if([str isEqualToString:@"jpg"]||[str isEqualToString:@"jpeg"]||[str isEqualToString:@"PNG"]||[str isEqualToString:@"png"]){
    
        return YES;
    }else {
    
        return NO;
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
        
        if (index == 2) {
            
//            self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 50, 200, 200)];
//            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
//            self.imageView.backgroundColor = [UIColor lightGrayColor];
//            self.imageView.center = CGPointMake(self.view.center.x, self.imageView.center.y);
//            [self.view addSubview:self.imageView];
//            
//            self.labelDescription = [[UILabel alloc] initWithFrame:CGRectMake(60, 260, 200, 20)];
//            self.labelDescription.textAlignment = NSTextAlignmentCenter;
//            self.labelDescription.font = [UIFont systemFontOfSize:12];
//            self.labelDescription.textColor = [UIColor lightGrayColor];
//            [self.view addSubview:self.labelDescription];
            
            
            UzysAssetsPickerController *picker = [[UzysAssetsPickerController alloc] init];
            picker.delegate = self;

            picker.maximumNumberOfSelectionVideo = 0;
            picker.maximumNumberOfSelectionPhoto = 5;
//            picker.maximumNumberOfSelectionMedia = 2;
            [self presentViewController:picker animated:YES completion:^{
                
            }];
            
        }
        
        if (index == 3) {
            
//            self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 50, 200, 200)];
//            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
//            self.imageView.backgroundColor = [UIColor lightGrayColor];
//            self.imageView.center = CGPointMake(self.view.center.x, self.imageView.center.y);
//            [self.view addSubview:self.imageView];
//            
//            self.labelDescription = [[UILabel alloc] initWithFrame:CGRectMake(60, 260, 200, 20)];
//            self.labelDescription.textAlignment = NSTextAlignmentCenter;
//            self.labelDescription.font = [UIFont systemFontOfSize:12];
//            self.labelDescription.textColor = [UIColor lightGrayColor];
//            [self.view addSubview:self.labelDescription];
            
            
            UzysAssetsPickerController *picker = [[UzysAssetsPickerController alloc] init];
            picker.delegate = self;

            picker.maximumNumberOfSelectionVideo = 2;
            picker.maximumNumberOfSelectionPhoto = 0;

            [self presentViewController:picker animated:YES completion:^{
                
            }];
            
        }
        

        
    }else {
    
        if (index == 0) {
//             self.navigationController.tabBarController.tabBar.hidden = 1;
            _isNeedSort = YES;
            [_fileTableView reloadData];
        }
        if (index == 2) {
//             self.navigationController.tabBarController.tabBar.hidden = 0;
            _isNeedSort = NO;
            [_fileTableView reloadData];
        }
        if (index == 1) {
            

            NSArray *ARR = [NSArray arrayWithArray:(NSArray *)_dataSource];
            ARR = [ARR sortedArrayUsingComparator:^NSComparisonResult(EntryModel *obj1, EntryModel *obj2) {
                return [self compareOneDayStr:obj1.format_date withAnotherDayStr:obj2.format_date];
            }];
            
            [_dataSource removeAllObjects];
            for (EntryModel *model in ARR) {
                
                [_dataSource addObject:model];
            }

            [_fileTableView reloadData];
            
//            PRETTY_LOG(@"O--  %d",[self compareOneDay:@"2013-06-13" withAnotherDay:@"2013-06-17"]);
//            
//            PRETTY_LOG(@"T--  %d",[self compareOneDay:@"2013-06-20" withAnotherDay:@"2013-06-17"]);
//            
//            PRETTY_LOG(@"TH--  %d",[self compareOneDay:@"2013-06-13" withAnotherDay:@"2013-06-13"]);
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
    if(qxtRequest){
        
        [qxtRequest clearDelegatesAndCancel];
   
    }
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


- (void)sheetViewWithModel:(EntryModel *)model {
    
    
    CharActionSheet *sheet = [CharActionSheet sheetWithEntry:model buttonTitles:@[@"协作共享", @"查看协作人",@"链接分享",@"重命名",@"移动",@"复制"] redButtonIndex:-1 clicked:^(NSInteger buttonIndex) {
        
        PRETTY_LOG(@"> Block way -> Clicked Index: %ld", (long)buttonIndex);
        
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
            for (EntryModel *model in _dataSource) {
                
                model.isSelected = isSeleAll;
            }
            _isNeedSort = YES;
            [_fileTableView reloadData];
            
        }
            
            break;
        case 5:
        {
        
            for (EntryModel *model in _dataSource) {
                
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
