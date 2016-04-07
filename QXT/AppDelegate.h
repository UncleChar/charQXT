//
//  AppDelegate.h
//  QXT
//
//  Created by LingLi on 16/3/21.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Reachability *hostReach;
@property (assign, nonatomic) BOOL         isReachable;


+ (AppDelegate *)getAppDelegate;

+ (BOOL)isNetworkConecting;

- (void)refreshBargeWithNmuber:(NSInteger)number;
@end

