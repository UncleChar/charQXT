//
//  AllContactsViewController.h
//  QXT
//
//  Created by LingLi on 16/3/21.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllContactsViewController : BaseVCElements

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *requestDataSource;
@property (nonatomic, assign) BOOL  isNotRootVC;
@end
