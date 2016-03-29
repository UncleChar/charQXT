//
//  AppDelegate.m
//  QXT
//
//  Created by LingLi on 16/3/21.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.dataManager = [[DataManager alloc]init];
    
    AppEngineManager *engineManager = [[AppEngineManager alloc]init];
//    engineManager.mainTabBarController.notiBadgeValue = @"5";
//    engineManager.mainTabBarController.viewControllers[1].tabBarItem.badgeValue = @"7";
//    [engineManager.mainTabBarController refreshBargeWithNmuber:11];
    NSLog(@"AppStart---%@",engineManager.mainTabBarController.notiBadgeValue);
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
//        if( ([[[UIDevice currentDevice] systemVersion] doubleValue]<=7.0))
//        {
//            [[UINavigationBar appearance] setTranslucent:NO];
//        }
//    if ([[NSUserDefaults standardUserDefaults]boolForKey:kUserLoginStatus]) {
    
        
        self.window.rootViewController = [[MainTabBarController alloc]init];
        
//    }else {
    
//        self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[LoginViewController alloc]init]];
//        
//    }
    

//    [[UINavigationBar appearance]setBarTintColor:[ConfigUITools colorWithR:90 G:192 B:246 A:1]];
    
    [[UINavigationBar appearance]setBarTintColor:[ConfigUITools colorWithR:33 G:126 B:198 A:1]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTranslucent:NO];
    [self.window makeKeyAndVisible];
    
    [self refreshBargeWithNmuber:7];
    
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
- (void)refreshBargeWithNmuber:(NSInteger)number {

    UIViewController *vc =  [AppEngineManager sharedInstance].viewVCArrary[0];
    
    NSLog(@"vc   START  %@",vc);
    
    if(number < 100){
        vc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",number];
    }else{
        vc.tabBarItem.badgeValue = [NSString stringWithFormat:@".."];
    }

}

@end
