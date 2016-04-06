//
//  OtherJumpVc.m
//  QXT
//
//  Created by LingLi on 16/3/31.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "OtherJumpVc.h"
#import "QXTRequest.h"

@interface OtherJumpVc ()<QXTRequestDelegate>

@end

@implementation OtherJumpVc
- (void)viewDidLoad {
    
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"下载" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(resumeInterruptedDownload) forControlEvents:UIControlEventTouchUpInside];
    
    

    
}

- (void)resumeInterruptedDownload {

    NSDictionary *dict = @{@"url":@"http://allseeing-i.com",@"tag":@"1001"};

    QXTRequest *request = [[QXTRequest alloc]init];
    [request requestDataByDictionary:dict  requestType:RequestType_AvatarInfo requsetMethod:REQUEST_METHOD_GET delegate:self];


}

- (void)requsetFinshedByResponseData:(NSData *)responseData requestType:(RequestType)requestType {

    NSLog(@" --------------- %@",responseData);
      NSLog(@"  type %d",requestType);
    

}

@end
