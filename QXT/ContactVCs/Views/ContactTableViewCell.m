//
//  ContactTableViewCell.m
//  QXT
//
//  Created by LingLi on 16/3/28.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "ContactTableViewCell.h"
#import "ContactModel.h"
@interface ContactTableViewCell ()
{
    
    UILabel      *nameLabel;
    UILabel      *emailLabel;
    UILabel      *otherLabel;
    UIImageView  *indexIV;
    UIButton     *moreBtn;
    UIButton     *selectedBtn;
    
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

    indexIV = [[UIImageView alloc]init];
    
    [self.contentView addSubview:indexIV];

    nameLabel = [[UILabel alloc]init];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:nameLabel];
    
    emailLabel = [[UILabel alloc]init];
    emailLabel.textColor = [UIColor grayColor];
    emailLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    emailLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:emailLabel];
    
    indexIV.frame = CGRectMake(20, 2, 46, 46);
    indexIV.layer.cornerRadius = 23;
    indexIV.layer.masksToBounds = 1;
    

    
}

- (void)setModel:(ContactModel *)model {
    
    _model = model;

    nameLabel.text  = _model.fileName;
    emailLabel.text = _model.email;
    indexIV.image = [UIImage imageNamed:model.avatarId];
    if ([model.avatarId isEqualToString:@"022"]) {
        nameLabel.frame = CGRectMake(80, 10, kScreenWidth - 120, 30);
        emailLabel.frame = CGRectMake(0, 0, 0, 0);
//        emailLabel.text = @"";
    }else {
        nameLabel.frame = CGRectMake(80, 0, kScreenWidth - 120, 30);
        emailLabel.frame = CGRectMake(80, 25, kScreenWidth - 120, 20);
        emailLabel.text = _model.email;
    }
}
@end
