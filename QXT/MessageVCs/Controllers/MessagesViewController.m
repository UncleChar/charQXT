//
//  MessagesViewController.m
//  QXT
/*

 UIImageView * imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"222.jpg"]];
 imageview.userInteractionEnabled = YES;
 imageview.contentMode = UIViewContentModeScaleAspectFit;
 imageview.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth / 421 * 750);
 [self.view addSubview:imageview];
 
 UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
 
 UIVisualEffectView *effectview = [ConfigUITools returnEffictveViewWithFrame:imageview.frame withStyle:1];
 [effectview addGestureRecognizer:tapGesture];
 
 [imageview addSubview:effectview];
 
 
 - (void)tap:(UITapGestureRecognizer *)aa {
 
 
 [aa.view removeFromSuperview];
 
 }

 */
//  Created by LingLi on 16/3/21.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "MessagesViewController.h"
#import "MessageTableViewCell.h"
#import "MessageModel.h"

@interface MessagesViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *messageTableView;
@property (nonatomic, strong) NSMutableArray *messageDataArray;
@end

@implementation MessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"消息";
    [self initArray];
    [self.view addSubview:[self configTableView]];
    
    UIBarButtonItem *rightAddBtn = [[UIBarButtonItem alloc]initWithTitle:@"全标已读" style:UIBarButtonItemStylePlain target:self action:@selector(tagAllReaded:)];

    self.navigationItem.rightBarButtonItem = rightAddBtn;
    

    

    
    
  
}
- (void)initArray {

    if (!_messageDataArray) {
        
        _messageDataArray = [NSMutableArray arrayWithCapacity:0];
    }
    NSArray *dataArray = @[@{@"avatarId":@"13",@"title":@"全新协作方式，分享、讨论、任务指派，让移动工作变得更智慧",@"content":@"我就是我,就是颜色不一样的烟火",@"time":@"2016-03-28"},@{@"avatarId":@"18",@"title":@"花无缺_我就是我,就是颜色不一样的烟",@"content":@"fncafeoqghavabndljvheo;gdfajksfhqiufhq",@"time":@"2016-03-28"},@{@"avatarId":@"6",@"title":@"东方不败",@"content":@"我就是测试一下消息的人",@"time":@"2016-03-28 12:23"},@{@"avatarId":@"18",@"title":@"花无缺_我就是我,就是颜色不一样的烟",@"content":@"fncafeoqghavabndljvheo;gdfajksfhqiufhq",@"time":@"2016-03-28"},@{@"avatarId":@"13",@"title":@"全新协作方式，分享、讨论、任务指派，让移动工作变得更智慧",@"content":@"我就是我,就是颜色不一样的烟火",@"time":@"2016-03-28"},@{@"avatarId":@"18",@"title":@"花无缺_我就是我,就是颜色不一样的烟",@"content":@"fncafeoqghavabndljvheo;gdfajksfhqiufhq",@"time":@"2016-03-28"},@{@"avatarId":@"6",@"title":@"东方不败",@"content":@"我就是测试一下消息的人",@"time":@"2016-03-28 12:23"}];
    for (NSDictionary *dict in dataArray) {
        
         MessageModel *model = [[MessageModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        model.number = @"1";
        [_messageDataArray addObject:model];
    }
   
}

- (UITableView *)configTableView {
    
    
    if (!_messageTableView) {
        
        _messageTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        _messageTableView.delegate = self;
        _messageTableView.dataSource = self;
        
    }
    return _messageTableView;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messageDataArray.count;//
}




-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    MessageTableViewCell* cell = (MessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[MessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.model = _messageDataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (void)tagAllReaded:(UIButton *)sender {


    for (MessageModel *model in _messageDataArray) {
        
        model.number = @"0";
    }
    [_messageTableView reloadData];
    UIViewController *vc =  [AppEngineManager sharedInstance].viewVCArrary[0];
    vc.tabBarItem.badgeValue = nil;
    [SVProgressHUD showSuccessWithStatus:@"标记成功"];

}

@end
