//
//  QYNavigationController.m
//  导航栏渐变效果与头部视图放大集合
//
//  Created by apple on 16/1/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "QYNavigationController.h"
#import "QYNavigationBar.h"
@interface QYNavigationController ()

@end

@implementation QYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    QYNavigationBar* bar=[[QYNavigationBar alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    [self setValue:bar forKey:@"navigationBar"];
    
    
//     [[UINavigationBar appearance]setBackgroundColor:[UIColor redColor]];
   self.navigationBar.barTintColor = [UIColor redColor];
    // 3.设置导航条标题的字体和颜色
    NSDictionary *titleAttr = @{
                                NSForegroundColorAttributeName:[UIColor whiteColor],
                                NSFontAttributeName:[UIFont systemFontOfSize:15]
                                };
    
   self.navigationBar.titleTextAttributes=titleAttr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
