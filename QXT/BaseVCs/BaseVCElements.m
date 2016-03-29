//
//  BaseVCElements.m
//  QXT
//
//  Created by LingLi on 16/3/21.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "BaseVCElements.h"

@interface BaseVCElements ()

@end

@implementation BaseVCElements

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    self.tabBarController.tabBar.hidden = 1;
//    self.navigationController.navigationBarHidden = 0;
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(backBack)];
//    leftItem.image = [UIImage imageNamed:@"backk"];
//    self.navigationItem.leftBarButtonItem = leftItem;
//    self.view.backgroundColor = kBackColor;
}

//- (void)backBack {
//    
//    [self.navigationController popViewControllerAnimated:YES];
//}

@end
