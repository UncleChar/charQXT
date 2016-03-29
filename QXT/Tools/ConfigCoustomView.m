//
//  ConfigCoustomView.m
//  QXT
//
//  Created by LingLi on 16/3/23.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "ConfigCoustomView.h"

#define kPushTime 0.3
#define kDismissTime 0.3
#define kWH ([[UIScreen mainScreen] bounds].size.height)
#define kWW ([[UIScreen mainScreen] bounds].size.width)
#define kCellH (kWH<500?45:(kWH<600?47:(kWH<700?49:50)))
#define kMW (kWW-2*kMargin)
#define kCornerRadius 5
#define kMargin 6

@interface ConfigCoustomView()
@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) UIButton *bgButton;
@end

@implementation ConfigCoustomView


- (void)initSheetWithTitle:(NSString *)title attribute:(NSDictionary *)attribute itemTitles:(NSArray *)itemTitles {

    //半透明背景按钮
    self.bgButton = [[UIButton alloc] init];
    self.bgButton.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgButton];
    self.bgButton.backgroundColor = [UIColor blackColor];
    self.bgButton.alpha = 0.35;
    [self.bgButton addTarget:self action:@selector(tip:) forControlEvents:UIControlEventTouchUpInside];



}

- (void)tip:(UIButton *)sender {

    [self.bgButton removeFromSuperview];
    self.tipBlock (@"ff");

}
@end
