//
//  ContactTableViewCell.m
//  QXT
//
//  Created by LingLi on 16/3/28.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "ContactTableViewCell.h"

@interface ContactTableViewCell ()
{
    
    UILabel      *nameLabel;
    UILabel      *urgLabel;
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
    nameLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:nameLabel];
    indexIV.frame = CGRectMake(20, 2, 40, 40);
    indexIV.layer.cornerRadius = 20;
    indexIV.layer.masksToBounds = 1;
    nameLabel.frame = CGRectMake(80, 12, 200, 20);

    
}
- (void)setModel:(FileModel *)model {
    
    _model = model;

    nameLabel.text = _model.fileName;
    indexIV.image = [UIImage imageNamed:model.avatarId];
}
@end
