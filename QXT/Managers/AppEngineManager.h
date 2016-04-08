//
//  AppEngineManager.h
//  QXT
//
//  Created by LingLi on 16/3/22.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainTabBarController.h"
#import "Users.h"
@class UINavigationController;

@interface AppEngineManager : NSObject

@property (nonatomic, strong) MainTabBarController      *mainTabBarController;
@property (nonatomic, strong) NSString                  *dirDocument;
@property (nonatomic, strong) NSString                  *dirCache;
@property (nonatomic, strong) NSString                  *dirTemp;
@property (nonatomic, strong) NSString                  *dirDBSqlite;
@property (nonatomic, strong) NSMutableArray            *viewVCArrary;


@property (nonatomic, strong) Users * user;
@property (nonatomic, strong) NSUserDefaults * defaults;


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


-(void)saveUserLoginInfo:(NSMutableDictionary*) userDict;


//获取用户令牌，放入HTTP的Header中
-(NSString*) GetAccessToken;

-(NSString*) GetCloud_Id;

//获取refreshToken
- (NSString *)GetRefreshToken;
//获取用户的id
- (NSString*) GetUserid;
//获取用户当前时间
- (NSDate *)GetCurrentDate;
//获取用户图片路径
- (NSString *)getAvatar;
//获取用户邮箱地址
- (NSString *)getEmail;
//获取用户联系方式
- (NSString *)getPhoneNum;
//获取用户的真实姓名
- (NSString *)getReal_name;
//获取老密码
- (NSString *)getPassword_old;
//获取新密码
- (NSString *)getPassword_new;
//获取通知数目
- (NSString *) GetNotificationCount;
//获取讨论数目
- (NSString *) GetDiscussCount;
//获取通知类型，判断当前界面是否为通知界面
- (NSString *) GetNoticeType;
//获取存储的笔记编辑状态
- (NSArray *) GetNoteStatusArr;

@end
