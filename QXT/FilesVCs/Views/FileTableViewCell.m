//
//  FileTableViewCell.m
//  QXT
//
//  Created by LingLi on 16/3/24.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "FileTableViewCell.h"
#import "FileModel.h"
@interface FileTableViewCell ()
{
    
    UILabel      *nameLabel;
    UILabel      *urgLabel;
    UILabel      *otherLabel;
    UIImageView  *indexIV;
    UIButton     *moreBtn;
    UIButton     *selectedBtn;
    
}
@end
@implementation FileTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //        self.backgroundColor = [ConfigUITools colorRandomly];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = 0;
        [self creatSelectBtn];
        
    }
    return self;
    
    
}


- (void)creatSelectBtn {

//    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth / 3 * 2   -15, 40)];
//    [nameLabel setTextColor:[UIColor whiteColor]];
//    nameLabel.textColor = [UIColor blackColor];
//    nameLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
//    nameLabel.font = [UIFont systemFontOfSize:15];
//    [self.contentView addSubview:nameLabel];
//    
//    urgLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 3 * 2 + 5 , 0, kScreenWidth / 3 - 15, 40)];
//    [urgLabel setTextColor:[UIColor whiteColor]];
//    urgLabel.textAlignment = 2;
//    urgLabel.font = [UIFont systemFontOfSize:13];
//    urgLabel.textColor = [UIColor blackColor];
//    [self.contentView addSubview:urgLabel];
    
    indexIV = [[UIImageView alloc]init];
    indexIV.layer.cornerRadius = 1;
    indexIV.layer.masksToBounds = 1;
//    indexIV.image = [UIImage imageNamed:@"preview_doc_icon"];
    [self.contentView addSubview:indexIV];
    
    
    nameLabel = [[UILabel alloc]init];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:nameLabel];
    
    
        urgLabel = [[UILabel alloc]init];
//        urgLabel.text = @"uncleChar 于 2016-3-24 13:35 上传";
        urgLabel.textAlignment = 0;
        urgLabel.font = [UIFont systemFontOfSize:12];
        urgLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:urgLabel];
    
     moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 44, 8, 44, 44)];
    [moreBtn setImage:[UIImage imageNamed:@"list_arrow"] forState:UIControlStateNormal];


    moreBtn.imageEdgeInsets = UIEdgeInsetsMake(12.5, 12.5, 12.5, 12.5);
//    [moreBtn setBackgroundImage:[UIImage imageNamed:@"list_arrow"] forState:UIControlStateSelected];
    [moreBtn addTarget:self action:@selector(btnClecked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:moreBtn];
    
    selectedBtn = [[UIButton alloc]init];
    [selectedBtn setBackgroundImage:[UIImage imageNamed:@"common_checxbox_null"] forState:UIControlStateNormal];
    [selectedBtn setBackgroundImage:[UIImage imageNamed:@"common_checxbox_sel"] forState:UIControlStateSelected];
    [selectedBtn addTarget:self action:@selector(selectedBtnClecked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:selectedBtn];

}
- (void)setModel:(EntryModel *)model {

    _model = model;
//    NSLog(@"--- %i",_model.isSelected);

    urgLabel.text = _model.time;
     nameLabel.text = _model.fileName;
    if (model.isSelected) {
        
        selectedBtn.selected = YES;
    }else {
        selectedBtn.selected = NO;
    }

    if ([model.fileAttribute isEqualToString:@"note"]) {
        
        indexIV.image = [UIImage imageNamed:@"file_note"];
    }
    if ([model.fileAttribute isEqualToString:@"txt"]) {
        
        indexIV.image = [UIImage imageNamed:@"preview_txt_icon"];
    }
    if ([model.fileAttribute isEqualToString:@"doc"]) {
        
        indexIV.image = [UIImage imageNamed:@"preview_doc_icon"];
    }
    if ([model.fileAttribute isEqualToString:@"pic"]) {
        
        indexIV.image = [UIImage imageNamed:@"preview_pic_icon"];
    }
    if ([model.fileAttribute isEqualToString:@"pdf"]) {
        
        indexIV.image = [UIImage imageNamed:@"preview_pdf_icon"];
    }
    if ([model.fileAttribute isEqualToString:@"floder"]) {
        
        indexIV.image = [UIImage imageNamed:@"file_personal"];
    }
    if ([model.fileAttribute isEqualToString:@"isShareFloder"]) {
        
        indexIV.image = [UIImage imageNamed:@"file_shared"];
    }
    if ([model.fileAttribute isEqualToString:@"excel"]) {
        
        indexIV.image = [UIImage imageNamed:@"preview_xls_icon"];
    }
    if ([model.fileAttribute isEqualToString:@"zip"]) {
        
        indexIV.image = [UIImage imageNamed:@"preview_rar_icon"];
    }
    if ([model.fileAttribute isEqualToString:@"ppt"]) {
        
        indexIV.image = [UIImage imageNamed:@"preview_ppt_icon"];
    }
    if ([model.fileAttribute isEqualToString:@"video"]) {
        
        indexIV.image = [UIImage imageNamed:@"preview_video_icon"];
    }

}

- (void)selectedBtnClecked:(UIButton *)sender {

    sender.selected = !sender.selected;
    if (sender.selected) {
        
        selectedBtn.selected = YES;
        _model.isSelected = YES;

        if ([_btnCleckddelegate respondsToSelector:@selector(btnSelected: withModel:)]) {
            [_btnCleckddelegate btnSelected:sender withModel:_model];
        }
    }else {
    
        selectedBtn.selected = NO;
        _model.isSelected = NO;
        if ([_btnCleckddelegate respondsToSelector:@selector(btnUnSelected:withModel:)]) {
            [_btnCleckddelegate btnUnSelected:sender withModel:_model];
        }
    }
    
}

- (void)btnClecked:(UIButton *)sender {

//    sender.selected = !sender.selected;
    
//    if (sender.selected) {
//        
//        moreBtn.selected = YES;
//    }else {
//    
//        moreBtn.selected = NO;
//    }
    if (_btnCleckddelegate) {
        
        if ([_btnCleckddelegate respondsToSelector:@selector(tableViewMoreBtnClickedWithModel:)]) {
            
            [self.btnCleckddelegate tableViewMoreBtnClickedWithModel:_model];
        }
        
    }
//    if (self.delegate != nil) {
//        [self.delegate didDismissMenu:self];
//    }
    
}

- (void)setIsNeedSort:(BOOL)isNeedSort {


    _isNeedSort = isNeedSort;
    
    if (_isNeedSort) {
       
        selectedBtn.frame = CGRectMake(10, 17.5, 25, 25);
        indexIV.frame = CGRectMake(50, 10, 40, 40);
        nameLabel.frame = CGRectMake(100, 5, 200, 30);
        urgLabel.frame = CGRectMake(110 , 40, 200, 20);
        
    }else {

        selectedBtn.frame = CGRectMake(0, 0, 0, 0);
        indexIV.frame = CGRectMake(10, 10, 40, 40);
        nameLabel.frame = CGRectMake(60, 5, 200, 30);
        urgLabel.frame = CGRectMake(70 , 40, 200, 20);

    }
}

@end
