//
//  MessageTableViewCell.h
//  QXT
//
//  Created by LingLi on 16/3/28.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageModel;
@interface MessageTableViewCell : UITableViewCell
@property (nonatomic, strong) MessageModel *model;
@end
