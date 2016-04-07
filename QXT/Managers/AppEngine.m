//
//  AppEngine.m
//
//  Created by Peteo on 12-5-15.
//  Copyright 2012 The9. All rights reserved.
//

#import "AppEngine.h"

@implementation AppEngine


static AppEngine * AppEngineInstance = nil; //单例对象

+(AppEngine *) GetAppEngine
{
	@synchronized(self)
	{
		if (AppEngineInstance == nil)
		{
			AppEngineInstance = [[self alloc] init];
		}
	}
	return AppEngineInstance;
}


- (instancetype)init {
    
    if (self = [super init]) {
        

        self.owner = [[Users alloc]init];
        
    }
    return self;
}



-(void) saveUserLoginInfo:(NSMutableDictionary*) userDict
{

    _owner.package_id = [userDict objectForKey:@"package_id"];
    _owner.noteStatusArr = [userDict objectForKey:@"noteStatusArr"];
    _owner.registrionID = [userDict objectForKey:@"registrionID"];
    _owner.date = [userDict objectForKey:@"date"];
    _owner.refresh_token = [userDict objectForKey:@"refresh_token"];
    _owner.avatar = [userDict objectForKey:@"avatar"];
    _owner.user_id = [userDict objectForKey:@"user_id"];
    _owner.user_name = [userDict objectForKey:@"user_name"];
    _owner.password = [userDict objectForKey:@"password"];
    _owner.email = [userDict objectForKey:@"email"];
    _owner.real_name = [userDict objectForKey:@"real_name"];
    _owner.phone = [userDict objectForKey:@"phone"];
    _owner.access_token = [userDict objectForKey:@"access_token"];
    _owner.password_new = [userDict objectForKey:@"password_new"];
    _owner.password_old = [userDict objectForKey:@"password_old"];
    _owner.notificationCount = [userDict objectForKey:@"notificationCount"];
    _owner.discussCount = [userDict objectForKey:@"discussCount"];
    _owner.noticeType = [userDict objectForKey:@"noticeType"];

    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:_owner.package_id forKey:@"package_id"];
    [defaults setObject:_owner.noteStatusArr forKey:@"noteStatusArr"];
    [defaults setObject:_owner.registrionID forKey:@"registrionID"];
    [defaults setObject:_owner.date forKey:@"date"];
    [defaults setObject:_owner.refresh_token forKey:@"refresh_token"];
    [defaults setObject:_owner.avatar forKey:@"avatar"];
    [defaults setObject:_owner.user_id forKey:@"user_id"];
    [defaults setObject:_owner.user_name forKey:@"user_name"];
    [defaults setObject:_owner.password forKey:@"password"];
    [defaults setObject:_owner.email forKey:@"email"];
    [defaults setObject:_owner.real_name forKey:@"real_name"];
    [defaults setObject:_owner.phone forKey:@"phone"];
    [defaults setObject:_owner.access_token forKey:@"access_token"];
    [defaults setObject:_owner.password_new forKey:@"password_new"];
    [defaults setObject:_owner.password_old forKey:@"password_old"];
    [defaults setObject:_owner.notificationCount forKey:@"notificationCount"];
    [defaults setObject:_owner.discussCount forKey:@"discussCount"];
    [defaults setObject:_owner.noticeType forKey:@"noticeType"];

    [defaults synchronize];//同步写入到文件
}

- (NSDate *)GetCurrentDate
{
    if (_owner) {
        return _owner.date;
    }
    return nil;
}

-(NSString*) GetAccessToken
{
    if(_owner)
    {
        return _owner.access_token;
    }
    
    return nil;
}
- (NSString *)GetRefreshToken
{
    if (_owner) {
        return _owner.refresh_token;
    }
    return nil;
}
- (NSString *)getEmail
{
    if (_owner) {
        return _owner.email;
    }
    return nil;
}


- (NSString *)GetUserid
{
    if (_owner) {
        return _owner.user_id;
    }
    return nil;
}
- (NSString *)getAvatar
{
    if (_owner) {
        return _owner.avatar;
    }
    return nil;
}
- (NSString *)getPhoneNum
{
    if (_owner) {
        return _owner.phone;
    }
    return nil;
}
- (NSString *)getReal_name
{
    if (_owner) {
        return _owner.real_name;
    }
    return nil;
}
- (NSString *)getPassword_old
{
    if (_owner) {
        return _owner.password_old;
    }
    return nil;
}

- (NSString *)getPassword_new
{
    if (_owner) {
        return _owner.password_new;
    }
    return nil;
}
- (NSString *)GetNotificationCount
{
    if (_owner) {
        return _owner.notificationCount;
    }
    return nil;
}
- (NSString *)GetDiscussCount
{
    if (_owner) {
        return _owner.discussCount;
    }
    return nil;
}
- (NSString *)GetNoticeType
{
    if (_owner)
    {
        return _owner.noticeType;
    }
    return nil;
}

- (NSArray *) GetNoteStatusArr
{
    if (_owner) {
        return _owner.noteStatusArr;
    }
    return nil;
}




@end
