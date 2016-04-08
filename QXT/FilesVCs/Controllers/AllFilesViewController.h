//
//  AllFilesViewController.h
//  QXT
//
//  Created by LingLi on 16/3/21.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherViewController.h"
@interface AllFilesViewController : FatherViewController
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) BOOL isRootVC;
@property (nonatomic, strong) NSString       *folderId;
@end
