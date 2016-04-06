//
//  ContactTableViewCell.m
//  QXT
//
//  Created by LingLi on 16/3/28.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "ContactTableViewCell.h"
#import "ContactModel.h"
#import "NSString+Size.h"
@interface ContactTableViewCell ()
{
    
    UILabel      *nameLabel;
    UILabel      *emailLabel;
    UILabel      *otherLabel;
    UIImageView  *indexIV;
    UIButton     *moreBtn;
    UIButton     *selectedBtn;
    
    UIImageView  *sexIV;
    
}
@end
@implementation ContactTableViewCell
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

//    UIView *backView = [[UIView alloc]init];
//    backView.backgroundColor = kBaseColor;
//    [self.contentView addSubview:backView];
    
    indexIV = [[UIImageView alloc]init];
    [self.contentView addSubview:indexIV];
    
    sexIV = [[UIImageView alloc]init];
    [self.contentView addSubview:sexIV];

   
    nameLabel = [[UILabel alloc]init];
//    nameLabel.backgroundColor = [UIColor purpleColor];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:nameLabel];
    
    emailLabel = [[UILabel alloc]init];
    emailLabel.textColor = [UIColor grayColor];
    emailLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    emailLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:emailLabel];
    
    
//    backView.frame = CGRectMake(20, 1, 48, 48);
//    backView.layer.cornerRadius = 24;
//    backView.layer.masksToBounds = 1;
    
    indexIV.frame = CGRectMake(20, 2, 46, 46);
    
    
    
    
}

- (void)setModel:(ContactModel *)model {
    
    _model = model;

    nameLabel.text  = _model.fileName;
    emailLabel.text = _model.email;
    indexIV.image = [UIImage imageNamed:model.avatarId];

    if ([model.avatarId isEqualToString:@"section.jpg"]) {
        nameLabel.frame = CGRectMake(80, 10, kScreenWidth - 120, 30);
        emailLabel.frame = CGRectMake(0, 0, 0, 0);
        sexIV.frame = CGRectMake(0, 0, 0, 0);
   
        indexIV.layer.cornerRadius = 2;
        indexIV.layer.masksToBounds = 1;
//        emailLabel.text = @"";
    }else {

        indexIV.layer.cornerRadius = 23;
        indexIV.layer.masksToBounds = 1;
        CGFloat sizeWidth = [_model.fileName widthWithFont:[UIFont systemFontOfSize:15] constrainedToHeight:30];

        nameLabel.frame = CGRectMake(80, 0, sizeWidth, 30);
        emailLabel.frame = CGRectMake(80, 25, kScreenWidth - 120, 20);
        emailLabel.text = _model.email;
        sexIV.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame) + 5, 9, 12, 12);
        if (_model.sex) {//男性
            sexIV.image=[UIImage imageNamed:@"lbs_nearby_filter_icon_male"];
            
        }else {
            
            sexIV.image=[UIImage imageNamed:@"lbs_nearby_filter_icon_female"];
            
        }
        
        
    }
}
@end
