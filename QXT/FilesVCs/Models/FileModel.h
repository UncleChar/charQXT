//
//  FileModel.h
//  QXT
//
//  Created by LingLi on 16/3/24.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileModel : NSObject
@property (nonatomic, assign) BOOL       isSelected;
@property (nonatomic, strong) NSString   *fileName;
@property (nonatomic, strong) NSString   *avatarId;
@property (nonatomic, assign) BOOL       sex;
@end
