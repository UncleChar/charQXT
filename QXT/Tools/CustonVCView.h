//
//  CustonVCView.h
//  QXT
//
//  Created by LingLi on 16/3/23.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^tip)(NSString * );
@interface CustonVCView : UIViewController
@property (nonatomic, strong) tip tipBlock;
- (void)initSheetWithTitle:(NSString *)title attribute:(NSDictionary *)attribute itemTitles:(NSArray *)itemTitles;

@end
