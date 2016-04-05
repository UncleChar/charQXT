//
//  ContactModel.h
//  QXT
//
//  Created by LingLi on 16/4/5.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactModel : NSObject
@property (nonatomic, assign) BOOL       isSelected;
@property (nonatomic, strong) NSString   *fileName;
@property (nonatomic, strong) NSString   *avatarId;
@property (nonatomic, strong) NSString   *email;
@property (nonatomic, assign) BOOL       sex;
@end
