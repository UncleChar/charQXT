//
//  FileTableViewCell.h
//  QXT
//
//  Created by LingLi on 16/3/24.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FileBtnSelectedDelegate <NSObject>

- (void)tableViewMoreBtnClickedWithModel:(EntryModel *)model;
- (void)btnSelected:(UIButton *)btn withModel:(EntryModel *)model;
- (void)btnUnSelected:(UIButton *)btn withModel:(EntryModel *)model;


@end

@interface FileTableViewCell : UITableViewCell

@property (nonatomic ,weak) id<FileBtnSelectedDelegate>  btnCleckddelegate;

@property (nonatomic, strong) EntryModel *model;
@property (nonatomic, assign) BOOL isNeedSort;

@end
