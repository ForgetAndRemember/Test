//
//  WLCustomKeyboard.h
//  WLCustomKeyboard
//
//  Created by 蔡元伟 on 2020/2/13.
//  Copyright © 2020 蔡元伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WLCustomKeyboardDefine.h"
@class WLStringText;
@protocol WLCustomKeyboardViewDelegate <NSObject>

@required
/**
 键盘输入内容改变
 */
- (void)keyboardTextDidChange:(NSString *)text;

/**
 键盘输入完成键
*/
- (void)keyboardShouldReturn:(NSString *)text;


-(void)keyboardAction;

@end

@interface WLCustomKeyboardView : UIView

@property (nonatomic,assign)WLCustomKeyboardType keyboardType;
@property(nonatomic,weak) id<WLCustomKeyboardViewDelegate>delegate;
/**
 screenWidth : 车机屏幕宽度
 screenHeight：车机屏幕高度
 */
- (instancetype)initWithWidth:(CGFloat)screenWidth height:(CGFloat)screenHeight;

+(CGFloat)keyboardScreenWidth;
+(CGFloat)keyboardScreenHeigth;

/**
 清空输入内容
 */
- (void)deleteInputString;

- (void)textFieldBegin:(UITextField *)textField;

- (void)textFieldEnd:(UITextField *)textField;

@end
