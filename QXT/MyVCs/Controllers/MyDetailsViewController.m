//
//  MyDetailsViewController.m
//  QXT
//
//  Created by LingLi on 16/3/21.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "MyDetailsViewController.h"
#import "AboutMyTableViewCell.h"
#import "QYTableViewHeader.h"
#import "QYNavigationBar.h"
#import "OtherJumpVc.h"

#define kBgH      kScreenHeight / 3
#define KLevelH  (kScreenHeight / 3 - 64) / 4
#define kLabelAlpha  0.9
@interface MyDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    NSArray  *titleArray;
    NSArray  *picArray;

}
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)QYTableViewHeader* headView;
@property(nonatomic,strong)UIImageView* bigImageView;

@property (nonatomic, strong) UIView *NavbgImg;
@end

@implementation MyDetailsViewController

-(UITableView*)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49)];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    
    
//    titleArray = @[@"我的离线文件",@"我的团队",@"设置",@"清空缓存",@"我的XXX",@"我的XX11XXXX",@"我的XX22XXXX",@"我的XX33XXXX",@"我的XX44XXXX"];
    
    titleArray = [[NSMutableArray alloc]initWithObjects:@"最近讨论",@"传输列表",@"离线列表",@"回收中心",@"我的团队",@"系统设置",@"",@"退出登录", nil];
    picArray = [[NSMutableArray alloc]initWithObjects:@"main_menu_comment_btn@2x.png",@"main_menu_transfer_icon.png",@"iPhone_main_menu_offline_icon@2x.png",@"main_menu_recycle_icon.png",@"main_menu_btn_team@2x.png",@"main_menu_setting_icon.png",@"main_menu_recycle_icon.png",@"main_menu_logout_icon.png", nil];
    
    
    [self.view addSubview: self.tableView];
    
    [self configHeaderItems];

    [self navigationCustomBar];
    
}

- (UIView *)navigationCustomBar {

//    self.navigationController.navigationBarHidden = YES;
    self.NavbgImg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    self.NavbgImg.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.NavbgImg];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 80, 20, 160, 44)];
    titleLabel.text = @"关于我";
    titleLabel.textAlignment = 1;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    [self.NavbgImg addSubview:titleLabel];
    
    return self.NavbgImg;
}

- (void)configHeaderItems {
    
    _bigImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kBgH)];
    _bigImageView.image=[UIImage imageNamed:@"1212.jpg"];
    _bigImageView.clipsToBounds=YES;
    //    _bigImageView.alpha = 0.7;
    _bigImageView.contentMode = UIViewContentModeScaleAspectFill;
    UIImageView* smallView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    smallView.image=[UIImage imageNamed:@"adeleAva.jpg"];
    smallView.center=CGPointMake(60, _bigImageView.center.y);
    smallView.clipsToBounds=YES;
    smallView.contentMode=UIViewContentModeScaleAspectFill;
    
    UILabel *naLabe = [[UILabel  alloc]initWithFrame:CGRectMake(120, 64, kScreenWidth - 120, KLevelH)];
    naLabe.backgroundColor = [UIColor clearColor];
    naLabe.text = @"解海龙(灵利科技)";
    naLabe.font = [UIFont systemFontOfSize:15];
    naLabe.alpha = kLabelAlpha;
    naLabe.textColor = [UIColor whiteColor];
    [_bigImageView addSubview:naLabe];
    
    UILabel *phoneLabel = [[UILabel  alloc]initWithFrame:CGRectMake(120, CGRectGetMaxY(naLabe.frame), kScreenWidth - 140, KLevelH)];
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.text = @"手机号:18888888888";
    phoneLabel.font = [UIFont systemFontOfSize:13];
    phoneLabel.alpha = kLabelAlpha;
    phoneLabel.textColor = [UIColor whiteColor];
    [_bigImageView addSubview:phoneLabel];
    
    UILabel *emailLabel = [[UILabel  alloc]initWithFrame:CGRectMake(120, CGRectGetMaxY(phoneLabel.frame), kScreenWidth - 120, KLevelH)];
    emailLabel.backgroundColor = [UIColor clearColor];
    emailLabel.text = @"邮箱:xhljob@sharpinteract.com";
    emailLabel.font = [UIFont systemFontOfSize:13];
    emailLabel.alpha = kLabelAlpha;
    emailLabel.textColor = [UIColor whiteColor];
    [_bigImageView addSubview:emailLabel];
    
    UIView *spaceProgressView = [[UIView alloc]initWithFrame:CGRectMake(120, CGRectGetMaxY(emailLabel.frame) + KLevelH / 2 - 4, kScreenWidth - 160, 8)];
    spaceProgressView.layer.cornerRadius = 4;
    spaceProgressView.layer.masksToBounds = 1;
    spaceProgressView.alpha = kLabelAlpha;
    spaceProgressView.backgroundColor = [UIColor whiteColor];
    [_bigImageView addSubview:spaceProgressView];
    
    UIView *usedspaceProgressView = [[UIView alloc]initWithFrame:CGRectMake(120, CGRectGetMaxY(emailLabel.frame) + KLevelH / 2 - 4, CGRectGetWidth(spaceProgressView.frame)*0.36, 8)];
    usedspaceProgressView.layer.cornerRadius = 4;
    usedspaceProgressView.layer.masksToBounds = 1;
    usedspaceProgressView.alpha = kLabelAlpha;
    usedspaceProgressView.backgroundColor = [ConfigUITools colorWithR:30 G:199 B:91 A:1];
    [_bigImageView addSubview:usedspaceProgressView];
    
    _headView=[[QYTableViewHeader alloc]init];
    [_headView goodMenWithTableView:self.tableView andBackGroundView:_bigImageView andSubviews:smallView];
    self.automaticallyAdjustsScrollViewInsets = NO;

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    AboutMyTableViewCell* cell = (AboutMyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        
        cell = [[AboutMyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }

    if (indexPath.row == 6) {
        
        cell.name = [NSString stringWithFormat:@"清空缓存(%.2lf MB)",[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0];
        cell.avatarStr = picArray[indexPath.row];
        
    }else {
    
        cell.name = titleArray[indexPath.row];
        cell.avatarStr = picArray[indexPath.row];
    
    }
    

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    if (indexPath.row == 6) {
        
        [[SDImageCache sharedImageCache] clearDisk];
        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"清除%.2lf MB缓存",[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0]];
        [_tableView reloadData];
    }else {
    
        OtherJumpVc *otvc = [[OtherJumpVc alloc]init];
        otvc.title = titleArray[indexPath.row];
        [self.navigationController pushViewController:otvc animated:YES];
        
    
    }
    
}




-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_headView scrollViewDidScroll:scrollView];
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
//    if (offsetY < -1) {
//        if (offsetY > -100) {
//            //修改本地
//
////            self.NavbgImg.hidden = YES;
//        }
//    }
    //导航栏
    if (offsetY > -19) {
        
        if (offsetY < (kBgH - 64)) {
            self.NavbgImg.hidden = NO;
            
            self.NavbgImg.backgroundColor = [ConfigUITools colorWithR:33 G:126 B:198 A:offsetY/(kBgH - 64)];
        }
        else{
            self.NavbgImg.backgroundColor = [ConfigUITools colorWithR:33 G:126 B:198 A:1];
            
            self.NavbgImg.hidden = NO;
        }
        
    }else{
//        self.NavbgImg.hidden = YES;
        
    }

    
}


-(void)viewDidLayoutSubviews
{
    [_headView resizeView];
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewWillAppear:(BOOL)animated {


    [super viewWillAppear:YES];
    if (_tableView) {
        
        [_tableView reloadData];
    }
     self.navigationController.navigationBarHidden = YES;
}
@end
























/*
 //
 //  AllFilesViewController.m
 //  QXT
 //   
 if( ([[[UIDevice currentDevice] systemVersion] doubleValue]<=7.0))
 {
 self.navigationController.navigationBar.translucent = 0;
 }else {
 self.navigationController.navigationBar.translucent = 1;
 
 }
 //  Created by LingLi on 16/3/21.
 //  Copyright © 2016年 LINGLI. All rights reserved.
 //
 
 #import "AllFilesViewController.h"
 
 @interface AllFilesViewController ()<ASIHTTPRequestDelegate>
 {
 
 ASIHTTPRequest *request;
 UIProgressView *pp;
 }
 @end
 
 @implementation AllFilesViewController
 
 - (void)viewDidLoad {
 [super viewDidLoad];
 self.view.backgroundColor = [UIColor whiteColor];
 self.title = @"所有文件";
 
 self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_menu"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(presentMenuFromNav:)];
 self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(presentMenuFromNav:)];
 
 
 
 
 pp = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 80, kScreenWidth, 4)];
 pp.backgroundColor = [UIColor redColor];
 [self.view addSubview:pp];
 UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
 [btn setTitle:@"下载" forState:UIControlStateNormal];
 btn.backgroundColor = [UIColor redColor];
 [self.view addSubview:btn];
 [btn addTarget:self action:@selector(resumeInterruptedDownload:) forControlEvents:UIControlEventTouchUpInside];
 
 UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 100, 100)];
 [btn1 setTitle:@"暂停" forState:UIControlStateNormal];
 btn1.backgroundColor = [UIColor redColor];
 [self.view addSubview:btn1];
 [btn1 addTarget:self action:@selector(pauseDownload) forControlEvents:UIControlEventTouchUpInside];
 
 
 
 //    [self resumeInterruptedDownload:nil];
 }
 
 
 
 - (void)resumeInterruptedDownload:(id)sender
 {
 
 
 
 UIViewController *vc =  [AppEngineManager sharedInstance].viewVCArrary[0];
 
 NSLog(@"vc   START  %@",vc);
 vc.tabBarItem.badgeValue = @"23";
 
 NSURL *url = [NSURL URLWithString:
 @"http://120.25.226.186:32812/resources/videos/minion_01.mp4"];
 request = [ASIHTTPRequest requestWithURL:url];
 
 NSString *downloadPath = @"/Users/lingli/Desktop/AA/000.mp4";
 [request setDownloadProgressDelegate:pp];
 request.showAccurateProgress = YES;
 //当request完成时，整个文件会被移动到这里
 [request setDownloadDestinationPath:downloadPath];
 request.delegate = self;
 //这个文件已经被下载了一部分
 [request setTemporaryFileDownloadPath:@"/Users/lingli/Desktop/AA/BB/000.mp4.download"];
 [request setAllowResumeForFileDownloads:YES];
 [request startAsynchronous];
 
 //整个文件将会在这里
 NSString *theContent = [NSString stringWithContentsOfFile:downloadPath];
 }
 
 
 - (void)requestFinished:(ASIHTTPRequest *)request {
 
 
 PRETTY_LOG(@"ok  ");
 }
 
 - (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
 {
 NSLog(@"%@",responseHeaders);
 //    if (![responseHeaders objectForKey:@"Content-Range"]) {
 //
 ////        [[NSUserDefaults standardUserDefaults]objectForKey:[responseHeaders objectForKey:@"Content-Length"]];
 //        [[NSUserDefaults standardUserDefaults]setObject:[responseHeaders objectForKey:@"Content-Length"] forKey:@"11"];
 //    }else {
 //
 //
 //        [[NSUserDefaults standardUserDefaults]setObject:[responseHeaders objectForKey:@"Content-Length"] forKey:@"11"];
 //
 //
 //    }
 }
 //- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data {
 //
 //
 //}
 
 //最后，便是暂停
 - (void)pauseDownload
 {
 UIViewController *vc =  [AppEngineManager sharedInstance].viewVCArrary[0];
 
 NSLog(@"vc   PUSDS  %@",vc);
 vc.tabBarItem.badgeValue = @"17";
 //operations方法返回队列里的所有请求，但我们只有一个请求
 //    //    ASIHTTPRequest *request = [[queue operations] objectAtIndex:0];
 //    NSArray *tempRequestList=[queue operations];
 //    for (ASIHTTPRequest *request in tempRequestList) {
 //        //取消请求
 [request clearDelegatesAndCancel];
 NSLog(@"--- %@",request.responseHeaders);
 //    }
 }
 /**
 *  本文为大家介绍了iOS开发ASIHTTPRequest断点续传(下载)的内容，其中包括ASIHTTPRequest可以恢复中断的下载，设置一个临时下载路径，断点续传的工作原理等等内容。
 
 从0.94版本开始，ASIHTTPRequest可以恢复中断的下载。
 
 这个特性只对下载数据到文件中有效，你必须为一下情况的request设置allowResumeForFileDownloads 为YES：
 
 任何你希望将来可以断点续传的下载（否则，ASIHTTPRequest会在取消或者释放内存时将临时文件删除）
 任何你要进行断点续传的下载
 另外，你必须自己设置一个临时下载路径（setTemporaryFileDownloadPath），这个路径是未完成的数据的路径。新的数据将会被添加到这个文件，当下载完成时，这个文件将被移动到downloadDestinationPath 。
 
 
 
 断点续传的工作原理是读取temporaryFileDownloadPath的文件的大小，并使用Range: bytes=x HTTP头来请求剩余的文件内容。
 
 ASIHTTPRequest并不检测是否存在Accept-Ranges头（因为额外的HEAD头请求会消耗额外的资源），所以只有确定服务器支持断点续传下载时，再使用这个特性。
 */
//
//
//
//@end
//
//*/
