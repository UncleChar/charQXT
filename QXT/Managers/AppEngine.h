//
//  AppEngine.h
//
//  Created by Peteo on 12-5-15.
//  Copyright 2012 The9. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Users.h"

@interface AppEngine : NSObject

@property (nonatomic,retain) Users * owner;


//实现单利方法
+(AppEngine *) GetAppEngine;

//必须初始化时候调用
-(void) Initialization;


-(void)saveUserLoginInfo:(NSMutableDictionary*) userDict;


//获取用户令牌，放入HTTP的Header中
-(NSString*) GetAccessToken;
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
////获取移动文件夹时的文件路径
//- (NSString *)getFileMoveRoute;





@end
