//
//  MessageTableViewCell.m
//  QXT
//
//  Created by LingLi on 16/3/28.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "MessageModel.h"


@interface MessageTableViewCell ()
{
    
    UILabel      *titleLabel;
    UILabel      *contentLabel;
    UILabel      *timeLabel;
    UILabel      *numberLabel;
    UIImageView  *avatarIV;

    
}
@end
@implementation MessageTableViewCell

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
    
    
    avatarIV = [[UIImageView alloc]init];
    avatarIV.layer.cornerRadius = 5;
    avatarIV.layer.masksToBounds = 1;
    [self.contentView addSubview:avatarIV];
    
    
    numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 2, 20, 20)];
    numberLabel.textColor = [UIColor whiteColor];
    numberLabel.backgroundColor = [UIColor redColor];
    numberLabel.textAlignment = 1;
    numberLabel.layer.cornerRadius = 10;
    numberLabel.layer.masksToBounds = 1;
    numberLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    numberLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:numberLabel];
    
    
    titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:titleLabel];
    
    
    contentLabel = [[UILabel alloc]init];
    contentLabel.textAlignment = 0;
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:13];
    contentLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:contentLabel];

    timeLabel = [[UILabel alloc]init];
    timeLabel.textAlignment = 0;
    timeLabel.font = [UIFont systemFontOfSize:10];
    timeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:timeLabel];
    
    
    avatarIV.frame = CGRectMake(10, 10, 50, 50);
    titleLabel.frame = CGRectMake(70, 0, kScreenWidth - 80, 50);
    contentLabel.frame = CGRectMake(70, 50, kScreenWidth - 80, 35);
    timeLabel.frame = CGRectMake(70 , 85, kScreenWidth - 80, 10);
    
}

- (void)setModel:(MessageModel *)model {
    _model = model;
    avatarIV.image = [UIImage imageNamed:_model.avatarId];
    titleLabel.text = _model.title;
    contentLabel.text = _model.content;
    timeLabel.text = _model.time;
    if ([_model.number isEqualToString:@"1"]) {
        numberLabel.text = model.number;
    }else {
    
        numberLabel.textColor = [UIColor clearColor];
        numberLabel.backgroundColor = [UIColor clearColor];
    }
    
    
}

@end

