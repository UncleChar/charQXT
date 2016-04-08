//
//  Users.h
//  OutsourcingProject
//
//  Created by LingLi on 16/2/19.
//  Copyright © 2016年 LingLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Users : NSObject


@property (nonatomic,strong)  NSString      *package_id;
@property (nonatomic, strong) NSArray       *noteStatusArr;
@property (nonatomic, strong) NSString      *registrionID;
@property (nonatomic, strong) NSDate        *date;
@property (nonatomic, retain) NSString      *refresh_token;
@property (nonatomic, strong) NSString      *avatar;
@property (nonatomic, strong) NSString      *user_id;
@property (nonatomic, retain) NSString      *user_name;
@property (nonatomic, retain) NSString      *cloud_id;
@property (nonatomic, retain) NSString      *cloud_name;
@property (nonatomic, retain) NSString      *password;
@property (nonatomic, retain) NSString      *email;
@property (nonatomic, retain) NSString      *real_name;
@property (nonatomic, retain) NSString      *phone;
@property (nonatomic, retain) NSString      *access_token;
@property (nonatomic, retain) NSString      *password_new;
@property (nonatomic, retain) NSString      *password_old;
@property (nonatomic, retain) NSString      *notificationCount;
@property (nonatomic, retain) NSString      *discussCount;
@property (nonatomic, retain) NSString      *noticeType;


@end
