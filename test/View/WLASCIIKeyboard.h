//
//  WLASCIIKeyboard.h
//  WLCustomKeyboard
//
//  Created by 蔡元伟 on 2020/2/14.
//  Copyright © 2020 蔡元伟. All rights reserved.
//
#import <UIKit/UIKit.h>
@class WLKeyboardButton;

typedef void(^WLChangeNumberKeyBoardBlock)(void);
typedef void(^WLChangePinYinKeyBoardBlock)(NSArray *);
typedef void(^WLASCIIKeyboardAction)(void);

@interface WLASCIIKeyboard  : UIView

@property (nonatomic,copy)WLChangeNumberKeyBoardBlock changeNumberBlock;
@property (nonatomic,copy)WLASCIIKeyboardAction aSCIIKeyboardAction;
@property (nonatomic, copy)NSString * textInputSaveStr;        //输入框保存内容字符串
@property (nonatomic, copy)NSMutableString *btnAllText;        //待选拼音的字符串
- (void) formNumberKeyboard:(NSString *) inputText;
- (void)clearPinYinArea;                                    //清除待选词区域
- (void)endKeyBoard:(WLKeyboardButton *)btn;               //键盘收回恢复默认中文模式
- (void)keyBoardToggleCase:(WLKeyboardButton *)btn;          //切换大小写

-(void)actionWithPoint:(CGPoint)point;

@end
