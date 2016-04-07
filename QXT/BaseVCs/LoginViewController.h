//
//  LoginViewController.h
//  UncleCharDemos
//
//  Created by LingLi on 16/1/7.
//  Copyright © 2016年 hailong.xie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController


@property (nonatomic, retain) NSString* registration_id;
@property (nonatomic, retain) NSString* client_id;
@property (nonatomic, retain) NSString* client_secret;
@property (nonatomic, retain) NSString* user_name;
@property (nonatomic, retain) NSString* password;
@property (nonatomic, retain) NSString* response_type;
@property (nonatomic, retain) NSString* grant_type;
@property (nonatomic, retain) NSString* device_type;
@property (nonatomic, retain) NSString* device_name;
@property (nonatomic, retain) NSString* device_info;

@end
