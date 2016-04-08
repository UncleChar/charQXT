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


@property (nonatomic, strong) NSString   *action;
@property (nonatomic, strong) NSString   *create_uid;
@property (nonatomic, strong) NSString   *desktop_sync;
@property (nonatomic, strong) NSString   *file_count;
@property (nonatomic, strong) NSString   *discuss_count;
@property (nonatomic, strong) NSString   *file_id;
@property (nonatomic, strong) NSString   *file_name;
@property (nonatomic, strong) NSString   *file_size;


@property (nonatomic, strong) NSString   *folder_id;
@property (nonatomic, strong) NSString   *folder_name;
@property (nonatomic, strong) NSString   *folder_size;
@property (nonatomic, strong) NSString   *format_date;
@property (nonatomic, strong) NSString   *format_size;
@property (nonatomic, strong) NSString   *isFolder;
@property (nonatomic, strong) NSString   *isShareObj;
@property (nonatomic, strong) NSString   *isShared;
@property (nonatomic, strong) NSString   *isSyncObj;
@property (nonatomic, strong) NSString   *isSynced;
@property (nonatomic, strong) NSString   *link_id;
@property (nonatomic, strong) NSString   *mime_type;
@property (nonatomic, strong) NSString   *owner_real_name;
@property (nonatomic, strong) NSString   *owner_uid;
@property (nonatomic, strong) NSString   *parent_id;
@property (nonatomic, strong) NSString   *permission;
//@property (nonatomic, strong) NSDictionary   *tags;
@property (nonatomic, strong) NSString   *update_date;
@property (nonatomic, strong) NSString   *user_count;


@end
