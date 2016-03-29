//
//  MessageModel.h
//  QXT
//
//  Created by LingLi on 16/3/28.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject
@property (nonatomic, strong) NSString   *title;
@property (nonatomic, strong) NSString   *avatarId;
@property (nonatomic, strong) NSString   *time;
@property (nonatomic, strong) NSString   *content;
@property (nonatomic, strong) NSString    *number;
@end
