
#import "MainTabBarController.h"
#import "AllFilesViewController.h"
#import "MessagesViewController.h"
#import "AllContactsViewController.h"
#import "MyDetailsViewController.h"
#import "QYNavigationController.h"

@interface MainTabBarController ()<UITabBarDelegate,UITabBarControllerDelegate>
{

}

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.delegate = self;
    [self createSubViewControllers];

    [self setTabBarItems];
   

}




- (void)createSubViewControllers {

    AllFilesViewController *limitVC = [[AllFilesViewController alloc]init];
    limitVC.isRootVC = YES;
    limitVC.title = @"所有文件";
//    limitVC.userType = self.userType;
    UINavigationController *limitNav = [[UINavigationController alloc]initWithRootViewController:limitVC];
//    [[AppEngineManager sharedInstance].viewVCArrary addObject:limitNav];
    
    MessagesViewController  *saleVC = [[MessagesViewController alloc]init];
    UINavigationController *saleNav = [[UINavigationController alloc]initWithRootViewController:saleVC];
    [[AppEngineManager sharedInstance].viewVCArrary addObject:saleNav];
    
    AllContactsViewController  *sale = [[AllContactsViewController alloc]init];
    UINavigationController *salNav = [[UINavigationController alloc]initWithRootViewController:sale];
//    [[AppEngineManager sharedInstance].viewVCArrary addObject:salNav];
    
    
    QYNavigationController* qyNavi=[[QYNavigationController alloc]initWithRootViewController:[MyDetailsViewController new]];
    
//    MyDetailsViewController  *msVC = [[MyDetailsViewController alloc]init];
//    UINavigationController *msNav = [[UINavigationController alloc]initWithRootViewController:msVC];
//    [[AppEngineManager sharedInstance].viewVCArrary addObject:msNav];
    self.viewControllers = @[limitNav,saleNav,salNav,qyNavi];
    
}
#pragma mark 设置所有的分栏元素项
- (void)setTabBarItems {
    
    NSArray *titleArr = @[@"文件",@"消息",@"同事",@"关于我"];
    NSArray *normalImgArr = @[@"home-拷贝",@"heart",@"iconfont-icon-拷贝-2",@"iconfont-wodexuanzhong-拷贝"];
    NSArray *selectedImgArr = @[@"tabbar_items_1_selected@2x",@"heart-拷贝",@"tabbar_items_3_selected@2x",@"tabbar_items_3_selected@2x"];
    //循环设置信息
    for (int i = 0; i<4; i++) {
        UIViewController *vc = self.viewControllers[i];
        
        vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:titleArr[i] image:[UIImage imageNamed:normalImgArr[i]] selectedImage:[[UIImage imageNamed:selectedImgArr[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]];
        vc.tabBarItem.tag = i;
        if (i == 1) {
             NSLog(@"vc   11  %@",vc);
//            vc.tabBarItem.badgeValue = @"00";
        }
        
        
    }
   
    //tabbar的背景图片
//        self.tabBar.backgroundImage = [UIImage imageNamed:@"矩形-11"];
    //item被选中时背景文字颜色
    //权限最高
//    [[UITabBarItem appearance]setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
//        [[UITabBarItem appearance]setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateSelected];
    
    //self.navigationController.navigationBar 这个的话会有一个专题改不了，所以这用最高权限
    //获取导航条最高权限
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {

    if (item.tag == 1) {
        
        
//        item.badgeValue = nil;
        
    }
    
    

}

@end
