//
//  FileTableViewCell.h
//  QXT
//
//  Created by LingLi on 16/3/24.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FileModel;
@protocol FileBtnSelectedDelegate <NSObject>

- (void)tableViewMoreBtnClickedWithModel:(FileModel *)model;
- (void)btnSelected:(UIButton *)btn withModel:(FileModel *)model;
- (void)btnUnSelected:(UIButton *)btn withModel:(FileModel *)model;


@end

@interface FileTableViewCell : UITableViewCell

@property (nonatomic ,weak) id<FileBtnSelectedDelegate>  btnCleckddelegate;

@property (nonatomic, strong) FileModel *model;
@property (nonatomic, assign) BOOL isNeedSort;

@end
