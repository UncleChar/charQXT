//
//  VCTools.m
//  QXT
//
//  Created by LingLi on 16/3/22.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "VCTools.h"

@interface VCTools ()

@end

@implementation VCTools




+ (UIVisualEffectView *)returnEffictveViewWithFrame:(CGRect)frame withStyle:(UIBlurEffectStyle)style {
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:1];
    
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [effectview addGestureRecognizer:tapGesture];
    effectview.frame = frame;
    
    return effectview;
    
}

- (void)tap:(UITapGestureRecognizer *)aa {
    
    
    [aa.view removeFromSuperview];
    
}

@end
