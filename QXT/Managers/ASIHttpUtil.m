//
//  ASIHttpUtil.m
//  QXT
//
//  Created by LingLi on 16/3/21.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "ASIHttpUtil.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"
#define BASE_URL @"DDDD"
@implementation ASIHttpUtil
#pragma mark -
#pragma mark 网络工具单例

static UIProgressView *progressView;

+ (ASIHttpUtil *)sharedHttpUtil
{
    static ASIHttpUtil *httpUtil = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        httpUtil = [[self alloc] init];
    });
    return httpUtil;
}

#pragma mark -
#pragma mark 登陆请求

+ (void)authenticateWithPath:(NSString *)path
                      params:(NSDictionary *)paramDic
                   completed:(CompleteBlock)completeBlock
{
    NSString *urlStr                   = [NSString stringWithFormat:@"%@%@", BASE_URL, path];
    NSURL *url                         = [NSURL URLWithString:urlStr];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    ASIFormDataRequest *anotherRequest = request;
    
    // 设置请求参数
    [paramDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        [request setPostValue:obj forKey:key];
    }];
    
    [request addRequestHeader:@"Authorization" value:@"Basic YmFwbHVvX2FwaWtleTpiMjEwOTUzMDFmYzM1MzFm"];
    
    request.shouldAttemptPersistentConnection = NO;
    
    [request setCompletionBlock:^{
        
        NSDictionary *responseDic =
        [NSJSONSerialization JSONObjectWithData:anotherRequest.responseData options:NSJSONReadingMutableContainers error:nil];
        
        completeBlock(responseDic);
    }];
    
    [request setFailedBlock:^{
        
//        ShowHudWithMessage(@"认证失败!");
        [SVProgressHUD showErrorWithStatus:@"认证失败!"];
        completeBlock(nil);
        NSLog(@"%@", anotherRequest.error);
    }];
    
    [request startAsynchronous];
}

#pragma mark -
#pragma mark GET请求

+ (ASIHTTPRequest *)getRequestWithPath:(NSString *)path
                                params:(NSDictionary *)paramDic
                               showHud:(BOOL)isShow
                             completed:(CompleteBlock)completeBlock
{
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@%@?", BASE_URL, path];
    
    [paramDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [urlStr appendFormat:@"%@=%@&", key, obj];
    }];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlStr]];
    ASIFormDataRequest *anotherRequest = request;
    
//    NSString *token = StandardUserDefautsGet(kToken);
//    if (token) [request addRequestHeader:@"Authorization" value:token];
    
    request.requestMethod = @"GET";
    request.shouldAttemptPersistentConnection = NO;
    [request setCompletionBlock:^{
        
        [self completeActionWithRequest:anotherRequest
                                 andUrl:urlStr
                               andPrams:paramDic
                             dismissHud:isShow
                       andCompleteBlock:completeBlock];
    }];
    [request setFailedBlock:^{
        
        [self failedActionWithRequest:anotherRequest andCompleteBlock:completeBlock];
    }];
    
    request.delegate = self;
    [request startAsynchronous];
    
    return request;
}

#pragma mark -
#pragma mark POST请求

+ (ASIHTTPRequest *)requestWithPath:(NSString *)path
                             method:(NSString *)method
                             params:(NSDictionary *)paramDic
                            showHud:(BOOL)isShow
                          completed:(CompleteBlock)completeBlock
{
    NSString *urlStr                   = [NSString stringWithFormat:@"%@%@", BASE_URL, path];
    NSURL *url                         = [NSURL URLWithString:urlStr];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    ASIFormDataRequest *anotherRequest = request;
    
    request.requestMethod = method;
    
    // 设置请求参数
    [paramDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        [request setPostValue:obj forKey:key];
    }];
    
//    NSString *token = StandardUserDefautsGet(kToken);
//    if (token) [request addRequestHeader:@"Authorization" value:token];
    
    request.shouldAttemptPersistentConnection = NO;
    [request setCompletionBlock:^{
        
        [self completeActionWithRequest:anotherRequest
                                 andUrl:urlStr
                               andPrams:paramDic
                             dismissHud:isShow
                       andCompleteBlock:completeBlock];
    }];
    [request setFailedBlock:^{
        
        [self failedActionWithRequest:anotherRequest andCompleteBlock:completeBlock];
    }];
    
    [request startAsynchronous];
    
    return request;
}


+ (ASIHTTPRequest *)postRequestWithPath:(NSString *)path
                                 params:(NSDictionary *)paramDic
                                showHud:(BOOL)isShow
                              completed:(CompleteBlock)completeBlock
{
    return [self requestWithPath:path method:@"POST" params:paramDic showHud:isShow completed:completeBlock];
}



+ (ASIHTTPRequest *)postJsonWithPath:(NSString *)path
                              params:(NSDictionary *)paramDic
                             showHud:(BOOL)isShow
                           completed:(CompleteBlock)completeBlock
{
    NSString *urlStr                   = [NSString stringWithFormat:@"%@%@", BASE_URL, path];
    NSURL *url                         = [NSURL URLWithString:urlStr];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    ASIFormDataRequest *anotherRequest = request;
    
    // 设置请求参数
//    NSData *postData = [ToolsNSObject jsonFromDictionary:paramDic];
    
//    NSString *token = StandardUserDefautsGet(kToken);
//    if (token) [request addRequestHeader:@"Authorization" value:token];
    
    [request addRequestHeader:@"Content-type" value:@"application/json"];
//    [request setPostBody:[NSMutableData dataWithData:postData]];
    request.shouldAttemptPersistentConnection = NO;
    [request setCompletionBlock:^{
        
        [self completeActionWithRequest:anotherRequest
                                 andUrl:urlStr
                               andPrams:paramDic
                             dismissHud:isShow
                       andCompleteBlock:completeBlock];
    }];
    [request setFailedBlock:^{
        
        [self failedActionWithRequest:anotherRequest andCompleteBlock:completeBlock];
    }];
    
    [request startAsynchronous];
    
    
    return request;
}

+ (ASIHTTPRequest *)putRequestWithPath:(NSString *)path
                                params:(NSDictionary *)paramDic
                               showHud:(BOOL)isShow
                             completed:(CompleteBlock)completeBlock
{
    return [self requestWithPath:path method:@"PUT" params:paramDic showHud:isShow completed:completeBlock];
}

+ (ASIHTTPRequest *)deleteRequestWithPath:(NSString *)path
                                   params:(NSDictionary *)paramDic
                                  showHud:(BOOL)isShow
                                completed:(CompleteBlock)completeBlock
{
    return [self requestWithPath:path method:@"DELETE" params:paramDic showHud:isShow completed:completeBlock];
}

#pragma mark -
#pragma mark 上传文件

+ (ASIHTTPRequest *)uploadFileWithPath:(NSString *)path
                              filePath:(NSString *)filePath
                               fileKey:(NSString *)fileKey
                              paramDic:(NSDictionary *)paramDic
                               showHud:(BOOL)isShow
                             completed:(CompleteBlock)completeBlock
{
    return [self uploadFileWithPath:path filePath:filePath fileKey:fileKey paramDic:paramDic showHud:isShow progressDelegate:nil completed:completeBlock];
}

+ (ASIHTTPRequest *)uploadFileWithPath:(NSString *)path
                              filePath:(NSString *)filePath
                               fileKey:(NSString *)fileKey
                              paramDic:(NSDictionary *)paramDic
                               showHud:(BOOL)isShow
                      progressDelegate:(id <ASIProgressDelegate>)progressDelgate
                             completed:(CompleteBlock)completeBlock
{
    NSString *urlStr                   = [NSString stringWithFormat:@"%@%@", BASE_URL, path];
    NSURL *url                         = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    ASIFormDataRequest *anotherRequest = request;
    
    // 设置请求参数
    [paramDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        [request setPostValue:obj forKey:key];
    }];
    
//    NSString *token = StandardUserDefautsGet(kToken);
//    if (token) [request addRequestHeader:@"Authorization" value:token];
    
    // 设置上传文件和服务器键值
    [request setFile:filePath forKey:fileKey];
    [request setCompletionBlock:^{
        
        [self completeActionWithRequest:anotherRequest
                                 andUrl:nil
                               andPrams:nil
                             dismissHud:isShow
                       andCompleteBlock:completeBlock];
    }];
    [request setFailedBlock:^{
        
        [self failedActionWithRequest:anotherRequest andCompleteBlock:completeBlock];
    }];
    [request setTimeOutSeconds:100];
    
    if (progressDelgate) {
        [request setShowAccurateProgress:YES];
        [request setUploadProgressDelegate:progressDelgate];
    }
    
    [request startAsynchronous];
    
    return request;
}

+ (ASINetworkQueue *)uploadFilesWithPath:(NSString *)path
                               filePaths:(NSArray *)filePaths
                                 fileKey:(NSString *)fileKey
                                paramDic:(NSDictionary *)paramDic
                                 showHud:(BOOL)isShow
                               completed:(CompleteBlock)completeBlock
                           queueCmoplete:(QueueCompleteBlock)queueComplete
{
    ASINetworkQueue *queue = [ASINetworkQueue queue];
    
    [queue setDelegate:self];
    
    for (NSUInteger i = 0; i < filePaths.count; i++) {
        NSString *urlStr                   = [NSString stringWithFormat:@"%@%@", BASE_URL, path];
        NSURL *url                         = [NSURL URLWithString:urlStr];
        ASIFormDataRequest *request        = [ASIFormDataRequest requestWithURL:url];
        ASIFormDataRequest *anotherRequest = request;
        
//        NSString *token = StandardUserDefautsGet(kToken);
//        if (token) [request addRequestHeader:@"Authorization" value:token];
        
        // 设置上传文件和服务器键值
        [request setFile:filePaths[i] forKey:fileKey];
        [request setCompletionBlock:^{
            
            [self completeActionWithRequest:anotherRequest
                                     andUrl:nil
                                   andPrams:nil
                                 dismissHud:isShow
                           andCompleteBlock:completeBlock];
        }];
        [request setFailedBlock:^{
            
            [self failedActionWithRequest:anotherRequest andCompleteBlock:completeBlock];
        }];
        [queue addOperation:request];
        
    }
    
//    [queue setQueueDidFinishBlock:queueComplete];
    
    [queue go];
    
    return queue;
}


#pragma mark -
#pragma mark 下载文件

+ (ASIHTTPRequest *)downloadFileWithPath:(NSString *)path
                         destinationPath:(NSString *)destinationPath
                               completed:(CompleteBlock)completeBlock
{
    NSString *urlStr                   = [NSString stringWithFormat:@"%@", path];
    NSURL *url                         = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    ASIHTTPRequest *anotherRequest = request;
    
    // 设置下载文件路径
    [request setDownloadDestinationPath:destinationPath];
    [request setCompletionBlock:^{
        
        [self completeActionWithRequest:(ASIFormDataRequest *)anotherRequest
                                 andUrl:nil
                               andPrams:nil
                             dismissHud:NO
                       andCompleteBlock:completeBlock];
    }];
    [request setFailedBlock:^{
        
        [self failedActionWithRequest:(ASIFormDataRequest *)anotherRequest andCompleteBlock:completeBlock];
    }];
    
    [request startAsynchronous];
    
    return request;
}

#pragma mark -
#pragma mark 请求完成动作

+ (void)completeActionWithRequest:(ASIFormDataRequest *)request
                           andUrl:(NSString *)urlStr
                         andPrams:(NSDictionary *)paramDic
                       dismissHud:(BOOL)isDismiss
                 andCompleteBlock:(CompleteBlock)completeBlock
{
    NSError *err = nil;
    id jsonData  = nil;
    
    if (request.responseData)
    {
        NSString *jsonStr =
        [[NSString alloc] initWithBytes:[request.responseData bytes]
                                 length:[request.responseData length]
                               encoding:NSUTF8StringEncoding];
        if ([jsonStr isEqualToString:@""]) {
            if (request.responseStatusCode == 200) {
                jsonStr = @"{\"code\":\"200\", \"message\":\"success\"}";
            } else {
                return ;
            }
        }
        
        jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\n"
                                                     withString:@""];
        PRETTY_LOG(([NSString stringWithFormat:@"[ API ] %@\n[ Reponse Json ] \n%@", [request.url absoluteString], jsonStr]));
        NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        
        if (data) {
            jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        }
    }
    
    completeBlock(jsonData);
}

#pragma mark -
#pragma mark 请求失败动作

+ (void)failedActionWithRequest:(ASIFormDataRequest *)request
               andCompleteBlock:(CompleteBlock)completeBlock
{
    PRETTY_LOG(request.error);
    //ShowTopTips(@"", @"网络状况不好，请稍候再试！", @"heart");
    completeBlock(nil);
    
}

+ (void)setProgress:(float)newProgress
{
    PRETTY_LOG(([NSString stringWithFormat:@"%f", newProgress]));
}

@end
