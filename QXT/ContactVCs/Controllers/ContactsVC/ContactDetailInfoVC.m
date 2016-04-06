//
//  ContactDetailInfoVC.m
//  QXT
//
//  Created by LingLi on 16/3/31.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "ContactDetailInfoVC.h"
#import "ContactModel.h"
#define kWidthToLeft 15
@interface ContactDetailInfoVC ()
{


    UILabel *phoneLabelDE;
}

@end

@implementation ContactDetailInfoVC


- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"联系人详情";
    [self initUI];
    
    
}

- (void)initUI {

    
    UIScrollView *scv = [[UIScrollView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:scv];
    scv.showsVerticalScrollIndicator = NO;
    scv.contentSize = CGSizeMake(kScreenWidth, kScreenHeight - 45);
    
    UIImageView *headView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    headView.layer.cornerRadius = 4;
    headView.layer.masksToBounds = 1;
    headView.image=[UIImage imageNamed:self.model.avatarId];
    [scv addSubview:headView];

    
    UILabel *nameLabel = [[UILabel  alloc]initWithFrame:CGRectMake(80, 10, kScreenWidth - 100, 40)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = self.model.fileName;
    nameLabel.font = [UIFont systemFontOfSize:18];
    nameLabel.textColor = [UIColor blackColor];
    [scv addSubview:nameLabel];
    
    
    UIImageView *sexView=[[UIImageView alloc]initWithFrame:CGRectMake(85, 50, 12, 12)];
//    sexView.layer.cornerRadius = 4;
//    sexView.layer.masksToBounds = 1;
    if (self.model.sex) {//男性
       sexView.image=[UIImage imageNamed:@"lbs_nearby_filter_icon_male"];
        
    }else {
    
    sexView.image=[UIImage imageNamed:@"lbs_nearby_filter_icon_female"];
        
    }
    
    [scv addSubview:sexView];
    
    
    
    UILabel *phoneLabel = [[UILabel  alloc]initWithFrame:CGRectMake(kWidthToLeft, 90, 100, 20)];
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.text = @"手机";
    phoneLabel.font = [UIFont systemFontOfSize:12];
    phoneLabel.textColor = [ConfigUITools colorWithR:33 G:126 B:198 A:1];
    [scv addSubview:phoneLabel];
    
    phoneLabelDE = [[UILabel  alloc]initWithFrame:CGRectMake(kWidthToLeft, 110, kScreenWidth - kWidthToLeft - 80, 30)];
    phoneLabelDE.backgroundColor = [UIColor clearColor];
    phoneLabelDE.text = @"13852042434";
    phoneLabelDE.font = [UIFont systemFontOfSize:15];
    phoneLabelDE.textColor = [UIColor blackColor];
    [scv addSubview:phoneLabelDE];
    
    
    
    UIButton *messageBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 80, 105, 30, 30)];
    [messageBtn setBackgroundImage:[UIImage imageNamed:@"profile_mail"] forState:UIControlStateNormal];
    messageBtn.tag = 200 + 0;
    [messageBtn addTarget:self action:@selector(contactBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scv addSubview:messageBtn];
    
    UIButton *phoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 40, 105, 30, 30)];
    [phoneBtn setBackgroundImage:[UIImage imageNamed:@"profile_contactno"] forState:UIControlStateNormal];
    phoneBtn.tag = 200 + 1;
    [phoneBtn addTarget:self action:@selector(contactBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scv addSubview:phoneBtn];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(kWidthToLeft, 145, kScreenHeight - kWidthToLeft, 1)];
    lineView1.backgroundColor = [ConfigUITools colorWithR:220 G:220 B:220 A:1];
    [scv addSubview:lineView1];
    
    
    UILabel *emailLabel = [[UILabel  alloc]initWithFrame:CGRectMake(kWidthToLeft, 160, 100, 20)];
    emailLabel.backgroundColor = [UIColor clearColor];
    emailLabel.text = @"邮箱";
    emailLabel.font = [UIFont systemFontOfSize:12];
    emailLabel.textColor = [ConfigUITools colorWithR:33 G:126 B:198 A:1];
    [scv addSubview:emailLabel];
    
    UILabel *emailLabelDE = [[UILabel  alloc]initWithFrame:CGRectMake(kWidthToLeft, 180, kScreenWidth - kWidthToLeft - 40, 30)];
    emailLabelDE.backgroundColor = [UIColor clearColor];
    emailLabelDE.text = self.model.email;
    emailLabelDE.font = [UIFont systemFontOfSize:15];
    emailLabelDE.textColor = [UIColor blackColor];
    [scv addSubview:emailLabelDE];
    
    
    UIButton *emailBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 40, 175, 30, 30)];
    [emailBtn setBackgroundImage:[UIImage imageNamed:@"profile_mail"] forState:UIControlStateNormal];
    emailBtn.tag = 200 + 2;
    [emailBtn addTarget:self action:@selector(contactBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scv addSubview:emailBtn];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(kWidthToLeft, 215, kScreenHeight - kWidthToLeft, 1)];
    lineView2.backgroundColor = [ConfigUITools colorWithR:220 G:220 B:220 A:1];
    [scv addSubview:lineView2];
    
    
    UILabel *companyLabel = [[UILabel  alloc]initWithFrame:CGRectMake(kWidthToLeft, 230, kScreenWidth - 2 * kWidthToLeft, 20)];
    companyLabel.backgroundColor = [UIColor clearColor];
    companyLabel.text = @"公司";
    companyLabel.font = [UIFont systemFontOfSize:12];
    companyLabel.textColor = [ConfigUITools colorWithR:33 G:126 B:198 A:1];
    [scv addSubview:companyLabel];
    
    UILabel *companyLabelDE = [[UILabel  alloc]initWithFrame:CGRectMake(kWidthToLeft, 250, kScreenWidth - 2 * kWidthToLeft, 30)];
    companyLabelDE.backgroundColor = [UIColor clearColor];
    companyLabelDE.text = @"灵利信息技术有限公司";
    companyLabelDE.font = [UIFont systemFontOfSize:15];
    companyLabelDE.textColor = [UIColor blackColor];
    [scv addSubview:companyLabelDE];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(kWidthToLeft, 280, kScreenHeight - kWidthToLeft, 1)];
    lineView3.backgroundColor = [ConfigUITools colorWithR:220 G:220 B:220 A:1];
    [scv addSubview:lineView3];
    
    
    
    UILabel *positionLabel = [[UILabel  alloc]initWithFrame:CGRectMake(kWidthToLeft, 300, 100, 20)];
    positionLabel.backgroundColor = [UIColor clearColor];
    positionLabel.text = @"职位";
    positionLabel.font = [UIFont systemFontOfSize:12];
    positionLabel.textColor = [ConfigUITools colorWithR:33 G:126 B:198 A:1];
    [scv addSubview:positionLabel];
    
    UILabel *positionLabelDE = [[UILabel  alloc]initWithFrame:CGRectMake(kWidthToLeft, 320, kScreenWidth - 2 * kWidthToLeft, 30)];
    positionLabelDE.backgroundColor = [UIColor clearColor];
    positionLabelDE.text = @"ios开发工程师";
    positionLabelDE.font = [UIFont systemFontOfSize:15];
    positionLabelDE.textColor = [UIColor blackColor];
    [scv addSubview:positionLabelDE];
    
    UIView *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(kWidthToLeft, 355, kScreenHeight - kWidthToLeft, 1)];
    lineView4.backgroundColor = [ConfigUITools colorWithR:220 G:220 B:220 A:1];
    [scv addSubview:lineView4];

    
    
    
    

}

- (void)contactBtnClicked:(UIButton *)sender {

    switch (sender.tag - 200) {
        case 0:
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://13852042434"]];
            break;
        case 1:
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"13852042434"]]];
            break;
        case 2:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://xhljob@sharpinteract.com"]];
            
            break;
            
        default:
            break;
    }


}

@end
