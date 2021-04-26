//
//  WLNumberKeyboard.h
//  WLCustomKeyboard
//
//  Created by 蔡元伟 on 2020/2/11.
//  Copyright © 2020 蔡元伟. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "WLCustomKeyboardSetting.h"
#import "WLCustomKeyboardDefine.h"
@class WLKeyboardButton;

typedef void(^WLChangeASCIIKeyBoardBlock)(NSString * inputText);
typedef void(^WLNumberKeyboardAction)(void);

@interface WLNumberKeyboard  : UIView

@property (nonatomic,assign)WLCustomKeyboardType keyboardType;
@property (nonatomic,copy)WLNumberKeyboardAction numberKeyboardAction;

@property (nonatomic,copy)WLChangeASCIIKeyBoardBlock changeASCIIBlock;
/**
 是否需要切换字母键盘，纯数字键盘是不需要切换字母键盘按钮的，但是字母键盘切换到了数字键盘，是需要有切换字母键盘按钮
 */
@property (nonatomic,assign)BOOL needChangeASCIIKeyBoard;

- (void)btnClick:(WLKeyboardButton *)sender;

-(void)actionWithPoint:(CGPoint)point;


@end
