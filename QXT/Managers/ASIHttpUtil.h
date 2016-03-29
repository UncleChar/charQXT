//
//  ASIHttpUtil.h
//  QXT
//
//  Created by LingLi on 16/3/21.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import <Foundation/Foundation.h>
//@class ASIHTTPRequest;
//@class ASIFormDataRequest;
//@class ASINetworkQueue;
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"

typedef void (^CompleteBlock)(id responseData);
typedef void (^QueueCompleteBlock)(ASINetworkQueue *);

@interface ASIHttpUtil : NSObject<ASIProgressDelegate>
/** * 网络工具单例 * 
 * @return return value description 
 */
+ (ASIHttpUtil *)sharedHttpUtil;

/** 
 * 获取登陆认证Token 
 ** @param path 后台请求接口 
 * @param paramDic 请求参数 
 */
+ (void)authenticateWithPath:(NSString *)path
                      params:(NSDictionary *)paramDic
                   completed:(CompleteBlock)completeBlock;

/** 
 * GET请求
 * * @param path 后台接口 
 * @param paramDic 请求参数字典 
 * @param completeBlock 请求完成回调块 
 * @param isShow 是否显示等待提示框 
 * * @return return value description 
 */
+ (ASIHTTPRequest *)getRequestWithPath:(NSString *)path
                                params:(NSDictionary *)paramDic
                               showHud:(BOOL)isShow
                             completed:(CompleteBlock)completeBlock;

/** * POST请求 * * @param path 后台接口 * @param paramDic 请求参数字典 * @param completeBlock 请求完成回调块 * * @return return value description */
+ (ASIHTTPRequest *)postRequestWithPath:(NSString *)path
                                 params:(NSDictionary *)paramDic
                                showHud:(BOOL)isShow
                              completed:(CompleteBlock)completeBlock;

+ (ASIHTTPRequest *)postJsonWithPath:(NSString *)path
                              params:(NSDictionary *)paramDic
                             showHud:(BOOL)isShow
                           completed:(CompleteBlock)completeBlock;

+ (ASIHTTPRequest *)putRequestWithPath:(NSString *)path
                                params:(NSDictionary *)paramDic
                               showHud:(BOOL)isShow
                             completed:(CompleteBlock)completeBlock;

+ (ASIHTTPRequest *)deleteRequestWithPath:(NSString *)path
                                   params:(NSDictionary *)paramDic
                                  showHud:(BOOL)isShow
                                completed:(CompleteBlock)completeBlock;

/** * 文件上传 
 * * @param path 后台接口 
 * @param filePath 上传文件路径 
 * @param fileKey 上传文件对应服务器端Key值 
 * @param paramDic 请求参数字典 
 * @param completeBlock 请求完成回调 
 * * @return return value description 
 */
+ (ASIHTTPRequest *)uploadFileWithPath:(NSString *)path
                              filePath:(NSString *)filePath
                               fileKey:(NSString *)fileKey
                              paramDic:(NSDictionary *)paramDic
                               showHud:(BOOL)isShow
                             completed:(CompleteBlock)completeBlock;

+ (ASIHTTPRequest *)uploadFileWithPath:(NSString *)path
                              filePath:(NSString *)filePath
                               fileKey:(NSString *)fileKey
                              paramDic:(NSDictionary *)paramDic
                               showHud:(BOOL)isShow
                      progressDelegate:(id <ASIProgressDelegate>)progressDelgate
                             completed:(CompleteBlock)completeBlock;

/** * 多文件上传 
 * * @param path 后台接口 
 * @param filePaths 上传文件的所有路径 
 * @param fileKey 上传文件对应服务器端Key值 
 * @param paramDic 请求参数字典 
 * @param completeBlock 每个文件上传完成的回调 
 * @param queueComplete 所有文件上传完成的回调 
 * * @return <#return value description#> 
 */
+ (ASINetworkQueue *)uploadFilesWithPath:(NSString *)path
                               filePaths:(NSArray *)filePaths
                                 fileKey:(NSString *)fileKey
                                paramDic:(NSDictionary *)paramDic
                                 showHud:(BOOL)isShow
                               completed:(CompleteBlock)completeBlock
                           queueCmoplete:(QueueCompleteBlock)queueComplete;

/** * 文件下载 
 * * @param path 后台接口 
 * @param destinationPath 下载文件目的地 
 * @param completeBlock 请求完成回调 
 * * @return return value description 
 */

+(ASIHTTPRequest *)downloadFileWithPath:(NSString *)path
                        destinationPath:(NSString *)destinationPath
                              completed:(CompleteBlock)completeBlock;

@end
