//
//  EntryModel.h
//  QXT
//
//  Created by LingLi on 16/3/30.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntryModel : NSObject
@property (nonatomic, assign) BOOL       isSelected;
@property (nonatomic, strong) NSString   *fileName;
@property (nonatomic, strong) NSString   *fileAttribute;
@property (nonatomic, strong) NSString   *time;
@property (nonatomic, strong) NSString   *actionOpreat;
@end
