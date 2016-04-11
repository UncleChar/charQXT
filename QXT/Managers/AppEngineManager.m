//
//  AppEngineManager.m
//  QXT
//
//  Created by LingLi on 16/3/22.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "AppEngineManager.h"



static  AppEngineManager *sharedElement = nil;
@implementation AppEngineManager

+ (instancetype)sharedInstance {
    
    @synchronized(self) {
        
        if (sharedElement == nil) {
            
            sharedElement = [[self alloc]init];
        }
    }
    
    return sharedElement;
}

+(id)allocWithZone:(struct _NSZone *)zone {
    
    @synchronized(self) {
        
        if (sharedElement == nil) {
            
            sharedElement = [super allocWithZone:zone];
            return  sharedElement;
        }
        
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    
    return self;
}

- (instancetype)init {
    
    if (self = [super init]) {
        

        self.viewVCArrary = [NSMutableArray arrayWithCapacity:0];

        self.dirDocument = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        
        self.dirCache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        
        self.dirTemp  = NSTemporaryDirectory();
        
        self.user = [[Users alloc]init];
        
        self.defaults = [NSUserDefaults standardUserDefaults];
        
//        self.dirDBSqlite = [self.dirDocument stringByAppendingPathComponent:@"MyAppDataBase.sqlite"];

        NSLog(@"               MainTBC : %@",self.mainTabBarController);
        NSLog(@"          DocumentPath : %@",self.dirDocument);
        NSLog(@"             CachePath : %@",self.dirCache);
        NSLog(@"              TempPath : %@",self.dirTemp);
    }
    return self;
}


-(void) saveUserLoginInfo:(NSMutableDictionary*) userDict
{
    
    _user.package_id = [userDict objectForKey:@"package_id"];
    _user.noteStatusArr = [userDict objectForKey:@"noteStatusArr"];
    _user.registrionID = [userDict objectForKey:@"registrionID"];
    _user.date = [userDict objectForKey:@"date"];
    _user.refresh_token = [userDict objectForKey:@"refresh_token"];
    _user.avatar = [userDict objectForKey:@"avatar"];
    _user.user_id = [userDict objectForKey:@"user_id"];
    _user.user_name = [userDict objectForKey:@"user_name"];
    _user.cloud_id = [userDict objectForKey:@"cloud_id"];
    _user.cloud_name = [userDict objectForKey:@"cloud_name"];
    _user.password = [userDict objectForKey:@"password"];
    _user.email = [userDict objectForKey:@"email"];
    _user.real_name = [userDict objectForKey:@"real_name"];
    _user.phone = [userDict objectForKey:@"phone"];
    _user.access_token = [userDict objectForKey:@"access_token"];
    _user.password_new = [userDict objectForKey:@"password_new"];
    _user.password_old = [userDict objectForKey:@"password_old"];
    _user.notificationCount = [userDict objectForKey:@"notificationCount"];
    _user.discussCount = [userDict objectForKey:@"discussCount"];
    _user.noticeType = [userDict objectForKey:@"noticeType"];
    
    
//    _defaults = [NSUserDefaults standardUserDefaults];
    
    [_defaults setObject:_user.package_id forKey:@"package_id"];
    [_defaults setObject:_user.noteStatusArr forKey:@"noteStatusArr"];
    [_defaults setObject:_user.registrionID forKey:@"registrionID"];
    [_defaults setObject:_user.date forKey:@"date"];
    [_defaults setObject:_user.refresh_token forKey:@"refresh_token"];
    [_defaults setObject:_user.avatar forKey:@"avatar"];
    [_defaults setObject:_user.user_id forKey:@"user_id"];
    [_defaults setObject:_user.user_name forKey:@"user_name"];
    [_defaults setObject:_user.cloud_id forKey:@"cloud_id"];
    [_defaults setObject:_user.cloud_name forKey:@"cloud_name"];
    [_defaults setObject:_user.password forKey:@"password"];
    [_defaults setObject:_user.email forKey:@"email"];
    [_defaults setObject:_user.real_name forKey:@"real_name"];
    [_defaults setObject:_user.phone forKey:@"phone"];
    [_defaults setObject:_user.access_token forKey:@"access_token"];
    [_defaults setObject:_user.password_new forKey:@"password_new"];
    [_defaults setObject:_user.password_old forKey:@"password_old"];
    [_defaults setObject:_user.notificationCount forKey:@"notificationCount"];
    [_defaults setObject:_user.discussCount forKey:@"discussCount"];
    [_defaults setObject:_user.noticeType forKey:@"noticeType"];
    
    [_defaults synchronize];//同步写入到文件
}

- (void)saveRefreshTokenInfoWithAccesstoken:(NSString *)accessToken refreshToken:(NSString *)refreshToken {
    
    _user.refresh_token = refreshToken;
    _user.access_token  = accessToken;
    [_defaults setObject:_user.refresh_token forKey:@"refresh_token"];
    [_defaults setObject:_user.access_token forKey:@"access_token"];
    [_defaults synchronize];//同步写入到文件
    
    
    
}

- (NSDate *)GetCurrentDate
{
    if (_user) {
        return [_defaults objectForKey:@"date"];
    }
    return nil;
}

-(NSString*)GetCloud_Id
{
    if(_user)
    {
        return [_defaults objectForKey:@"cloud_id"];
    }
    
    return nil;
}

-(NSString*) GetAccessToken
{
    if(_user)
    {
        return [_defaults objectForKey:@"access_token"];
    }
    
    return nil;
}
- (NSString *)GetRefreshToken
{
    if (_user) {
        return [_defaults objectForKey:@"refresh_token"];
    }
    return nil;
}
- (NSString *)getEmail
{
    if (_user) {
        return [_defaults objectForKey:@"email"];
    }
    return nil;
}


- (NSString *)GetUserid
{
    if (_user) {
        return [_defaults objectForKey:@"user_id"];
    }
    return nil;
}
- (NSString *)getAvatar
{
    if (_user) {
        return [_defaults objectForKey:@"avatar"];
    }
    return nil;
}
- (NSString *)getPhoneNum
{
    if (_user) {
        return [_defaults objectForKey:@"phone"];
    }
    return nil;
}
- (NSString *)getReal_name
{
    if (_user) {
        return [_defaults objectForKey:@"real_name"];
    }
    return nil;
}
- (NSString *)getPassword_old
{
    if (_user) {
        return [_defaults objectForKey:@"password_old"];
    }
    return nil;
}

- (NSString *)getPassword_new
{
    if (_user) {
        return [_defaults objectForKey:@"password_new"];
    }
    return nil;
}
- (NSString *)GetNotificationCount
{
    if (_user) {
        return [_defaults objectForKey:@"notificationCount"];
    }
    return nil;
}
- (NSString *)GetDiscussCount
{
    if (_user) {
        return [_defaults objectForKey:@"discussCount"];
    }
    return nil;
}
- (NSString *)GetNoticeType
{
    if (_user)
    {
        return [_defaults objectForKey:@"noticeType"];
    }
    return nil;
}

- (NSArray *) GetNoteStatusArr
{
    if (_user) {
        return [_defaults objectForKey:@"noteStatusArr"];
    }
    return nil;
}


@end
