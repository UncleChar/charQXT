//
//  LoginViewController.m
//  UncleCharDemos
//
//  Created by LingLi on 16/1/7.
//  Copyright © 2016年 hailong.xie. All rights reserved.
//

#import "LoginViewController.h"
#import "MainTabBarController.h"
//#import "ForgetPwdViewController.h"
#import <UIKit/UIKit.h>

#define kPadding  [UIScreen mainScreen].bounds.size.width / 5 
@interface LoginViewController ()<UITextFieldDelegate,UIScrollViewDelegate,ASIHTTPRequestDelegate>

{
    
    UITextField         *_accountTF;
    NSArray             *_usersArray;
    UITableView         *_showHistoryTableView;
    NSMutableArray      *_transferArray;
    NSString            *_userInputAccount;
    BOOL                 _isAleradySelected;
    NSInteger            _lengthOfHistory;
}

@property (nonatomic, strong) UIScrollView *inScrollerView;

@property (nonatomic, strong) UITextField  *userAccount;
@property (nonatomic, strong) UITextField  *userPassword;

@property (nonatomic, strong) UITextField  *firstResponderTF;
@property (nonatomic, strong) UIButton     *loginBtn;
@property (nonatomic, strong) UIButton     *resetBtn;
@property (nonatomic, strong) UIView       *baseView;

@property (nonatomic, strong) UIImageView    *loginHeadImg;
@property (nonatomic, strong) UIView         *lineAccount;
@property (nonatomic, strong) UIView         *linePassword;

@property (nonatomic, strong) UILabel       *label;

@property (nonatomic, assign) CGFloat       btnMaxY;


@end

@implementation LoginViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = 1;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [ConfigUITools colorWithR:37 G:118 B:227 A:1];

    [self configLoginVCUI];
  
}


- (void)configLoginVCUI {
    
    NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
    // 取出当前应用版本号
    NSString *currentVersion = [infoDict objectForKey:(NSString *)kCFBundleVersionKey];
    // 取出沙盒存储的应用版本号
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"version"];
    if (![currentVersion isEqualToString:saveVersion]) {
        // 如果是第一次进入新版本,进入介绍页面
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"version"];
//        [self goIntroduceView];
        [self loginAction];
    } else {
        [self loginAction];
    }
 
}

- (void)goIntroduceView {


    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i < 3; i ++) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        iv.image = [UIImage imageNamed:[NSString stringWithFormat:@"leadingPage%i", i + 1]];
        [scrollView addSubview:iv];
//        
//        if (3 == i) { // 创建进入应用按钮
//            
//            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth - 150) / 2, kScreenHeight - 110, 150, 40)];
//            btn.backgroundColor = [ConfigUITools colorWithR:197 G:37 B:45 A:1];
//            btn.layer.cornerRadius = 4;
//            btn.layer.masksToBounds = 1;
//            [btn setTitle:@"进入应用" forState:UIControlStateNormal];
//            [btn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
//            iv.userInteractionEnabled = YES;
//            [iv addSubview:btn];
//        }
    }
    
    scrollView.contentSize = CGSizeMake(kScreenWidth * 3, 0);
    [self.view addSubview:scrollView];
    _inScrollerView = scrollView;


}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

//    NSLog(@"---%@", NSStringFromCGPoint(scrollView.contentOffset) );
    if (scrollView.contentOffset.x >2 * kScreenWidth + 10) {
        
//        [UIView animateWithDuration:2 animations:^{
//            
//            _inScrollerView.alpha = 0;
//            
//        }];
        
        [self loginAction];
    }

}
- (void)loginAction {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
    
    _baseView = [[UIView alloc]initWithFrame:self.view.frame];
    _baseView.alpha = 1;
    _baseView.backgroundColor = [ConfigUITools colorWithR:37 G:118 B:227 A:1];
    [self.view addSubview:_baseView];
    
//    UIImageView *sexView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 50, 30, 30)];
//    //    sexView.layer.cornerRadius = 4;
//    //    sexView.layer.masksToBounds = 1;
//    
//        sexView.image=[UIImage imageNamed:@"Add-to-Cloud"];
//
//    
//    [_baseView addSubview:sexView];
    
    
    UIView *avatarView = [[UIView alloc]initWithFrame:CGRectMake(kPadding * 2, - kPadding - 40, kPadding, kPadding)];
    //UIView *avatarView = [[UIView alloc]initWithFrame:CGRectMake(kPadding * 2, kPadding, kPadding, kPadding)];
    avatarView.backgroundColor = [UIColor whiteColor];
    avatarView.layer.cornerRadius = kPadding / 2;
    avatarView.layer.masksToBounds = 1;
    [_baseView addSubview:avatarView];
    _loginHeadImg = [[UIImageView alloc]init];
    _loginHeadImg.frame = CGRectMake(1, 1, kPadding - 2, kPadding - 2);
    _loginHeadImg.image = [UIImage imageNamed:@"icon120"];
    _loginHeadImg.layer.cornerRadius = (kPadding - 2) / 2;
    _loginHeadImg.layer.masksToBounds = 1;
    
    
    _label = [[UILabel alloc]init];
    _label.text = @"全携通云协作";
    _label.font = [UIFont boldSystemFontOfSize:18];
    _label.textAlignment = 1;
    _label.textColor = [UIColor whiteColor];
    _label.frame = CGRectMake(10 , CGRectGetMaxY(avatarView.frame) + 10, kScreenWidth - 20, 30);
    
    
    _userAccount = [[UITextField alloc]init];
    _userAccount.placeholder = @"  输入账号";
    _userAccount.delegate = self;
    _userAccount.text = @"test";//13601726730
//    _userAccount.text = @"13601726730";

    _userAccount.textColor = [UIColor whiteColor];
    _userAccount.backgroundColor = [UIColor clearColor];
    _userAccount.clearButtonMode = UITextFieldViewModeWhileEditing;
   
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-account"]];
    imgView.frame = CGRectMake(0, 5, 25, 25);
    _userAccount.leftView = imgView;
    _userAccount.leftViewMode = UITextFieldViewModeAlways;
    
    
    _lineAccount = [[UIView alloc]init];
    
    _lineAccount.backgroundColor = [UIColor whiteColor];
    _lineAccount.alpha = 0.6;
    
    
    _userPassword = [[UITextField alloc]init];
    _userPassword.placeholder = @"  请输入密码 ";
    _userPassword.delegate = self;
    _userPassword.text = @"123456";
//     _userPassword.text = @"ljz";18121150633
    _userPassword.secureTextEntry = YES;
    _userPassword.textColor = [UIColor whiteColor];
    _userPassword.backgroundColor = [UIColor clearColor];
    _userPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-pwd"]];
    imgView1.frame = CGRectMake(0, 5, 25, 25);
    _userPassword.leftView = imgView1;
    _userPassword.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    _linePassword = [[UIView alloc]init];
       _linePassword.backgroundColor = [UIColor whiteColor];
    _linePassword.alpha = 0.6;
    
    
    _loginBtn = [[UIButton alloc]init];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形-4"] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _loginBtn.tag = 100 + 1;
    
  
    _resetBtn = [[UIButton alloc]init];
    [_resetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    _resetBtn.alpha = 0.8;
    _resetBtn.titleLabel.textAlignment = 0;
    [_resetBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    _resetBtn.tag = 100 + 2;
    

    UILabel *bottomLabel = [[UILabel alloc]init];
    bottomLabel.text = @"灵利信息技术有限公司";
    bottomLabel.font = [UIFont systemFontOfSize:13];
    bottomLabel.textColor = [UIColor whiteColor];
//    [ConfigUITools colorWithR:228 G:172 B:23 A:1];
    bottomLabel.textAlignment = 1;
    
    [avatarView addSubview:_loginHeadImg];
    [_baseView addSubview:_label];
    [_baseView addSubview:_userAccount];
    [_baseView addSubview:_lineAccount];
    [_baseView addSubview:_userPassword];
    [_baseView addSubview:_linePassword];
    
    [_baseView addSubview:_loginBtn];
    [_baseView addSubview:_resetBtn];

    [_baseView addSubview:bottomLabel];
    _baseView.alpha = 0;
    
    _userAccount.frame = CGRectMake(kScreenWidth / 6, kScreenHeight, kScreenWidth * 4 / 6, 35);
    _lineAccount.frame = CGRectMake(kScreenWidth / 6, CGRectGetMaxY(_userAccount.frame) - 1, kScreenWidth * 4 / 6, 1);
    _userPassword.frame = CGRectMake(kScreenWidth / 6, CGRectGetMaxY(_userAccount.frame) + 10, kScreenWidth * 4 / 6, 35);
    _linePassword.frame = CGRectMake(kScreenWidth / 6, CGRectGetMaxY(_userPassword.frame) - 1, kScreenWidth * 4 / 6, 1);
    _loginBtn.frame = CGRectMake(kScreenWidth / 6, CGRectGetMaxY(_linePassword.frame) + 20, kScreenWidth * 4 / 6, 35);
    _resetBtn.frame = CGRectMake(kScreenWidth / 6, CGRectGetMaxY(_loginBtn.frame) + 20, kScreenWidth / 3, 35);
    bottomLabel.frame = CGRectMake(0, kScreenHeight , kScreenWidth  , 30);
    
    
    
    [UIView animateWithDuration:1.8 animations:^{
      
        avatarView.frame =CGRectMake(kPadding * 2,  kPadding, kPadding, kPadding);
        _label.frame = CGRectMake(10 , CGRectGetMaxY(avatarView.frame) + 10, kScreenWidth - 20, 30);
        _baseView.alpha = 1;
        
        
        _userAccount.frame = CGRectMake(kScreenWidth / 6, 2 * kPadding + 40 + kPadding / 2, kScreenWidth * 4 / 6, 35);
        _lineAccount.frame = CGRectMake(kScreenWidth / 6, CGRectGetMaxY(_userAccount.frame) - 1, kScreenWidth * 4 / 6, 1);
        _userPassword.frame = CGRectMake(kScreenWidth / 6, CGRectGetMaxY(_userAccount.frame) + 10, kScreenWidth * 4 / 6, 35);
        _linePassword.frame = CGRectMake(kScreenWidth / 6, CGRectGetMaxY(_userPassword.frame) - 1, kScreenWidth * 4 / 6, 1);
        _loginBtn.frame = CGRectMake(kScreenWidth / 6, CGRectGetMaxY(_linePassword.frame) + 20, kScreenWidth * 4 / 6, 35);
        _resetBtn.frame = CGRectMake(kScreenWidth / 6, CGRectGetMaxY(_loginBtn.frame) + 20, kScreenWidth / 3, 35);
        bottomLabel.frame = CGRectMake(1, kScreenHeight * 0.9 + 2.5 , kScreenWidth  , 30);
        
        
    }];
    
    [_loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_resetBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];



}



- (void)textFieldDidBeginEditing:(UITextField *)textField {

    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    
    return YES;
   
}










- (void)contactBackBtn {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)loginBtnClicked:(UIButton *)sender {

    switch (sender.tag - 100) {
        case 2:
        {
        
//            [self.navigationController pushViewController:[[ForgetPwdViewController alloc]init] animated:YES];
            
        }
            
            break;
        case 1:
        {
            [self.view endEditing:YES];
            
            if ([[NSUserDefaults standardUserDefaults]boolForKey:kNetworkConnecting]) {

                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];

                [SVProgressHUD showWithStatus:@"正在登录..."];

                ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@user/login",SERVER_HOST]]];
             
                [request setQueuePriority:NSOperationQueuePriorityNormal];
                [request addRequestHeader:@"Content-Type"
                                    value:@"application/x-www-form-urlencoded"];

                [request setNumberOfTimesToRetryOnTimeout:1];
                [request setTimeOutSeconds:30.0f];
//                request.delegate = self;
//                [request setDidFailSelector:@selector(requestFailed:)];
//                [request setDidFinishSelector:@selector(requestFinished:)];
                
                __block ASIHTTPRequest *blockRequest = request;
                [request setCompletionBlock:^{
                    [self requestFinished:blockRequest];
                }];
    
                [request setFailedBlock:^{
                    [self requestFailed:blockRequest];
                }];


                NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                [dict setValue:CLIENT_ID forKey:@"client_id"];
                [dict setValue:CLIENT_SECRET forKey:@"client_secret"];
                [dict setValue:@"token" forKey:@"response_type"];
                [dict setValue:@"password" forKey:@"grant_type"];
                [dict setValue:DEVICE_TYPE forKey:@"device_type"];
                [dict setValue:CLIENT_NAME forKey:@"device_name"];
                [dict setValue:_userAccount.text forKey:@"user_name"];
                [dict setValue:_userPassword.text forKey:@"password"];
                [dict setValue:[[UIDevice currentDevice]name] forKey:@"device_info"];

                SBJSON *jsonParser = [[SBJSON alloc] init];
                NSError *parseError = nil;
                
                NSString * result = [jsonParser stringWithObject:dict
                                                           error:&parseError];
                if ( result && [result length]>0) {
                    NSData *postData = [result dataUsingEncoding:NSUTF8StringEncoding];
                    
                    NSMutableData *pMD = [[NSMutableData alloc]init];
                    [pMD appendData:postData];
                    [request setPostBody:pMD];
             
                
                }

                [request setRequestMethod:@"GET"];
        
                [request startAsynchronous];
             
            }else {

                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无网络链接,请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
    
        }
            break;
            
        default:
            break;
    }
    
}



#pragma ASI请求数据

- (void)requestFinished:(ASIHTTPRequest *)request { //获取网络并实现吧图片存入沙盒，接着想设计好数据库存取数据，包括视频图片之类的所有文件
    
    //    dispatch_async(dispatch_get_main_queue(), ^{}
    
    NSData *responseData = [request responseData];
    NSString *dataString = [[NSString alloc] initWithData:responseData
                                                 encoding:NSUTF8StringEncoding];
    SBJSON *jsonParser = [[SBJSON alloc] init];
    
    NSError *parseError = nil;
    NSDictionary * result = [jsonParser objectWithString:dataString
                                                   error:&parseError];
    NSLog(@"jsonParserresult:%@",result);
    if ([result[@"statusCode"] integerValue] == 200) {
        Users *userModel = [[Users alloc]init];
        [userModel setValuesForKeysWithDictionary:[result objectForKey:@"result"]];
        [[AppEngineManager sharedInstance] saveUserLoginInfo:(NSMutableDictionary *)[result objectForKey:@"result"]];
        
        NSUserDefaults *store = [NSUserDefaults standardUserDefaults];
        [store setBool:YES forKey:kUserLoginStatus];
        [store synchronize];
        
        
        [SVProgressHUD showSuccessWithStatus:@"登录成功!"];
        
        [AppDelegate getAppDelegate].window.rootViewController = [[MainTabBarController alloc]init];
        [[AppDelegate getAppDelegate] refreshBargeWithNmuber:7];

    }else {
    
    
        [SVProgressHUD showErrorWithStatus:@"Account or password error!"];
    }
    NSLog(@"--- %@",[[AppEngineManager sharedInstance] getEmail]);
}
- (void)requestFailed:(ASIHTTPRequest *)request {
    
    
    [SVProgressHUD showErrorWithStatus:@"Account or password error!"];
    NSData *responseData = [request responseData];
    NSString *dataString = [[NSString alloc] initWithData:responseData
                                                 encoding:NSUTF8StringEncoding];
    SBJSON *jsonParser = [[SBJSON alloc] init];
    
    NSError *parseError = nil;
    NSDictionary * result = [jsonParser objectWithString:dataString
                                                   error:&parseError];
    NSLog(@"error:%@",result);
}


    
#pragma mark - keyboard events
    
///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    
        _btnMaxY = CGRectGetMaxY(_loginBtn.frame);

    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    PRETTY_LOG(@"login %f",kbHeight);
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if(_btnMaxY >(self.view.frame.size.height - kbHeight)) {
        
        [UIView animateWithDuration:duration + 0.3 animations:^{
            
            _baseView.frame = CGRectMake(_baseView.frame.origin.x,-( _btnMaxY - (self.view.frame.size.height - kbHeight) + 10), _baseView.frame.size.width, _baseView.frame.size.height);
            
        }];
    }
    //注明：这里不需要移除通知
}

- (void) keyboardWillHide:(NSNotification *)notify {
    
    _showHistoryTableView.hidden = YES;
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration + 0.3 animations:^{
        _baseView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}
-(void) saveUserLoginInfo:(NSDictionary*) userDict
{
//    Users *_owner = [[Users alloc]init];
//    _owner.addr = [userDict objectForKey:@"addr"];
//    _owner.deptcode = [userDict objectForKey:@"deptcode"];
//    _owner.deptname = [userDict objectForKey:@"deptname"];
//    _owner.email = [userDict objectForKey:@"email"];
//    _owner.iconpic = [userDict objectForKey:@"iconpic"];
//    _owner.logincookie = [userDict objectForKey:@"logincookie"];
//    _owner.shengri = [userDict objectForKey:@"shengri"];
//    _owner.shouji = [userDict objectForKey:@"shouji"];
//    _owner.usercode = [userDict objectForKey:@"usercode"];
//    _owner.usertype = [userDict objectForKey:@"usertype"];
//    _owner.xingbie = [userDict objectForKey:@"xingbie"];
//    _owner.xingming = [userDict objectForKey:@"xingming"];
//    
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//    
//    [defaults setObject:_owner.addr forKey:@"addr"];
//    [defaults setObject:_owner.deptcode forKey:@"deptcode"];
//    [defaults setObject:_owner.deptname forKey:@"deptname"];
//    [defaults setObject:_owner.email forKey:@"email"];
//    [defaults setObject:_owner.iconpic forKey:@"iconpic"];
//    [defaults setObject:_owner.logincookie forKey:@"logincookie"];
//    [defaults setObject:_owner.shengri forKey:@"shengri"];
//    [defaults setObject:_owner.usercode forKey:@"usercode"];
//    [defaults setObject:_owner.usertype forKey:@"usertype"];
//    [defaults setObject:_owner.xingbie forKey:@"xingbie"];
//    [defaults setObject:_owner.xingming forKey:@"xingming"];
//    [defaults setObject:_owner.shouji forKey:@"shouji"];
//    
//    [defaults synchronize];//同步写入到文件
}


@end


