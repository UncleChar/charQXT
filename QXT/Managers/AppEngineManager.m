//
//  AppEngineManager.m
//  QXT
//
//  Created by LingLi on 16/3/22.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "AppEngineManager.h"



static  AppEngineManager *sharedElement = nil;
@implementation AppEngineManager

+ (instancetype)sharedInstance {
    
    @synchronized(self) {
        
        if (sharedElement == nil) {
            
            sharedElement = [[self alloc]init];
        }
    }
    
    return sharedElement;
}

+(id)allocWithZone:(struct _NSZone *)zone {
    
    @synchronized(self) {
        
        if (sharedElement == nil) {
            
            sharedElement = [super allocWithZone:zone];
            return  sharedElement;
        }
        
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    
    return self;
}

- (instancetype)init {
    
    if (self = [super init]) {
        

        self.viewVCArrary = [NSMutableArray arrayWithCapacity:0];

        self.dirDocument = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        
        self.dirCache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        
        self.dirTemp  = NSTemporaryDirectory();
        
//        self.dirDBSqlite = [self.dirDocument stringByAppendingPathComponent:@"MyAppDataBase.sqlite"];

        NSLog(@"               MainTBC : %@",self.mainTabBarController);
        NSLog(@"          DocumentPath : %@",self.dirDocument);
        NSLog(@"             CachePath : %@",self.dirCache);
        NSLog(@"              TempPath : %@",self.dirTemp);
    }
    return self;
}


@end
