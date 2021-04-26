//
//  UIResponder+WLKeyboardResponder.m
//  WLSelfKeyboard
//
//  Created by 蔡元伟 on 2020/2/26.
//  Copyright © 2020 蔡元伟. All rights reserved.
//

#import "UIResponder+WLKeyboardResponder.h"

@implementation UIResponder (WLKeyboardResponder)

static __weak id WLCurrentFirstResponder;

+ (void)inputText:(NSString *)text replaceAll:(BOOL)replace
{
    UIView <UITextInput> *textInput = [UIResponder firstResponderTextView];
    NSString *character = [NSString stringWithString:text];
    
    BOOL canEditor = YES;
    if ([textInput isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField *)textInput;
        if ([textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            canEditor = [textField.delegate textField:textField shouldChangeCharactersInRange:NSMakeRange(textField.text.length, 0) replacementString:character];
        }
        
        if (canEditor) {
            if(replace){
                UITextRange* rangeold = textField.selectedTextRange;
                UITextPosition *start = [textField positionFromPosition:[textField beginningOfDocument] offset:0];
                UITextRange * range = [textField textRangeFromPosition:start toPosition:rangeold.end];
                [textField setSelectedTextRange:range];
            }
            
            [textField replaceRange:textField.selectedTextRange withText:text];
        }
    }
    
    if ([textInput isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)textInput;
        
        if ([textView.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
            canEditor = [textView.delegate textView:textView shouldChangeTextInRange:NSMakeRange(textView.text.length, 0) replacementText:character];
        }
        
        if (canEditor) {
            [textView replaceRange:textView.selectedTextRange withText:text];
        }
    }
}


+ (UIView <UITextInput> *)firstResponderTextView
{
    UIView <UITextInput> *textInput = (UIView <UITextInput> *)[UIResponder WLCurrentFirstResponder];
    
    if ([textInput conformsToProtocol:@protocol(UIKeyInput)]) {
        return textInput;
    }
    return nil;
}

+ (UIResponder *)WLCurrentFirstResponder {
    WLCurrentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder:) to:nil from:nil forEvent:nil];
    
    return WLCurrentFirstResponder;
}

- (UIResponder *)WLCurrentFirstResponder {
    return [[self class] WLCurrentFirstResponder];
}

- (void)findFirstResponder:(id)sender {
    WLCurrentFirstResponder = self;
}

@end
