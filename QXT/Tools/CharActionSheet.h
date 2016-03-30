
#import <UIKit/UIKit.h>

@class CharActionSheet;

typedef void(^CharActionSheetBlock)(NSInteger buttonIndex);


#pragma mark - LCActionSheet

@interface CharActionSheet : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) EntryModel *entry;

@property (nonatomic, assign) NSInteger redButtonIndex;

@property (nonatomic, copy) CharActionSheetBlock clickedBlock;

/**
 *  Localized cancel text. Default is "取消"
 */
@property (nonatomic, strong) NSString *cancelText;

/**
 *  Default is [UIFont systemFontOfSize:18]
 */
@property (nonatomic, strong) UIFont *textFont;

/**
 *  Default is Black
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 *  Default is 0.3 seconds
 */
@property (nonatomic, assign) CGFloat animationDuration;

/**
 *  Opacity of background, default is 0.3f
 */
@property (nonatomic, assign) CGFloat backgroundOpacity;



#pragma mark - Block Way

/**
 *  返回一个 ActionSheet 对象, 类方法
 *
 *  @param title          提示标题
 *  @param buttonTitles   所有按钮的标题
 *  @param redButtonIndex 红色按钮的 index
 *  @param clicked        点击按钮的 block 回调
 *
 *  Tip: 如果没有红色按钮, redButtonIndex 给 `-1` 即可
 */
+ (instancetype)sheetWithEntry:(EntryModel *)entry
                  buttonTitles:(NSArray *)buttonTitles
                redButtonIndex:(NSInteger)redButtonIndex
                       clicked:(CharActionSheetBlock)clicked;

/**
 *  返回一个 ActionSheet 对象, 实例方法
 *
 *  @param title          提示标题
 *  @param buttonTitles   所有按钮的标题
 *  @param redButtonIndex 红色按钮的 index
 *  @param clicked        点击按钮的 block 回调
 *
 *  Tip: 如果没有红色按钮, redButtonIndex 给 `-1` 即可
 */
- (instancetype)initWithEntry:(EntryModel *)entry
                 buttonTitles:(NSArray *)buttonTitles
               redButtonIndex:(NSInteger)redButtonIndex
                      clicked:(CharActionSheetBlock)clicked;



#pragma mark - Custom Way

/**
 *  Add a button with callback block
 *
 *  @param button
 *  @param block
 */
- (void)addButtonTitle:(NSString *)button;


#pragma mark - Show

/**
 *  显示 ActionSheet
 */
- (void)show;

@end
