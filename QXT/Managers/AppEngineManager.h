//
//  AppEngineManager.h
//  QXT
//
//  Created by LingLi on 16/3/22.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainTabBarController.h"

@class UINavigationController;

@interface AppEngineManager : NSObject

@property (nonatomic, strong) MainTabBarController      *mainTabBarController;
@property (nonatomic, strong) NSString                  *dirDocument;
@property (nonatomic, strong) NSString                  *dirCache;
@property (nonatomic, strong) NSString                  *dirTemp;
@property (nonatomic, strong) NSString                  *dirDBSqlite;
@property (nonatomic, strong) NSMutableArray            *viewVCArrary;


+ (instancetype)sharedInstance;

/**
 *  这是完成把数据存入沙盒的方法
 *
 *  @param data      要写入的数据
 *  @param fileName  数据命名为
 *  @param directory 写入的目标目录
 */
//- (void)writeDataToDirectoryWithData:(NSData *)data fileNameForData:(NSString *)fileName underSuperDirecotry:(NSString *)directory;
//
//- (void)createSubDirectoryName:(NSString *)subDirectoryName underSuperDirectory:(NSString *)superDirectory;
//
//- (void)baseViewControllerPushViewController:(UIViewController *)targetViewController animated:(BOOL)animated;

@end
