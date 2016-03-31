//
//  AboutMyTableViewCell.m
//  QXT
//
//  Created by LingLi on 16/3/28.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "AboutMyTableViewCell.h"

@interface AboutMyTableViewCell ()
{
    
    UILabel      *nameLabel;

    UIImageView  *indexIV;

    
}
@end
@implementation AboutMyTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //        self.backgroundColor = [ConfigUITools colorRandomly];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = 0;
        [self creatSubviews];
        
    }
    return self;
    
    
}
- (void)creatSubviews {
    
    indexIV = [[UIImageView alloc]init];
    
    [self.contentView addSubview:indexIV];
    
    
    nameLabel = [[UILabel alloc]init];
    nameLabel.textColor = [ConfigUITools colorWithR:33 G:126 B:198 A:1];
    nameLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    nameLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:nameLabel];
    indexIV.frame = CGRectMake(20, 24.5, 23, 21);
//    indexIV.layer.cornerRadius = 15;
//    indexIV.layer.masksToBounds = 1;
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.frame = CGRectMake(60, 15, kScreenWidth - 100,40 );
    
    
}

- (void)setName:(NSString *)name {
    
    nameLabel.text = name;
}

- (void)setAvatarStr:(NSString *)avatarStr {
    
    indexIV.image = [UIImage imageNamed:avatarStr];
    
}

@end