//
//  AllContactsViewController.m
//  QXT
//
//  Created by LingLi on 16/3/21.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "AllContactsViewController.h"

#import "ContactTableViewCell.h"
#import "ContactDetailInfoVC.h"
#import "NDSearchTool.h"
#import "ContactModel.h"
@interface AllContactsViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSMutableDictionary  *_dict;            //索引的字典  key:@“X” value:[@"希尔巴兹雷利",@"香克斯",@"小胖"]
    NSMutableDictionary  *_sdict;
    NSMutableDictionary  *_contactDict;     // key:model  value:model.name
    NSMutableDictionary  *_searchDict;
    NSMutableArray       *_indexTitleArr;        //title    @[@"组",@"A",@"C",@"D",.....] 已经排序
    NSMutableArray       *_indexSearchTitleArr;
    
    NSMutableDictionary  *_ldict;
    NSMutableDictionary  *_lsdict;
    NSMutableDictionary  *_localDict;
    NSMutableDictionary  *_localSearchDict;
    NSMutableArray       *_indexLocalTitleArr;
    NSMutableArray       *_indexLocalSearchTitleArr;
    
}
@property (nonatomic, strong) UISegmentedControl        *segmentedControl;
@property (nonatomic, strong) UISearchBar               *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchDisplayController;
@property (nonatomic, strong) NSMutableArray            *searchDataSource;

@property (nonatomic, strong) NSMutableArray            *localDataSource;
@property (nonatomic, assign) NSInteger                 *segmentedPageIndex;
@property (nonatomic, strong) NSMutableDictionary       *contactDict;
@property (nonatomic, strong) NSMutableDictionary       *searchDict;
@property (nonatomic, strong) UITableView               *contactTableView;
@end

@implementation AllContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [ConfigUITools colorWithR:90 G:192 B:246 A:1];
    self.title = @"同事";
    _segmentedPageIndex = 0;         //标记是本地联系人还是网络联系人
    [self initArray];
    [self configSegumentController]; 
    [self.view addSubview:self.searchBar];
    [self.view addSubview:[self configTableView]];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(addContactBtnClicked:)];
    rightItem.image = [UIImage imageNamed:@"Contact_Male@2x"];//add_friend_icon@2x
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}

- (void)initArray {

    _requestDataSource = [NSMutableArray arrayWithCapacity:0];//联系人数据
    _contactDict = [NSMutableDictionary dictionary];//联系人字典
    _searchDict = [NSMutableDictionary dictionary];//搜索字典
    _localDict = [NSMutableDictionary dictionaryWithCapacity:0];//本地的字典
    _localSearchDict = [NSMutableDictionary dictionaryWithCapacity:0];//本地搜索后的字典
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    _searchDataSource = [NSMutableArray arrayWithCapacity:0];//作为所有搜索后的结果数组
    NSArray *modelArray;
    if (_isNotRootVC) {//这里暂时模拟进入分组的数组
        
          modelArray = @[@{@"portrait":@"xjp.jpg",@"name":@"习近平"},@{@"portrait":@"lkq.jpg",@"name":@"李克强"},@{@"portrait":@"bxl.jpg",@"name":@"薄熙来"},@{@"portrait":@"bgkl.jpg",@"name":@"薄谷开来"},@{@"portrait":@"ylq.jpg",@"name":@"叶利钦"},@{@"portrait":@"abm.jpg",@"name":@"奥巴马"},@{@"portrait":@"qjb.jpg",@"name":@"温家宝"}];
        
    }else {
        
          modelArray = @[@{@"portrait":@"12",@"name":@"125"},@{@"portrait":@"2",@"name":@"多弗朗明哥"},@{@"portrait":@"3",@"name":@"蒙奇.D.多拉格"},@{@"portrait":@"4",@"name":@"乌索普"},@{@"portrait":@"5",@"name":@"弗兰奇"},@{@"portrait":@"6",@"name":@"西尔巴兹.雷利"},@{@"portrait":@"13",@"name":@"诺诺罗亚.卓洛"},@{@"portrait":@"8",@"name":@"乔巴"},@{@"portrait":@"9",@"name":@"波斯卡帝.D.艾斯"},@{@"portrait":@"10",@"name":@"陈晨"},@{@"portrait":@"11",@"name":@"多多"},@{@"portrait":@"12",@"name":@"峨嵋山"},@{@"portrait":@"7",@"name":@"山治"},@{@"portrait":@"14",@"name":@"香克斯"},@{@"portrait":@"15",@"name":@"罗宾"},@{@"portrait":@"16",@"name":@"58赶集"},@{@"portrait":@"17",@"name":@"搜房网"},@{@"portrait":@"18",@"name":@"欧弟"},@{@"portrait":@"19",@"name":@"小胖"},@{@"portrait":@"20",@"name":@"蒙奇.D.路飞"},@{@"portrait":@"21",@"name":@"鸣人"},@{@"portrait":@"22",@"name":@"佐助"},@{@"portrait":@"23",@"name":@"自来也"},@{@"portrait":@"section.jpg",@"name":@"灵利技术部"},@{@"portrait":@"section.jpg",@"name":@"国务院"},@{@"portrait":@"section.jpg",@"name":@"作战指挥部"}];
    
    }
  
   
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"stockList" ofType:@"plist"];
//    NSArray *fileArray = [NSArray arrayWithContentsOfFile:path];
//    
    for (NSDictionary *dict in modelArray) {
        
        ContactModel *model = [[ContactModel alloc]init];
        model.isSelected = NO;
        model.avatarId = [dict objectForKey:@"portrait"];

        if ([model.avatarId integerValue]%2 == 0) {
            model.sex = YES;
        }else {
        
            model.sex = NO;
        }
        model.fileName = dict[@"name"];
        model.email = [[NSString stringWithFormat:@"%@@126.com",[ChineseToPinyin pinyinFromChiniseString:model.fileName]] lowercaseString];
        [_requestDataSource addObject:model];
        [_contactDict setObject:model forKey:model.fileName];
    }
    
    _dict = [NSMutableDictionary dictionary];//索引用的
    _indexTitleArr = [NSMutableArray arrayWithCapacity:0];

    [self handleUserData:_requestDataSource forTitleArray:_indexTitleArr sortDict:_dict bySearchDict:nil];

}



- (void)configSegumentController {
    
    NSArray *items                                         = @[@"全携通联系人",@"手机通讯录"];
    self.segmentedControl                                  = [[UISegmentedControl alloc] initWithItems:items];
    self.segmentedControl.selectedSegmentIndex             = 0;
    self.navigationItem.titleView                          = self.segmentedControl;
    [self.segmentedControl addTarget:self
                              action:@selector(segmentAction:)
                    forControlEvents:UIControlEventValueChanged];
    
    [self.segmentedControl setTintColor:[UIColor whiteColor]];
    

    
}

- (UISearchBar *)searchBar
{
    if (_searchBar) {
        return _searchBar;
    }
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    _searchBar.placeholder = @"请输入联系人中文名";
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
    
    [self.view addSubview:self.searchBar];
    if (!_contactTableView) {
        
        _contactTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight - 64 - 44 - 49 ) style:0];
        _contactTableView.delegate = self;
        _contactTableView.dataSource = self;
//        _contactTableView.contentOffset = CGPointMake(0, 44);
        
    }
    return _contactTableView;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    if (tableView == _contactTableView) {
        
        if (_segmentedPageIndex == 0) {
            
            return _dict.count;
        }else {
        
            return _ldict.count;
        }
        
        
    }else {
        
        if (_segmentedPageIndex == 0) {
            
         return _sdict.count;
        }
        return _lsdict.count;
        
    }
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_contactTableView == tableView) {
        
        if (_segmentedPageIndex == 0) {
            
            return [_dict[_indexTitleArr[section]] count];
        }else {
        
            return [_ldict[_indexLocalTitleArr[section]] count];
        }
        
    }else {
    
        if (_segmentedPageIndex == 0) {
            
            return [_sdict[_indexSearchTitleArr[section]] count];
        }
            return [_lsdict[_indexLocalSearchTitleArr[section]] count];
    
    }
   
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    if (tableView == _contactTableView) {
        
        if (_segmentedPageIndex == 0) {
           
            return _indexTitleArr;
            
        }else {
        
            return _indexLocalTitleArr;
        }
        
        
    }else {
    
        if (_segmentedPageIndex == 0) {
            
            return _indexSearchTitleArr;
        }
    
            return _indexLocalSearchTitleArr;
        
    }
   
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (tableView == _contactTableView) {
        if (_segmentedPageIndex == 0) {
            
            return _indexTitleArr[section];
        }else {
        
           return _indexLocalTitleArr[section];
        }
       
        
    }else {
        
        if (_segmentedPageIndex == 0) {
            
          return _indexSearchTitleArr[section];
        }
         return _indexLocalSearchTitleArr[section];
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {


    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
}


#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    
    ContactTableViewCell *cell = (ContactTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[ContactTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if (_contactTableView == tableView) {
        
        if (_segmentedPageIndex == 0) {
            NSString *str = _indexTitleArr[indexPath.section];
            cell.model =  [_contactDict objectForKey: [_dict objectForKey:str][indexPath.row]];
            
        }else {
        
            NSString *str = _indexLocalTitleArr[indexPath.section];
            cell.model =  [_localDict objectForKey: [_ldict objectForKey:str][indexPath.row]];
            
        }
        
    } else {

        if (_segmentedPageIndex == 0) {
            NSString *str = _indexSearchTitleArr[indexPath.section];
            cell.model =  [_searchDict objectForKey: [_sdict objectForKey:str][indexPath.row]];
            
        }else {
            
            NSString *str = _indexLocalSearchTitleArr[indexPath.section];
            cell.model =  [_localSearchDict objectForKey: [_lsdict objectForKey:str][indexPath.row]];
            
        }
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//cell的右边有一个小箭头，距离右边有十几像素；
    
//    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;//cell右边有一个蓝色的圆形button；
    
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;//cell右边的形状是对号；
    cell.selectionStyle = 3;
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ContactModel *model;
//    =  [_contactDict objectForKey: [_dict objectForKey:str][indexPath.row]];
  
//    if ([model.avatarId isEqualToString:@"022"]) {
//       
//                    AllContactsViewController *allConVC = [[AllContactsViewController alloc]init];
//                    allConVC.isNotRootVC = YES;
//                    [self.navigationController pushViewController:allConVC animated:YES];
//        
//        } else {
    
    if (_contactTableView == tableView) {
        
        
        if (_segmentedPageIndex == 0) {
            
            NSString *str = _indexTitleArr[indexPath.section];
            model =  [_contactDict objectForKey: [_dict objectForKey:str][indexPath.row]];
            
            if ([model.avatarId isEqualToString:@"section.jpg"]) {
        
                            AllContactsViewController *allConVC = [[AllContactsViewController alloc]init];
                            allConVC.isNotRootVC = YES;
                            [self.navigationController pushViewController:allConVC animated:YES];
                
            }else {
                ContactDetailInfoVC *Convc = [[ContactDetailInfoVC alloc]init];
                Convc.model = model;
                [self.navigationController pushViewController:Convc animated:YES];
            
            }
           
            
            
            
        }else {
            
            NSString *str = _indexLocalTitleArr[indexPath.section];
            model =  [_localDict objectForKey: [_ldict objectForKey:str][indexPath.row]];

            ContactDetailInfoVC *Convc = [[ContactDetailInfoVC alloc]init];
            Convc.model = model;
            [self.navigationController pushViewController:Convc animated:YES];

  
        }

        
    }else {
    
        if (_segmentedPageIndex == 0) {
            
            NSString *str = _indexSearchTitleArr[indexPath.section];
            model =  [_searchDict objectForKey: [_sdict objectForKey:str][indexPath.row]];
            
            if ([model.avatarId isEqualToString:@"section.jpg"]) {
                
                AllContactsViewController *allConVC = [[AllContactsViewController alloc]init];
                allConVC.isNotRootVC = YES;
                [self.navigationController pushViewController:allConVC animated:YES];
                
            }else {
                ContactDetailInfoVC *Convc = [[ContactDetailInfoVC alloc]init];
                Convc.model = model;
                [self.navigationController pushViewController:Convc animated:YES];
                
            }
            
        }else {
            
            NSString *str = _indexLocalSearchTitleArr[indexPath.section];
            model =  [_localSearchDict objectForKey: [_lsdict objectForKey:str][indexPath.row]];
            
            ContactDetailInfoVC *Convc = [[ContactDetailInfoVC alloc]init];
            Convc.model = model;
            [self.navigationController pushViewController:Convc animated:YES];
            
            
        }
    
    }
    
//        }

    
}

#pragma mark - UISearchBarDelegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (_segmentedPageIndex == 0) {
      
        self.searchDataSource = (NSMutableArray *)[[NDSearchTool tool] searchWithFieldArray:@[@"fileName",@"email"]
                                                                                inputString:searchText
                                                                                    inArray:self.requestDataSource];

        _sdict = [NSMutableDictionary dictionary];
        _indexSearchTitleArr = [[NSMutableArray alloc]init];
        [self handleUserData:self.searchDataSource forTitleArray:_indexSearchTitleArr sortDict:_sdict bySearchDict:_searchDict];
   
    }else {
    
        self.searchDataSource = (NSMutableArray *)[[NDSearchTool tool] searchWithFieldArray:@[@"fileName",@"email"]
                                                                                inputString:searchText
                                                                                    inArray:self.localDataSource];
        _lsdict = [NSMutableDictionary dictionary];
        _indexLocalSearchTitleArr = [[NSMutableArray alloc]init];
        [self handleUserData:self.searchDataSource forTitleArray:_indexLocalSearchTitleArr sortDict:_lsdict bySearchDict:_localSearchDict];

    }

    [self.searchDisplayController.searchResultsTableView reloadData];
}

- (void)handleUserData:(NSMutableArray *)userDataArr forTitleArray:(NSMutableArray *)titleArray sortDict:(NSMutableDictionary *)dict bySearchDict:(NSMutableDictionary *)searchDict{
    
    NSArray *arr = [NSArray array];
    NSMutableArray *indezeroArr = [[NSMutableArray alloc]init];

    
    for (ContactModel *model in userDataArr) {
        
        if (searchDict) {
            
            [searchDict setObject:model forKey:model.fileName]; //这里负责处理搜索的时候再添加model
        }

       
//
        if ([model.avatarId isEqualToString:@"section.jpg"]) {
                
//            NSMutableArray *namesArr = dict[[NSString stringWithFormat:@"%c",[ChineseToPinyin sortSectionTitle:model.fileName]]];
            [indezeroArr addObject:model.fileName];
            
        }else {
        
            NSMutableArray *namesArr = dict[[NSString stringWithFormat:@"%c",[ChineseToPinyin sortSectionTitle:model.fileName]]];
            if (namesArr) {
                
                [namesArr addObject:model.fileName];
                
            }else {
                
                namesArr = [NSMutableArray arrayWithCapacity:0];
                [namesArr addObject:model.fileName];
                [dict setObject:namesArr forKey:[NSString stringWithFormat:@"%c",[ChineseToPinyin sortSectionTitle:model.fileName]]];
            }
           
            
        }


    }
    
    if (_segmentedPageIndex == 0 && (indezeroArr.count > 0)) {
        
        [dict setObject:indezeroArr forKey:@"组"];
    }
    arr = [dict allKeys];
    
    arr = [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
    for (NSString *keyStr in arr) {
        
        [titleArray addObject:keyStr];
    }

    if (_segmentedPageIndex == 0 && (indezeroArr.count > 0) ) {
        
        [titleArray insertObject:@"组" atIndex:0];
    }
    
    
}

-(void)segmentAction:(UISegmentedControl *)Seg{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    
    switch (Index) {
        case 0:
            
            _segmentedPageIndex = 0;
            [_contactTableView reloadData];
            
            
            break;
        case 1:
        {
            _segmentedPageIndex = 1;
            if (nil == _localDataSource) {
                
                _localDataSource = [NSMutableArray arrayWithCapacity:0];
                
                NSArray *contactsArr = @[@"张飞",@"赵云",@"曹丕",@"关羽",@"曹操",@"刘备",@"孙权",@"小乔",@"周瑜",@"大乔",@"诸葛亮",@"孙策",@"许褚",@"周瑜"];
                for (NSString *name in contactsArr) {
                    
                    ContactModel *model = [[ContactModel alloc]init];
                    model.fileName = name;
                    model.avatarId = [NSString stringWithFormat:@"%d",arc4random()%18 + 1] ;
                    [_localDataSource addObject:model];
                    [_localDict setObject:model forKey:model.fileName];
                }
                
                _ldict = [NSMutableDictionary dictionary];
                _indexLocalTitleArr = [NSMutableArray arrayWithCapacity:0];
                [self handleUserData:_localDataSource forTitleArray:_indexLocalTitleArr sortDict:_ldict bySearchDict:nil];
            }

            [_contactTableView reloadData];
    }
            break;
            
        default:
            break;
    }
    
}

- (void)ww {

//    [self.navigationController pushViewController:[[NDDefaultSearchViewController alloc]init] animated:YES];
}

- (void)addContactBtnClicked:(UIButton *)sender {

    [SVProgressHUD showSuccessWithStatus:@"将要增加联系人"];
}

@end
