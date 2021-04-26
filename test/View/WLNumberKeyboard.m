//
//  NSObject+WLNumberKeyboard.m
//  WLCustomKeyboard
//
//  Created by 蔡元伟 on 2020/2/11.
//  Copyright © 2020 蔡元伟. All rights reserved.
//

#import "WLNumberKeyboard.h"
#import "WLKeyboardButton.h"
#import "UIResponder+WLKeyboardResponder.h"
#import "WLStringText.h"
#import "WLSourcePathHandle.h"


@interface WLNumberKeyboard(){
    
    NSTimer *_timer;
}

@end

@implementation WLNumberKeyboard

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kWLKeyboardViewBackgroundColor;
        [self createKeyBoard];
    }
    return self;
}

#pragma mark - private

- (void)createKeyBoard
{
    NSArray *keyBoards1 = nil;
    NSArray *keyBoards2 = nil;
    NSArray *keyBoards3 = nil;
    NSArray *keyBoards4 = nil;
    
    keyBoards1 = @[@(1), @(2), @(3), @(4), @(5), @(6), @(7), @(8), @(9), @(0)];
    keyBoards2 = @[@(WLKeyboardButtonTypeHyphen), @(WLKeyboardButtonTypeSlash), @(WLKeyboardButtonTypeColon), @(WLKeyboardButtonTypeSemicolon), @(WLKeyboardButtonTypeOpeningParenthesis), @(WLKeyboardButtonTypeClosingParenthesis), @(WLKeyboardButtonTypeOther1), @(WLKeyboardButtonTypeAt), @(WLKeyboardButtonTypeQuotationMark1), @(WLKeyboardButtonTypeQuotationMark2)];
    keyBoards3 = @[@(WLKeyboardButtonTypeHash), @(WLKeyboardButtonTypePeriod), @(WLKeyboardButtonTypeComma), @(WLKeyboardButtonTypeCaesura), @(WLKeyboardButtonTypeQuestion), @(WLKeyboardButtonTypeBang), @(WLKeyboardButtonTypeDecimal), @(WLKeyboardButtonTypeDelete)];
    keyBoards4 = @[@(WLKeyboardButtonTypeBack), @(WLKeyboardButtonTypeSpace), @(WLKeyboardButtonTypeComplete)];
    
    //第一排键盘
    //计算btn宽
    CGFloat btnWidth = (kWLCustomKeyboardWidth - (kWLNumberKeyboardBtnSideX * 2) - (kWLNumberKeyboardBtnSpaceX * (keyBoards1.count - 1))) / keyBoards1.count;
    //计算btn高
    CGFloat btnHeight = (kWLCustomKeyboardHeight - kWLPinYinHeight -  kWLNumberKeyboardBtnSideY - kWLNumberKeyboardBtnSpaceY * 4) / 4;
    
    //按键垂直起始位置坐标
    CGFloat nextOffsetY = kWLPinYinHeight + kWLNumberKeyboardBtnSideY;

    for (int i = 0; i < keyBoards1.count; i++) {
        NSInteger keyBoardType = [[keyBoards1 objectAtIndex:i] integerValue];
        WLKeyboardButton *btn = [self createBtn];
        //设置类型
        btn.KeyboardButtonType = WLKeyboardButtonTypeNumber;
        //WLKeyboardButtonTypeNumber需要设置setTitle
        [btn setTitle:[NSString stringWithFormat:@"%zd",keyBoardType] forState:UIControlStateNormal];
        //设置显示位置
        btn.frame = CGRectMake(kWLNumberKeyboardBtnSideX + (i * (btnWidth + kWLNumberKeyboardBtnSpaceX)), nextOffsetY, btnWidth, btnHeight);
        //添加
        [self addSubview:btn];
    }
    nextOffsetY = nextOffsetY + btnHeight + kWLNumberKeyboardBtnSpaceY;

    //第二排键盘
    for (int i = 0; i < keyBoards2.count; i++) {
        NSInteger keyBoardType = [[keyBoards2 objectAtIndex:i] integerValue];
        WLKeyboardButton *btn = [self createBtn];
        //设置类型
        btn.KeyboardButtonType = keyBoardType;

        //设置显示位置
        btn.frame = CGRectMake(kWLNumberKeyboardBtnSideX + (i * (btnWidth + kWLNumberKeyboardBtnSpaceX)), nextOffsetY, btnWidth, btnHeight);
        //添加
        [self addSubview:btn];
    }
    nextOffsetY = nextOffsetY + btnHeight + kWLNumberKeyboardBtnSpaceY;

    //第三排键盘
    CGFloat btn3Width = (kWLCustomKeyboardWidth - (kWLNumberKeyboardBtnSideX * 2) - (kWLNumberKeyboardBtnSpaceX2 * (keyBoards3.count - 1))) / keyBoards3.count;

    for (int i = 0; i < keyBoards3.count; i++) {
        NSInteger keyBoardType = [[keyBoards3 objectAtIndex:i] integerValue];
        WLKeyboardButton *btn = [self createBtn];
        //设置类型
        btn.KeyboardButtonType = keyBoardType;
        if (keyBoardType == WLKeyboardButtonTypeDelete) {
            [btn setBackgroundImage:[UIImage imageNamed:@"Image.bundle/shuzi_shanchu_bg"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"Image.bundle/shuzi_shanchu_bg_n"] forState:UIControlStateHighlighted];
            UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(reduceText:)];

            [btn addGestureRecognizer:press];
        }

        //设置显示位置
        btn.frame = CGRectMake(kWLNumberKeyboardBtnSideX + (i * (btn3Width + kWLNumberKeyboardBtnSpaceX2)), nextOffsetY, btn3Width, btnHeight);
        
        //添加
        [self addSubview:btn];
    }
    nextOffsetY = nextOffsetY + btnHeight + kWLNumberKeyboardBtnSpaceY;

    //第四排键盘
    CGFloat fanhuiWidth = 146*kWLScaleWidth;
    CGFloat wanchengWidth = 130*kWLScaleWidth;
    CGFloat btnSpaceWidth = kWLCustomKeyboardWidth  - 2*kWLNumberKeyboardBtnSideX - 2*kWLNumberKeyboardBtnSpaceX2 - fanhuiWidth - wanchengWidth ;
    
    for (int i = 0; i < keyBoards4.count; i++) {
        NSInteger keyBoardType = [[keyBoards4 objectAtIndex:i] integerValue];
        WLKeyboardButton *btn = [self createBtn];
        //设置类型
        btn.KeyboardButtonType = keyBoardType;
        if(i == 0){
             btn.frame = CGRectMake(kWLNumberKeyboardBtnSideX, nextOffsetY, fanhuiWidth, btnHeight);
        }
        else if(i == 1){
             btn.frame = CGRectMake(kWLNumberKeyboardBtnSideX + fanhuiWidth + kWLNumberKeyboardBtnSpaceX2, nextOffsetY, btnSpaceWidth, btnHeight);
        }
        else if(i == 2){
            btn.frame = CGRectMake(kWLCustomKeyboardWidth - kWLNumberKeyboardBtnSideX - wanchengWidth , nextOffsetY, wanchengWidth, btnHeight);
    
            btn.userInteractionEnabled = NO;
            [btn setTitleColor:kWLKeyboardBtnNoClickTitleColor forState:UIControlStateNormal];
        }

        //添加
        [self addSubview:btn];
    }
}

//长按手势
- (void)reduceText:(UILongPressGestureRecognizer *)gesture{

    if (gesture.state == UIGestureRecognizerStateBegan) {

        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(longClick) userInfo:nil repeats:YES];

    }else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled){

        [_timer invalidate];

        _timer = nil;

    }

}

- (void)longClick{
    
//    UIView <UITextInput> *textView = [UIResponder firstResponderTextView];
//    UITextField *textField = (UITextField *)textView;
    [[WLStringText sharedInstance] deleteInputeString];
    if ([WLStringText sharedInstance].inputString.length == 0) {
        for (UIView *subView in self.subviews) {
            if ([subView isKindOfClass:[WLKeyboardButton class]]) {
                WLKeyboardButton *subBtn = (WLKeyboardButton *)subView;
                if (subBtn.KeyboardButtonType == WLKeyboardButtonTypeComplete && self.keyboardType == WLCustomKeyboardTypeNumber) {
                    subBtn.userInteractionEnabled = NO;
                    [subBtn setTitleColor:kWLKeyboardBtnNoClickTitleColor forState:UIControlStateNormal];
                }
            }
        }
    }
    
}

- (WLKeyboardButton *)createBtn
{
    WLKeyboardButton *btn = [WLKeyboardButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


-(void)actionWithPoint:(CGPoint)point{
    for (UIView * subview in self.subviews) {
        if ([subview isKindOfClass:[WLKeyboardButton class]]) {
            if (CGRectContainsPoint(subview.frame, point)) {
                  WLKeyboardButton * button=(WLKeyboardButton*)subview;
                            NSLog(@"%@被点击 frame(x=%f,y=%f,width=%f,height=%f)",
                                  button.titleLabel.text,
                                  button.frame.origin.x,
                                  button.frame.origin.y,
                                  button.frame.size.width,
                                  button.frame.size.height
                                  );
                if (button.hidden==NO) {
                    [self btnClick:(WLKeyboardButton*)button];
                }
                break;

            }
        }
    }
}

/**
 点击
 
 @param sender btn
 */
- (void)btnClick:(WLKeyboardButton *)sender
{
 
    
    
//    UIView <UITextInput> *textView = [UIResponder firstResponderTextView];
//    UITextField *textField = (UITextField *)textView;
    
    switch (sender.KeyboardButtonType) {
            
        case WLKeyboardButtonTypeNumber://数字
        case WLKeyboardButtonTypeLetter://字母
        case WLKeyboardButtonTypeNone://空白
        case WLKeyboardButtonTypeHyphen://-
        case WLKeyboardButtonTypeSlash:   ///
        case WLKeyboardButtonTypeColon:   //:
        case WLKeyboardButtonTypeSemicolon:   //;
        case WLKeyboardButtonTypeOpeningParenthesis:  //(
        case WLKeyboardButtonTypeClosingParenthesis:  //)
        case WLKeyboardButtonTypeOther1:  //¥
        case WLKeyboardButtonTypeAt:  //@
        case WLKeyboardButtonTypeQuotationMark1:  //“
        case WLKeyboardButtonTypeQuotationMark2:  //”
        case WLKeyboardButtonTypeHash:    //#
        case WLKeyboardButtonTypePeriod:  //句号
        case WLKeyboardButtonTypeComma:   //,
        case WLKeyboardButtonTypeCaesura:     //顿号
        case WLKeyboardButtonTypeQuestion:    //?
        case WLKeyboardButtonTypeBang:    //!
        case WLKeyboardButtonTypeDecimal: //数字键盘小数点.
        {
            if ([WLStringText sharedInstance].inputString.length > 25) {
                return;
            }
            for (UIView *subView in self.subviews) {
                if ([subView isKindOfClass:[WLKeyboardButton class]]) {
                    WLKeyboardButton *subBtn = (WLKeyboardButton *)subView;
                    if (subBtn.KeyboardButtonType == WLKeyboardButtonTypeComplete && self.keyboardType == WLCustomKeyboardTypeNumber) {
                        subBtn.userInteractionEnabled = YES;
                        [subBtn setTitleColor:kWLKeyboardBtnDarkTitleColor forState:UIControlStateNormal];
                    }
                }
            }
            
            [self inputNumber:sender.titleLabel.text replaceAll:NO];
            [self action];
            
        }
            break;
        case WLKeyboardButtonTypeDelete:{
            //删除
            [[WLStringText sharedInstance] deleteInputeString];
            if ([WLStringText sharedInstance].inputString.length == 0) {
                for (UIView *subView in self.subviews) {
                    if ([subView isKindOfClass:[WLKeyboardButton class]]) {
                        WLKeyboardButton *subBtn = (WLKeyboardButton *)subView;
                        if (subBtn.KeyboardButtonType == WLKeyboardButtonTypeComplete && self.keyboardType == WLCustomKeyboardTypeNumber) {
                            subBtn.userInteractionEnabled = NO;
                            [subBtn setTitleColor:kWLKeyboardBtnNoClickTitleColor forState:UIControlStateNormal];
                        }
                    }
                }
            }
            [self action];
        }
            break;
            
        case WLKeyboardButtonTypeComplete:{
            //执行return操作
            if ([WLStringText sharedInstance].inputString.length == 0) {
                return;
            }
            [[WLStringText sharedInstance] completeClick];
//            [textView resignFirstResponder];
            [self action];
        }
            break;

        case WLKeyboardButtonTypeBack: {//返回
            if (self.changeASCIIBlock) {
//                UITextField *textField = (UITextField *)textView;
                NSString * textInputStr = [WLStringText sharedInstance].inputString;
                self.changeASCIIBlock(textInputStr);
            }
            [self action];
        }
            break;
        case WLKeyboardButtonTypeSpace:{//数字键盘空格键
            if ([WLStringText sharedInstance].inputString.length >= 26) {
                return;
            }
            for (UIView *subView in self.subviews) {
                if ([subView isKindOfClass:[WLKeyboardButton class]]) {
                    WLKeyboardButton *subBtn = (WLKeyboardButton *)subView;
                    if (subBtn.KeyboardButtonType == WLKeyboardButtonTypeComplete && self.keyboardType == WLCustomKeyboardTypeNumber) {
                         subBtn.userInteractionEnabled = YES;
                        [subBtn setTitleColor:kWLKeyboardBtnDarkTitleColor forState:UIControlStateNormal];
                    }
                }
            }
           
            [self inputNumber:@" " replaceAll:NO];
            
            [self action];
        }
            break;
        default:
            break;
    }
    
    
}


-(void)action{
    NSLog(@"%@",self.numberKeyboardAction);
    if (self.numberKeyboardAction) {
        self.numberKeyboardAction();
    }

}

/**
 输入文字
 @param text text
 */
- (void)inputNumber:(NSString *)text replaceAll:(BOOL)replace
{
//    [UIResponder inputText:text replaceAll:replace];
    [[WLStringText sharedInstance] textInputChange:text replaceAll:replace];
}

- (void)setKeyboardType:(WLCustomKeyboardType)keyboardType
{
    _keyboardType = keyboardType;
    [self createKeyBoard];
    //默认的数字键盘不展示切换字母键盘按钮
    self.needChangeASCIIKeyBoard = NO;
}

- (void)setNeedChangeASCIIKeyBoard:(BOOL)needChangeASCIIKeyBoard
{
    _needChangeASCIIKeyBoard = needChangeASCIIKeyBoard;
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[WLKeyboardButton class]]) {
            WLKeyboardButton *subBtn = (WLKeyboardButton *)subView;
            if (subBtn.KeyboardButtonType == WLKeyboardButtonTypeBack && self.keyboardType == WLCustomKeyboardTypeNumber) {
                subBtn.hidden = !needChangeASCIIKeyBoard;
            }
        }
    }
}

@end
