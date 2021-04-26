//
//  UIResponder+WLKeyboardResponder.h
//  WLSelfKeyboard
//
//  Created by 蔡元伟 on 2020/2/26.
//  Copyright © 2020 蔡元伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (WLKeyboardResponder)

+ (void)inputText:(NSString *)text replaceAll:(BOOL)replace;

+ (UIResponder *)WLCurrentFirstResponder;

+ (UIView <UITextInput> *)firstResponderTextView;@end

NS_ASSUME_NONNULL_END
