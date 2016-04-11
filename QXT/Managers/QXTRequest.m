//
//  RequestBlockManager.m
//  QXT
//
//  Created by LingLi on 16/3/23.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "QXTRequest.h"
#import "Common.h"

@interface QXTRequest ()<ASIHTTPRequestDelegate>
{

    ASIHTTPRequest *asiRequest;
    ASIHTTPRequest *tokenRequest;
}
@end

@implementation QXTRequest

+ (void)requestDataForListWithDictionary:(NSDictionary *)parmDict withSuccessBlock:(SuccesBlock)success failure:(FailureBlock)failure {
    
    //zheli qing qiu

    


}


- (void)requestDataByDictionary:(NSDictionary *)parmDict requestType:(RequestType)requestType requsetMethod:(REQUEST_METHOD)requestMothd delegate:(id<QXTRequestDelegate>)delegate {
//    
//    __autoreleasing QXTRequest *request = [[QXTRequest alloc] init];
//    request.requestTag      = parmDict[@"tag"];
//    request.requestUrl      = [parmDict[@"url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    request.parmRequestDict = parmDict[@"dataParm"];
//    request.requestType     = requestType;
//    request.requestMothd    = requestMothd;
    _delegate        = delegate;
    _requestType     = requestType;
    switch (requestMothd) {
        case REQUEST_METHOD_GET:
        {

            asiRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[parmDict[@"url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];

            [asiRequest setValidatesSecureCertificate:NO];   //-----https
            [asiRequest setQueuePriority:NSOperationQueuePriorityNormal];
            [asiRequest addRequestHeader:@"Content-Type"
                                value:@"application/x-www-form-urlencoded"];
            
            [asiRequest addRequestHeader:@"HTTP_X_OAUTH"
                                value:[[AppEngineManager sharedInstance] GetAccessToken]];//[[AppEngineManager sharedInstance] GetAccessToken]
            [asiRequest addRequestHeader:@"CLOUD_ID" value:[[AppEngineManager sharedInstance] GetCloud_Id]];
            [asiRequest setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:parmDict[@"tag"],@"tag",nil]];

            NSLog(@"rrtttt %@",[[AppEngineManager sharedInstance] GetAccessToken]);
            __block ASIHTTPRequest *blockRequest = asiRequest;
            __weak typeof(self) weakSelf = self;
            [asiRequest setCompletionBlock:^{
                [weakSelf requestFinished:blockRequest];
            }];
            [asiRequest setFailedBlock:^{
                [weakSelf requestFailed:blockRequest];
            }];
            [asiRequest setNumberOfTimesToRetryOnTimeout:0];
            [asiRequest setTimeOutSeconds:30.0f];

            [asiRequest startAsynchronous];
        }
            
            break;
            
        case REQUEST_METHOD_POST:
//        {
//            //  NSLog(@"---testhttps--%@",url);
//            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
//            // [request setValidatesSecureCertificate:NO];   //https------
//            [request setQueuePriority:NSOperationQueuePriorityNormal];
//            [request addRequestHeader:@"Content-Type"
//                                value:@"application/x-www-form-urlencoded"];
//            if([[AppEngine GetAppEngine] IsLogin])
//            {
//                
//                
//                
//                [request addRequestHeader:@"HTTP_X_OAUTH"
//                                    value:[[AppEngine GetAppEngine] GetAccessToken]];
//                [request addRequestHeader:@"CLOUD_ID" value:[AppEngine GetAppEngine].CLOUD_ID];
//                
//                
//                
//            }
//            [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:tag1,@"tag", nil]];
//            [request setNumberOfTimesToRetryOnTimeout:0];
//            [request setTimeOutSeconds:30.0f];
//            // [request setDelegate:self];
//            __block ASIHTTPRequest *blockRequest = request;
//            [request setCompletionBlock:^{
//                [self requestFinished:blockRequest];
//            }];
//            
//            [request setFailedBlock:^{
//                [self requestFailed:blockRequest];
//            }];
//            //-----   利用block 处理因为连续点击引起的block 问题
//            
//            NSString * str_encode = [m_pMsg Encode];
//            
//            if(str_encode && [str_encode length] > 0)
//            {
//                NSData * data = [str_encode dataUsingEncoding:NSUTF8StringEncoding];
//                
//                [request appendPostData:data];
//            }
//            
//            [request setRequestMethod:@"POST"];
//            
//            //--------https-----test------
//            
//            
//            
//            
//            //            SecIdentityRef identity = NULL;
//            //            SecTrustRef trust = NULL;
//            
//            //绑定证书，证书放在Resources文件夹中
//            //            NSData *PKCS12Data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"iOShttps" ofType:@"p12"]];
//            //            [OBRequest extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data];
//            //            //    [request addRequestHeader:@"Content-Type"
//            //            //                        value:@"application/x-www-form-urlencoded"];
//            //            //    [request addRequestHeader:@"HTTP_X_OAUTH"
//            //            //                        value:@"2f7524ad0c46e0489a6a5766d974bd9e"];
//            //
//            //            [request setClientCertificateIdentity:identity];
//            //            [request setValidatesSecureCertificate:NO];
//            
//            
//            
//            //--------https-----test------
//            
//            [request startAsynchronous];
//            
//        }
            
            break;
            
        default:
            break;
    }
    
    
    
}

- (void)changeTokenWithDelegate:(id<QXTRequestDelegate>)delegate requestType:(RequestType )requestType {
    
    _delegate        = delegate;
    _requestType     = requestType;
    NSString *changeStr = [NSString stringWithFormat:@"%@oauth2/token?grant_type=refresh_token&refresh_token=%@&client_id=UmxT6CuwQYrtJGFp&client_secret=GxsxayamApUSwTq9",SERVER_HOST,[[AppEngineManager sharedInstance] GetRefreshToken]];
    
    tokenRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:changeStr]];


    [tokenRequest setValidatesSecureCertificate:NO];   //-----https
    [tokenRequest setQueuePriority:NSOperationQueuePriorityNormal];
    [tokenRequest addRequestHeader:@"Content-Type"
                        value:@"application/x-www-form-urlencoded"];

    [asiRequest addRequestHeader:@"HTTP_X_OAUTH"
                           value:[[AppEngineManager sharedInstance] GetAccessToken]];
    [asiRequest addRequestHeader:@"CLOUD_ID" value:[[AppEngineManager sharedInstance] GetCloud_Id]];
    

    __block ASIHTTPRequest *blockRequest = tokenRequest;
    __weak typeof(self) weakSelf = self;
    [tokenRequest setCompletionBlock:^{
        [weakSelf requestFinished:blockRequest];
    }];
    [tokenRequest setFailedBlock:^{
        [weakSelf requestFailed:blockRequest];
    }];
    [tokenRequest setNumberOfTimesToRetryOnTimeout:0];
    [tokenRequest setTimeOutSeconds:30.0f];
    
    [tokenRequest startAsynchronous];

    
      
}



- (void)requestFinished:(ASIHTTPRequest *)request
{
    
//    dispatch_async(dispatch_get_main_queue(), ^{}

        if ([_delegate respondsToSelector:@selector(requsetFinshedByResponseData:requestType:)])
        {
            [_delegate requsetFinshedByResponseData:[request responseData] requestType:_requestType];
            
        }
        
   
}

- (void)requestFailed:(ASIHTTPRequest *)request {

    
    if ([_delegate respondsToSelector:@selector(requestFailedByError:errorCode:forRequest:withRequestType:)])
    {
        [_delegate requestFailedByError:request.error errorCode:112 forRequest:request withRequestType:_requestType];
        
    }

}

- (void)clearDelegatesAndCancel {


    if (asiRequest) {
        
        [asiRequest clearDelegatesAndCancel];
        asiRequest.delegate = nil;
    }
    if (tokenRequest) {
        
        [tokenRequest clearDelegatesAndCancel];
        tokenRequest.delegate = nil;
        
    }

}

@end
