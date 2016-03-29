//
//  RequestBlockManager.h
//  QXT
//
//  Created by LingLi on 16/3/23.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccesBlock)(id responseData);
typedef void(^FailureBlock)(NSString *errorDesc);

@interface RequestBlockManager : NSObject

+ (void)requestDataForListWithDictionary:(NSDictionary *)parmDict withSuccessBlock:(SuccesBlock)success failure:(FailureBlock)failure;

@end
