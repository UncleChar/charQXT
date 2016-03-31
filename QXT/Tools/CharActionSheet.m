//
//  Created by 刘超 on 15/4/26.
//  Copyright (c) 2015年 Leo. All rights reserved.
//
//  Email:  devtip@163.com
//  GitHub: http://github.com/LeoiOS
//  如有问题或建议请给我发 Email, 或在该项目的 GitHub 主页 Issues 我, 谢谢:)
//
//

#import "CharActionSheet.h"

// 按钮高度
#define BUTTON_H 40.0f
// 屏幕尺寸
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
// 颜色
#define LCColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

#define LC_ACTION_SHEET_TITLE_FONT  [UIFont systemFontOfSize:18.0f]

#define LC_DEFAULT_ANIMATION_DURATION 0.3f

#define LC_DEFAULT_BACKGROUND_OPACITY 0.3f

@interface CharActionSheet ()

/** 所有按钮 */
@property (nonatomic, strong) NSMutableArray *buttonTitles;

/** 暗黑色的view */
@property (nonatomic, strong) UIView *darkView;

/** 所有按钮的底部view */
@property (nonatomic, strong) UIView *bottomView;



@property (nonatomic, strong) UIWindow *backWindow;



@end

@implementation CharActionSheet

#pragma mark - getter

- (NSString *)cancelText
{
    if (!_cancelText) {
        _cancelText = @"取消";
    }
    
    return _cancelText;
}

- (UIFont *)textFont
{
    if (!_textFont) {
        _textFont = LC_ACTION_SHEET_TITLE_FONT;
    }
    
    return _textFont;
}

- (UIColor *)textColor
{
    if (!_textColor) {
        _textColor = [ConfigUITools colorWithR:23 G:116 B:204 A:1];
    }
    
    return _textColor;
}

- (CGFloat)animationDuration {
    if (!_animationDuration) {
        _animationDuration = LC_DEFAULT_ANIMATION_DURATION;
    }
    
    return _animationDuration;
}

- (CGFloat)backgroundOpacity {
    if (!_backgroundOpacity) {
        _backgroundOpacity = LC_DEFAULT_BACKGROUND_OPACITY;
    }
    
    return _backgroundOpacity;
}


+ (instancetype)sheetWithEntry:(EntryModel *)entry buttonTitles:(NSArray *)buttonTitles redButtonIndex:(NSInteger)redButtonIndex clicked:(CharActionSheetBlock)clicked {
    
    return [[self alloc] initWithEntry:entry buttonTitles:buttonTitles redButtonIndex:redButtonIndex clicked:clicked];
}


- (instancetype)initWithEntry:(EntryModel *)entry
                 buttonTitles:(NSArray *)buttonTitles
               redButtonIndex:(NSInteger)redButtonIndex
                      clicked:(CharActionSheetBlock)clicked{
    
    if (self = [super init]) {
        
        self.entry = entry;
        self.buttonTitles = [[NSMutableArray alloc] initWithArray:buttonTitles];
        self.redButtonIndex = redButtonIndex;
        self.clickedBlock = clicked;
    }
    
    return self;
}

- (void)setupMainView {
    
        // 暗黑色的view
        UIView *darkView = [[UIView alloc] init];
        [darkView setAlpha:0];
        [darkView setUserInteractionEnabled:NO];
        [darkView setFrame:(CGRect){0, 0, SCREEN_SIZE}];
        [darkView setBackgroundColor:LCColor(46, 49, 50)];
        [self addSubview:darkView];
        _darkView = darkView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
        [darkView addGestureRecognizer:tap];
        
        // 所有按钮的底部view
        UIView *bottomView = [[UIView alloc] init];
        [bottomView setBackgroundColor:[UIColor clearColor]];
        _bottomView = bottomView;

        CGFloat vSpace = 60;
//        CGSize titleSize = [self.title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13.0f]}];
//        if (titleSize.width > SCREEN_SIZE.width - 30.0f) {
//            vSpace = 15.0f;
//        }
        
        UIView *titleBgView = [[UIView alloc] init];
        titleBgView.layer.cornerRadius = 3;
        titleBgView.layer.masksToBounds = 1;
        titleBgView.backgroundColor = [UIColor whiteColor];
        titleBgView.frame = CGRectMake(10, -vSpace, SCREEN_SIZE.width - 20, BUTTON_H + vSpace);
        [bottomView addSubview:titleBgView];
        
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 40, 40)];
//        iv.layer.cornerRadius = 3;
//        iv.layer.masksToBounds = 1;
        if ([self.entry.fileAttribute isEqualToString:@"note"]) {
            
            iv.image = [UIImage imageNamed:@"file_note"];
        }
        if ([self.entry.fileAttribute isEqualToString:@"txt"]) {
            
            iv.image = [UIImage imageNamed:@"preview_txt_icon"];
        }
        if ([self.entry.fileAttribute isEqualToString:@"doc"]) {
            
            iv.image = [UIImage imageNamed:@"preview_doc_icon"];
        }
        if ([self.entry.fileAttribute isEqualToString:@"pic"]) {
            
            iv.image = [UIImage imageNamed:@"preview_pic_icon"];
        }
        if ([self.entry.fileAttribute isEqualToString:@"pdf"]) {
            
            iv.image = [UIImage imageNamed:@"preview_pdf_icon"];
        }
        if ([self.entry.fileAttribute isEqualToString:@"floder"]) {
            
            iv.image = [UIImage imageNamed:@"file_personal"];
        }
        if ([self.entry.fileAttribute isEqualToString:@"isShareFloder"]) {
            
            iv.image = [UIImage imageNamed:@"file_shared"];
        }
        if ([self.entry.fileAttribute isEqualToString:@"excel"]) {
            
            iv.image = [UIImage imageNamed:@"preview_xls_icon"];
        }
        if ([self.entry.fileAttribute isEqualToString:@"zip"]) {
            
            iv.image = [UIImage imageNamed:@"preview_rar_icon"];
        }
        if ([self.entry.fileAttribute isEqualToString:@"ppt"]) {
            
            iv.image = [UIImage imageNamed:@"preview_ppt_icon"];
        }
        if ([self.entry.fileAttribute isEqualToString:@"video"]) {
            
            iv.image = [UIImage imageNamed:@"preview_video_icon"];
        }
        [titleBgView addSubview:iv];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iv.frame) + 5, 10, kScreenWidth - 40 - CGRectGetMaxX(iv.frame) - 5, 40)];
        titleLabel.text = self.entry.fileName;
        [titleBgView addSubview:titleLabel];
        // 标题
//        UILabel *label = [[UILabel alloc] init];
//        [label setText:self.title];
//        [label setNumberOfLines:2.0f];
//        [label setTextColor:LCColor(111, 111, 111)];
//        [label setTextAlignment:NSTextAlignmentCenter];
//        [label setFont:[UIFont systemFontOfSize:13.0f]];
//        [label setBackgroundColor:[UIColor whiteColor]];
//        [label setFrame:CGRectMake(15.0f, 0, SCREEN_SIZE.width - 30.0f, titleBgView.frame.size.height)];
//        [titleBgView addSubview:label];


    
    if (self.buttonTitles.count) {
        
        for (int i = 0; i < self.buttonTitles.count; i++) {
            
            // 所有按钮
            UIButton *btn = [[UIButton alloc] init];
            [btn setTag:i];
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn setTitle:self.buttonTitles[i] forState:UIControlStateNormal];
            [[btn titleLabel] setFont:self.textFont];
            UIColor *titleColor = nil;
            titleColor = self.textColor ;
            [btn setTitleColor:titleColor forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.layer.cornerRadius = 3;
            btn.layer.masksToBounds = 1;
            CGFloat btnY = BUTTON_H * (i + (self.title ? 1 : 0));
            [btn setFrame:CGRectMake(10, btnY, SCREEN_SIZE.width - 20, BUTTON_H)];
            [bottomView addSubview:btn];
        }
        
        for (int i = 0; i < self.buttonTitles.count; i++) {

            CGFloat lineY = (i + (self.title ? 1 : 0)) * BUTTON_H;
            
            UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(10, lineY, kScreenWidth - 20, 1)];
            line.backgroundColor = [ConfigUITools colorWithR:187 G:187 B:188 A:1];
            [bottomView addSubview:line];
        }
    }

    // 取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTag:self.buttonTitles.count];
    [cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [cancelBtn setTitle:self.cancelText forState:UIControlStateNormal];
    [[cancelBtn titleLabel] setFont:self.textFont];
    cancelBtn.layer.cornerRadius = 6;
    cancelBtn.layer.masksToBounds = 1;
    [cancelBtn setTitleColor:self.textColor forState:UIControlStateNormal];

    [cancelBtn addTarget:self action:@selector(didClickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat btnY = BUTTON_H * (self.buttonTitles.count + (self.title ? 1 : 0)) + 5.0f;
    [cancelBtn setFrame:CGRectMake(10, btnY, SCREEN_SIZE.width - 20, BUTTON_H)];
    [bottomView addSubview:cancelBtn];
    
    CGFloat bottomH = (self.title ? BUTTON_H : 0) + BUTTON_H * self.buttonTitles.count + BUTTON_H + 5.0f;
    [bottomView setFrame:CGRectMake(0, SCREEN_SIZE.height, SCREEN_SIZE.width, bottomH + 5)];
    
    [self setFrame:(CGRect){0, 0, SCREEN_SIZE}];
}

- (UIWindow *)backWindow {
    
    if (_backWindow == nil) {
        
        _backWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backWindow.windowLevel       = UIWindowLevelStatusBar;
        _backWindow.backgroundColor   = [UIColor clearColor];
        _backWindow.hidden = NO;
    }
    
    return _backWindow;
}


- (void)didClickBtn:(UIButton *)btn {
    
    [self dismiss:nil];

    if (self.clickedBlock) {
        
        self.clickedBlock(btn.tag);
    }
}

- (void)dismiss:(UITapGestureRecognizer *)tap {
    
    [UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [_darkView setAlpha:0];
        [_darkView setUserInteractionEnabled:NO];
        
        CGRect frame = _bottomView.frame;
        frame.origin.y += frame.size.height;
        [_bottomView setFrame:frame];
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        self.backWindow.hidden = YES;
    }];
}

- (void)didClickCancelBtn {
    
    [UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [_darkView setAlpha:0];
        [_darkView setUserInteractionEnabled:NO];
        
        CGRect frame = _bottomView.frame;
        frame.origin.y += frame.size.height;
        [_bottomView setFrame:frame];
        
    } completion:^(BOOL finished) {

        
        if (self.clickedBlock) {
            
            __weak typeof(self) weakSelf = self;
            self.clickedBlock(weakSelf.buttonTitles.count);
        }
        
        [self removeFromSuperview];
        
        self.backWindow.hidden = YES;
    }];
}

- (void)show {
    [self setupMainView];
    self.backWindow.hidden = NO;
    
    [self addSubview:self.bottomView];
    [self.backWindow addSubview:self];
    
    [UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [_darkView setAlpha:self.backgroundOpacity];
        [_darkView setUserInteractionEnabled:YES];
        
        CGRect frame = _bottomView.frame;
        frame.origin.y -= frame.size.height;
        [_bottomView setFrame:frame];
        
    } completion:nil];
}

- (void)addButtonTitle:(NSString *)button
{
    if (!_buttonTitles) {
        _buttonTitles = [[NSMutableArray alloc] init];
    }
    
    [_buttonTitles addObject:button];
}

@end
