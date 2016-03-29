//
//  QYNavigationBar.h
//  导航栏渐变效果与头部视图放大集合
//
//  Created by apple on 16/1/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYNavigationBar : UINavigationBar
@property (nonatomic,strong)UIView *bgView;
/**
 *   显示导航条背景颜色
 */
- (void)show;
/**
 *   隐藏
 */
- (void)hidden;
@end
