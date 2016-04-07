//
//  AppDelegate.m
//  QXT
//
//  Created by LingLi on 16/3/21.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "LoginViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)getAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    AppEngineManager *engineManager = [[AppEngineManager alloc]init];
    
    NSLog(@"AppStart---%@",engineManager.mainTabBarController.notiBadgeValue);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    //开始监听，会启动一个run loop
    [self.hostReach startNotifier];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
//        if( ([[[UIDevice currentDevice] systemVersion] doubleValue]<=7.0))
//        {
//            [[UINavigationBar appearance] setTranslucent:NO];
//        }
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kUserLoginStatus]) {
    
        
        self.window.rootViewController = [[MainTabBarController alloc]init];
        [self refreshBargeWithNmuber:7];
        
    }else {
    
        self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[LoginViewController alloc]init]];
        
    }


//    [[UINavigationBar appearance]setBarTintColor:[ConfigUITools colorWithR:90 G:192 B:246 A:1]];
    
    [[UINavigationBar appearance]setBarTintColor:[ConfigUITools colorWithR:33 G:126 B:198 A:1]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTranslucent:NO];
    
//    NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
//    [[UINavigationBar appearance] setTitleTextAttributes: dict];
    
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)reachabilityChanged:(NSNotification *)note
{
    Reachability *currReach = [note object];
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    
    //对连接改变做出响应处理动作
    NetworkStatus status = [currReach currentReachabilityStatus];
    //如果没有连接到网络就弹出提醒实况
    self.isReachable = YES;
    if(status == NotReachable)
    {
        NSUserDefaults *netStatus = [NSUserDefaults standardUserDefaults];
        [netStatus setBool:NO forKey:kNetworkConnecting];
        [netStatus synchronize];
        
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        //        [alert show];
        
        self.isReachable = NO;
        
        return;
    }
    if (status==kReachableViaWiFi||status==kReachableViaWWAN) {
        
        NSUserDefaults *netStatus = [NSUserDefaults standardUserDefaults];
        [netStatus setBool:YES forKey:kNetworkConnecting];
        [netStatus synchronize];
        self.isReachable = YES;
    }
}



- (BOOL)isExistenceNetwork
{
    BOOL isExistenceNetwork = false;
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.google.com"];  // 测试服务器状态
    
    switch([reachability currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = FALSE;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = TRUE;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = TRUE;
            break;
    }
    return  isExistenceNetwork;
}

+ (BOOL)isNetworkConecting {
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kNetworkConnecting]) {
        
        return YES;
        
    }else {
        
        return NO;
        
    }
    
}


- (void)refreshBargeWithNmuber:(NSInteger)number {

    UIViewController *vc =  [AppEngineManager sharedInstance].viewVCArrary[0];
    
    if(number < 100){
        vc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",number];
    }else{
        vc.tabBarItem.badgeValue = [NSString stringWithFormat:@".."];
    }

}

@end
