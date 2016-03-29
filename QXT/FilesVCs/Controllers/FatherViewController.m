//
//  FatherViewController.m
//  QXT
//
//  Created by LingLi on 16/3/25.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "FatherViewController.h"


@implementation FatherViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //    self.tabBarController.tabBar.hidden = 1;
    //    self.navigationController.navigationBarHidden = 0;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];


//    [self configNavBarElementsUI];

    
}
//
//- (void)configNavBarElementsUI {
//    
//    UIBarButtonItem *rightAddBtn = [[UIBarButtonItem alloc]initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(presentMenuFromNav:)];
//    rightAddBtn.tag = 120;
//    UIBarButtonItem *rightMoreBtn = [[UIBarButtonItem alloc]initWithTitle:@"More" style:UIBarButtonItemStylePlain target:self action:@selector(presentMenuFromNav:)];
//    rightMoreBtn.tag = 121;
//    //    rightMoreBtn.image = [UIImage imageNamed:@"more"];
//    UIBarButtonItem *fiexd = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    fiexd.width = 20;
//    self.navigationItem.rightBarButtonItems = @[rightMoreBtn,fiexd,rightAddBtn];
//    
//    
//}

//- (void)presentMenuFromNav:(UIButton *)sender
//{
//    
//    self.navigationController.tabBarController.tabBar.hidden = 1;
//    
//    if (sender.tag == 120) {
//        
//        
//    }else if (sender.tag == 121){
//        
//     
//      
//    }else {
//        
//        
//        
//    }
//    
//}


@end
