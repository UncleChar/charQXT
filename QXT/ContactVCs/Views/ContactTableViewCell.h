//
//  ContactTableViewCell.h
//  QXT
//
//  Created by LingLi on 16/3/28.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContactModel;
@interface ContactTableViewCell : UITableViewCell
@property (nonatomic, strong) ContactModel *model;
@end
