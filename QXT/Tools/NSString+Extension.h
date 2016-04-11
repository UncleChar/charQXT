//
//  NSString+Extension.h
//  UncleCharDemos
//
//  Created by LingLi on 16/1/13.
//  Copyright © 2016年 hailong.xie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 *  计算当前文件\文件夹的内容大小
 */
- (NSInteger)calculateFileSize;

- (NSString *)stringExestrWithInt:(NSInteger )integer forString:(NSString *)nameStr;




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
@end
