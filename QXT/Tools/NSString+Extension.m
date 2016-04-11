//
//  NSString+Extension.m
//  UncleCharDemos
//
//  Created by LingLi on 16/1/13.
//  Copyright © 2016年 hailong.xie. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


- (NSInteger)calculateFileSize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 判断是否为文件
    BOOL dir = NO;
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&dir];
    // 文件\文件夹不存在
    if (exists == NO) return 0;
    
    if (dir) { // self是一个文件夹
        // 遍历caches里面的所有内容 --- 直接和间接内容
        NSArray *subpaths = [mgr subpathsAtPath:self];
        NSInteger totalByteSize = 0;
        for (NSString *subpath in subpaths) {
            // 获得全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 判断是否为文件
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullSubpath isDirectory:&dir];
            if (dir == NO) { // 文件
                totalByteSize += [[mgr attributesOfItemAtPath:fullSubpath error:nil][NSFileSize] integerValue];
            }
        }
        return totalByteSize;
    } else { // self是一个文件
        return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
    }
}


- (NSString *)stringExestrWithInt:(NSInteger)integer forString:(NSString *)nameStr {

    
    switch (integer) {
        case 0://完整的文件名 abc.xxx
            
            return [nameStr lastPathComponent];
            
            break;
        case 1://文件名不带后缀 abc
            
             return [nameStr stringByDeletingPathExtension];
            break;
        case 2://后缀    xxx
            
             return [nameStr pathExtension];
            
            break;
            
        default:
            break;
    }
    //    // 从路径中获得完整的文件名（带后缀）
    //    exestr = [filePath lastPathComponent];
    //    NSLog(@"%@",exestr);
    //    // 获得文件名（不带后缀）
    //    exestr = [exestr stringByDeletingPathExtension];
    //    NSLog(@"%@",exestr);
    //
    //    // 获得文件的后缀名（不带'.'）
    //    exestr = [filePath pathExtension];
    //    NSLog(@"%@",exestr);

    return nil;

}
@end
