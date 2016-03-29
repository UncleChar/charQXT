//
//  QYNavigationBar.m
//  导航栏渐变效果与头部视图放大集合
//
//  Created by apple on 16/1/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "QYNavigationBar.h"

@implementation QYNavigationBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        for (UIView* view in  self.subviews) {
            if([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")])
                self.bgView=view;
        }
        
        
    }
    return self;
}
-(void)show
{
    [UIView animateWithDuration:0.8 animations:^{
        self.bgView.alpha = 1;
    }];
}
-(void)hidden
{
    self.bgView.alpha = 0;
}
@end
