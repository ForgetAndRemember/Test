//
//  WLCustomKeyboard.m
//  WLCustomKeyboard
//
//  Created by 蔡元伟 on 2020/2/13.
//  Copyright © 2020 蔡元伟. All rights reserved.
//
#import "WLCustomKeyboardView.h"
#import "WLNumberKeyboard.h"
#import "WLASCIIKeyboard.h"
#import "WLCustomKeyboardSetting.h"
#import "WLKeyboardButton.h"
#import "UIResponder+WLKeyboardResponder.h"
#import "WLStringText.h"
#import "WLScaleManager.h"


@interface WLCustomKeyboardView()


/**
 切换键盘时记录上一个键盘类型
 */
@property (nonatomic,assign)WLCustomKeyboardType lastKeyboardType;

/**
 用于类型和键盘对应
 */
@property (nonatomic,strong)NSDictionary *typeDictionary;

/**
数字键盘
*/
@property (nonatomic,strong)WLNumberKeyboard *numberKeyBoard;

/**
 字母键盘
 */
@property (nonatomic,strong)WLASCIIKeyboard *asciiKeyBoard;

/**
 文字处理对象
 */
//@property (nonatomic,strong)WLStringText *textField;

@end

@implementation WLCustomKeyboardView


#pragma mark - init

- (instancetype)initWithWidth:(CGFloat)screenWidth height:(CGFloat)screenHeight
{
    self = [super init];
    if (self) {
        
        [WLScaleManager sharedInstance].screenHeight = screenHeight ;
        [WLScaleManager sharedInstance].screenWidth = screenWidth ;
        if (screenHeight==240) {
            [WLScaleManager sharedInstance].carType=1;
        }else{
            [WLScaleManager sharedInstance].carType=0;
        }
        self.frame = CGRectMake(0, 0, kWLCustomKeyboardWidth, kWLCustomKeyboardHeight);
        self.backgroundColor = kWLKeyboardViewBackgroundColor;
        [self addSubview:self.numberKeyBoard];
        [self addSubview:self.asciiKeyBoard];
//        self.textField.delegate = self;
        //默认是ASCII类型
        self.keyboardType = WLCustomKeyboardTypeASCII;
        [self showKeyBoard];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:@"KeyBoardTextChange" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textShouldReturn:) name:@"KeyBoardComplete" object:nil];
       
    }
    return self;
}

+(CGFloat)keyboardScreenWidth{
    return [WLScaleManager sharedInstance].screenWidth;
}
+(CGFloat)keyboardScreenHeigth{
    return [WLScaleManager sharedInstance].screenHeight;
}

#pragma mark - private

/**
 展示当前类型的键盘
 */
- (void)showKeyBoard
{
    for (NSNumber *typeNumber in self.typeDictionary.allKeys) {
        UIView *keyBoard = [self.typeDictionary objectForKey:typeNumber];
        keyBoard.hidden = (typeNumber.integerValue != self.keyboardType);
    }
}

#pragma mark - set & get

- (void)setKeyboardType:(WLCustomKeyboardType)keyboardType
{
    _keyboardType = keyboardType;
    [self showKeyBoard];
}

- (NSDictionary *)typeDictionary
{
    if (!_typeDictionary) {
        _typeDictionary = @{@(WLCustomKeyboardTypeNumber):self.numberKeyBoard,
                            @(WLCustomKeyboardTypeASCII):self.asciiKeyBoard};
    }
    return _typeDictionary;
}

- (WLNumberKeyboard *)numberKeyBoard
{
    if (!_numberKeyBoard) {
        _numberKeyBoard = [[WLNumberKeyboard alloc] initWithFrame:self.bounds];
        _numberKeyBoard.keyboardType = WLCustomKeyboardTypeNumber;
        __weak __typeof(self)weakCustom = self;
        _numberKeyBoard.numberKeyboardAction = ^{
            if ([weakCustom.delegate respondsToSelector:@selector(keyboardAction)]) {
                [weakCustom.delegate keyboardAction];
            }
        };
        _numberKeyBoard.changeASCIIBlock = ^(NSString * inputText){
//            NSLog(@"inputtext %@",inputText);
            weakCustom.keyboardType = WLCustomKeyboardTypeASCII;
            [weakCustom showKeyBoard];
            weakCustom.lastKeyboardType = WLCustomKeyboardTypeASCII;
            if(weakCustom.asciiKeyBoard){
                [weakCustom.asciiKeyBoard formNumberKeyboard:inputText];
            }
            if (inputText.length == 0) {
                for (UIView *subView in weakCustom.asciiKeyBoard.subviews) {
                    if ([subView isKindOfClass:[WLKeyboardButton class]]) {
                        WLKeyboardButton *subBtn = (WLKeyboardButton *)subView;
                        if (subBtn.KeyboardButtonType == WLKeyboardButtonTypeComplete && weakCustom.keyboardType == WLCustomKeyboardTypeASCII) {
                            subBtn.userInteractionEnabled = NO;
                            [subBtn setTitleColor:kWLKeyboardBtnNoClickTitleColor forState:UIControlStateNormal];
                        }
                    }
                }
            }else{

                for (UIView *subView in weakCustom.asciiKeyBoard.subviews) {
                    if ([subView isKindOfClass:[WLKeyboardButton class]]) {
                        WLKeyboardButton *subBtn = (WLKeyboardButton *)subView;
                        if (subBtn.KeyboardButtonType == WLKeyboardButtonTypeComplete && weakCustom.keyboardType == WLCustomKeyboardTypeASCII) {
                            subBtn.userInteractionEnabled = YES;
                            [subBtn setTitleColor:kWLKeyboardBtnDarkTitleColor forState:UIControlStateNormal];
                        }
                    }
                }
            }
        };
    }
    return _numberKeyBoard;
}

- (WLASCIIKeyboard *)asciiKeyBoard
{
    if (!_asciiKeyBoard) {
        _asciiKeyBoard = [[WLASCIIKeyboard alloc] initWithFrame:self.bounds];
        __weak __typeof(self)weakCustom = self;
        _asciiKeyBoard.aSCIIKeyboardAction = ^{
            if ([weakCustom.delegate respondsToSelector:@selector(keyboardAction)]) {
                          [weakCustom.delegate keyboardAction];
            }
        };
        _asciiKeyBoard.changeNumberBlock = ^{
            
            //切换到数字键盘
            if (weakCustom.lastKeyboardType == WLCustomKeyboardTypeASCII) {
                weakCustom.keyboardType = WLCustomKeyboardTypeNumber;
                weakCustom.numberKeyBoard.needChangeASCIIKeyBoard = YES;
                [weakCustom showKeyBoard];
            }
    
            weakCustom.lastKeyboardType = WLCustomKeyboardTypeNumber;
//            UIView <UITextInput> *textView = [UIResponder firstResponderTextView];
//            UITextField *textField = (UITextField *)textView;
            if ([WLStringText sharedInstance].inputString.length == 0) {
                for (UIView *subView in weakCustom.numberKeyBoard.subviews) {
                    if ([subView isKindOfClass:[WLKeyboardButton class]]) {
                        WLKeyboardButton *subBtn = (WLKeyboardButton *)subView;
                        if (subBtn.KeyboardButtonType == WLKeyboardButtonTypeComplete && weakCustom.keyboardType == WLCustomKeyboardTypeNumber) {
                            subBtn.userInteractionEnabled = NO;
                            [subBtn setTitleColor:kWLKeyboardBtnNoClickTitleColor forState:UIControlStateNormal];
                        }
                    }
                }
            }else{

                for (UIView *subView in weakCustom.numberKeyBoard.subviews) {
                    if ([subView isKindOfClass:[WLKeyboardButton class]]) {
                        WLKeyboardButton *subBtn = (WLKeyboardButton *)subView;
                        if (subBtn.KeyboardButtonType == WLKeyboardButtonTypeComplete && weakCustom.keyboardType == WLCustomKeyboardTypeNumber) {
                            subBtn.userInteractionEnabled = YES;
                            [subBtn setTitleColor:kWLKeyboardBtnDarkTitleColor forState:UIControlStateNormal];
                        }
                    }
                }
            }
            
        };
    }
    return _asciiKeyBoard;
}

//通知键盘收起
- (void)textFieldEnd:(UITextField *)textField{
    
//    NSString *str = [_asciiKeyBoard.textInputSaveStr stringByAppendingString:_asciiKeyBoard.btnAllText];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[WLStringText sharedInstance].inputString];
    [attrStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleNone] range:NSMakeRange(0, [WLStringText sharedInstance].inputString.length)];
    [WLStringText sharedInstance].attributedText = attrStr;
    [_asciiKeyBoard clearPinYinArea];
   
    _asciiKeyBoard.textInputSaveStr = [WLStringText sharedInstance].inputString;
    [_asciiKeyBoard.btnAllText deleteCharactersInRange:NSMakeRange(0, _asciiKeyBoard.btnAllText.length)];
    WLKeyboardButton *backBtn = [self.numberKeyBoard viewWithTag:kKLBackTag];
    
    if (backBtn) {
        
        [self.numberKeyBoard btnClick:backBtn];
    }
    
    WLKeyboardButton *ABCbtn = [self.asciiKeyBoard viewWithTag:kKLABCTag];
    if (ABCbtn.selected) {
        
        [self.asciiKeyBoard endKeyBoard:ABCbtn];
    }
    WLKeyboardButton *gooleBtn = [self.asciiKeyBoard viewWithTag:kKLGooleTag];
    if (gooleBtn.selected) {
        [self.asciiKeyBoard keyBoardToggleCase:gooleBtn];
    }
    if ([WLStringText sharedInstance].inputString.length) {
        for (UIView *subView in self.asciiKeyBoard.subviews) {
            if ([subView isKindOfClass:[WLKeyboardButton class]]) {
                WLKeyboardButton *subBtn = (WLKeyboardButton *)subView;
                if (subBtn.KeyboardButtonType == WLKeyboardButtonTypeComplete && self.keyboardType == WLCustomKeyboardTypeASCII) {
                    subBtn.userInteractionEnabled = YES;
                    [subBtn setTitle:@"完成" forState:UIControlStateNormal];
                    [subBtn setTitleColor:kWLKeyboardBtnDarkTitleColor forState:UIControlStateNormal];
                }
            }
        }

    }
    
}

- (void)textFieldBegin:(UITextField *)textField{
    
    if ([WLStringText sharedInstance].inputString.length == 0) {
        for (UIView *subView in self.asciiKeyBoard.subviews) {
            if ([subView isKindOfClass:[WLKeyboardButton class]]) {
                WLKeyboardButton *subBtn = (WLKeyboardButton *)subView;
                if (subBtn.KeyboardButtonType == WLKeyboardButtonTypeComplete && self.keyboardType == WLCustomKeyboardTypeASCII) {
                    subBtn.userInteractionEnabled = NO;
                    [subBtn setTitleColor:kWLKeyboardBtnNoClickTitleColor forState:UIControlStateNormal];
                }
            }
        }
    }else{
        
        for (UIView *subView in self.asciiKeyBoard.subviews) {
            if ([subView isKindOfClass:[WLKeyboardButton class]]) {
                WLKeyboardButton *subBtn = (WLKeyboardButton *)subView;
                if (subBtn.KeyboardButtonType == WLKeyboardButtonTypeComplete && self.keyboardType == WLCustomKeyboardTypeASCII) {
                    subBtn.userInteractionEnabled = YES;
                    [subBtn setTitleColor:kWLKeyboardBtnDarkTitleColor forState:UIControlStateNormal];
                }
            }
        }
    }
}

- (void)deleteInputString{
    
    [[WLStringText sharedInstance].inputString deleteCharactersInRange:NSMakeRange(0, [WLStringText sharedInstance].inputString.length)];
    [_asciiKeyBoard clearPinYinArea];
    
    _asciiKeyBoard.textInputSaveStr = [WLStringText sharedInstance].inputString;
    [_asciiKeyBoard.btnAllText deleteCharactersInRange:NSMakeRange(0, _asciiKeyBoard.btnAllText.length)];
//    if ([self.delegate respondsToSelector:@selector(keyboardTextDidChange:)]) {
//           
//        [self.delegate keyboardTextDidChange: [WLStringText sharedInstance].inputString];
//    }
}

- (void)textShouldReturn:(NSNotification*)notic{
        NSString *text = [[notic userInfo] objectForKey:@"text"];
       if ([self.delegate respondsToSelector:@selector(keyboardShouldReturn:)]) {
           
           [self.delegate keyboardShouldReturn:text];
           
       }

}

- (void)textDidChange:(NSNotification*)notic{
    
    NSString *text = [[notic userInfo] objectForKey:@"text"];
    if ([self.delegate respondsToSelector:@selector(keyboardTextDidChange:)]) {
           
        [self.delegate keyboardTextDidChange:text];
           
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [super touchesBegan:touches withEvent:event];
    
    
    // 如果交互未打开，或者透明度小于0.05 或者 视图被隐藏
    if (self.userInteractionEnabled == NO || self.alpha < 0.05 || self.hidden == YES)
    {
        return;
    }
    
    NSLog(@"keyboard touchesBegan touches=%@ event=%@",touches,event);
    
    UITouch *touch = [touches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    int x = point.x;
    int y = point.y;
    NSLog(@"touch (x, y) is (%d, %d)", x, y);
    
    
        if ( self.keyboardType == WLCustomKeyboardTypeASCII) {
            //字母键盘
            if ([self.numberKeyBoard respondsToSelector:@selector(actionWithPoint:)]) {
                [self.asciiKeyBoard actionWithPoint:point];
                
            }
        }else{
            //数字键盘
            if ([self.asciiKeyBoard respondsToSelector:@selector(actionWithPoint:)]) {
                [self.numberKeyBoard actionWithPoint:point];
            }
        }
       
       
}

@end



