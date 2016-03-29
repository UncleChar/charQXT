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
    indexIV.image = [UIImage imageNamed:@"file_shared@2x"];
    [self.contentView addSubview:indexIV];
    
    
    nameLabel = [[UILabel alloc]init];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    nameLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:nameLabel];
    
    
        urgLabel = [[UILabel alloc]init];
        urgLabel.text = @"uncleChar 于 2016-3-24 13:35 上传";
        urgLabel.textAlignment = 0;
        urgLabel.font = [UIFont systemFontOfSize:10];
        urgLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:urgLabel];
    
     moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 44, 0, 44, 44)];
    [moreBtn setImage:[UIImage imageNamed:@"list_arrow"] forState:UIControlStateNormal];


    moreBtn.imageEdgeInsets = UIEdgeInsetsMake(12.5, 12.5, 12.5, 12.5);
//    [moreBtn setBackgroundImage:[UIImage imageNamed:@"list_arrow"] forState:UIControlStateSelected];
    [moreBtn addTarget:self action:@selector(btnClecked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:moreBtn];
    
    selectedBtn = [[UIButton alloc]init];
    [selectedBtn setBackgroundImage:[UIImage imageNamed:@"kssz_kqsz"] forState:UIControlStateNormal];
    [selectedBtn setBackgroundImage:[UIImage imageNamed:@"kssz_kqsz_d"] forState:UIControlStateSelected];
    [selectedBtn addTarget:self action:@selector(selectedBtnClecked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:selectedBtn];

}
- (void)setModel:(FileModel *)model {

    _model = model;
//    NSLog(@"--- %i",_model.isSelected);

     nameLabel.text = _model.fileName;
    if (model.isSelected) {
        
        selectedBtn.selected = YES;
    }else {
        selectedBtn.selected = NO;
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
       
        selectedBtn.frame = CGRectMake(7, 7, 30, 30);
        indexIV.frame = CGRectMake(44, 7, 30, 30);
        nameLabel.frame = CGRectMake(84, 5, 200, 20);
        urgLabel.frame = CGRectMake(94 , 30, 200, 14);
        
    }else {

        selectedBtn.frame = CGRectMake(0, 0, 0, 0);
        indexIV.frame = CGRectMake(20, 7, 30, 30);
        nameLabel.frame = CGRectMake(60, 5, 200, 20);
        urgLabel.frame = CGRectMake(70 , 30, 200, 14);

    }
}

@end
