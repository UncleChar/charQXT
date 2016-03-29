//
//  CustonVCView.m
//  QXT
//
//  Created by LingLi on 16/3/23.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "CustonVCView.h"
@interface CustonVCView()
@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) UIButton *bgButton;
@end
@implementation CustonVCView
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
