//
//  WLASCIIKeyboard.m
//  WLCustomKeyboard
//
//  Created by 蔡元伟 on 2020/2/14.
//  Copyright © 2020 蔡元伟. All rights reserved.
//

#import "WLASCIIKeyboard.h"
#import "WLKeyboardButton.h"
#import "UIResponder+WLKeyboardResponder.h"
#import "WLCustomKeyboardSetting.h"
#import "WLPinYinHandle.h"
#import "WLStringText.h"

#define PINYINTAGSTART 1000

@interface WLASCIIKeyboard(){
    WLPinYinHandle * pinyinHandle;
    NSMutableArray * pinyinButton;
    WLKeyboardButton * pyLeftBtn;
    WLKeyboardButton * pyRightBtn;
    NSString * pySearchStr;             //拼音要搜索字符串
    
    BOOL isPinYinModle;                 //当前键盘模式
    NSTimer *_timer;
    
}

@end

@implementation WLASCIIKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kWLKeyboardViewBackgroundColor;
        [self createKeyBoard];
    }
    pinyinHandle = [[WLPinYinHandle alloc] init];
    _btnAllText = [[NSMutableString alloc] init];
    isPinYinModle = YES;
    
    return self;
}

- (void)setCommpleteBtn:(NSString *)word isUserEnable:(BOOL)userEnable color:(UIColor *)color{
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[WLKeyboardButton class]]) {
            WLKeyboardButton *subBtn = (WLKeyboardButton *)subView;
            if (subBtn.KeyboardButtonType == WLKeyboardButtonTypeComplete) {
                subBtn.userInteractionEnabled = userEnable;
                [subBtn setTitleColor:color forState:UIControlStateNormal];
                [subBtn setTitle:word forState:UIControlStateNormal];
            }
        }
    }
    
}

//创建键盘
- (void)createKeyBoard
{
    NSArray *keyBoards1 = nil;
    NSArray *keyBoards2 = nil;
    NSArray *keyBoards3 = nil;
    NSArray *keyBoards4 = nil;
    
    pinyinButton = [NSMutableArray array];
    for(int i = 0; i < 20; i++){
        WLKeyboardButton *pyBtn = [self createBtn];
        pyBtn.tag = PINYINTAGSTART+i;
//        pyBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        pyBtn.KeyboardButtonType = WLKeyboardButtonTypePinYin;
        pyBtn.hidden = YES;
        [self addSubview:pyBtn];
        [pinyinButton addObject:pyBtn];
    }
    
    pyLeftBtn = [self createBtn];
    pyLeftBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    pyLeftBtn.KeyboardButtonType = WLKeyboardButtonTypePinYinLeft;
    pyLeftBtn.frame = CGRectMake(kWLCustomKeyboardWidth - 2 * (27 *kWLScaleWidth + kWLWordWidth), kWLWordSideY, kWLWordWidth, kWLWordHeight);
    pyLeftBtn.hidden = YES;
    [self addSubview:pyLeftBtn];
    
    pyRightBtn = [self createBtn];
    pyRightBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    pyRightBtn.KeyboardButtonType = WLKeyboardButtonTypePinYinRight;
    pyRightBtn.frame = CGRectMake(kWLCustomKeyboardWidth - 27 *kWLScaleWidth - kWLWordWidth, kWLWordSideY, kWLWordWidth, kWLWordHeight);
    pyRightBtn.hidden = YES;
    [self addSubview:pyRightBtn];
    
    keyBoards1 = @[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p"];
    keyBoards2 = @[@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l"];
    keyBoards3 = @[@(WLKeyboardButtonTypeToggleCase),@"z",@"x",@"c",@"v",@"b",@"n",@"m",@(WLKeyboardButtonTypeDelete)];
    keyBoards4 = @[@(WLKeyboardButtonTypeToNumber), @(WLKeyboardButtonTypeABC), @(WLKeyboardButtonTypeSpace), @(WLKeyboardButtonTypeComplete)];
    
    //第一排键盘
    //计算btn宽
    CGFloat btnWidth = (kWLCustomKeyboardWidth - (kWLASCIIKeyboardBtnSideX * 2) - (kWLASCIIKeyboardBtnSpaceX * (keyBoards1.count - 1))) / keyBoards1.count;
    //计算btn高
    CGFloat btnHeight = (kWLCustomKeyboardHeight - kWLPinYinHeight - kWLASCIIKeyboardBtnSideY - kWLASCIIKeyboardBtnSpaceY * 4) / 4;
    
    //按键垂直起始位置坐标
    CGFloat nextOffsetY = kWLPinYinHeight + kWLASCIIKeyboardBtnSideY;
    
    for (int i = 0; i < keyBoards1.count; i++) {
        WLKeyboardButton *btn = [self createBtn];
        //设置显示title
        [btn setTitle:keyBoards1[i] forState:UIControlStateNormal];
        //设置显示位置
        if(i == 0){
            btn.frame = CGRectMake(kWLASCIIKeyboardBtnSideX, nextOffsetY, btnWidth, btnHeight);
        }
        else{
            btn.frame = CGRectMake(kWLASCIIKeyboardBtnSideX + (i * (btnWidth + kWLASCIIKeyboardBtnSpaceX)), nextOffsetY, btnWidth, btnHeight);
        }
        //设置类型
        btn.KeyboardButtonType = WLKeyboardButtonTypeLetter;
        [self addSubview:btn];
    }
    nextOffsetY = nextOffsetY + btnHeight + kWLASCIIKeyboardBtnSpaceY;
    
    CGFloat btnWidth2 = (kWLCustomKeyboardWidth - kWLASCIIKeyboardBtnSideX2 * 2 - (keyBoards2.count - 1) *kWLASCIIKeyboardBtnSpaceX)/keyBoards2.count;
    //第二排键盘
    for (int i = 0; i < keyBoards2.count; i++) {
        WLKeyboardButton *btn = [self createBtn];
        //设置显示title
        [btn setTitle:keyBoards2[i] forState:UIControlStateNormal];
        //设置显示位置
        if(i == 0){
            btn.frame = CGRectMake(kWLASCIIKeyboardBtnSideX2, nextOffsetY, btnWidth2, btnHeight);
        }
        else{
            btn.frame = CGRectMake(kWLASCIIKeyboardBtnSideX2 + (i * (btnWidth2 + kWLASCIIKeyboardBtnSpaceX)), nextOffsetY, btnWidth2, btnHeight);
        }
        //设置类型
        btn.KeyboardButtonType = WLKeyboardButtonTypeLetter;
        [self addSubview:btn];
    }
    nextOffsetY = nextOffsetY + btnHeight + kWLASCIIKeyboardBtnSpaceY;
    
    //第三排键盘
    //功能键宽度
    CGFloat funbtnWidth = 31 *kWLScaleWidth + btnWidth2;
    
    for (int i = 0; i < keyBoards3.count; i++) {
        WLKeyboardButton *btn = [self createBtn];
        if (i == 0) {
            //第一个功能键
            btn.frame = CGRectMake(kWLASCIIKeyboardBtnSideX, nextOffsetY, funbtnWidth, btnHeight);
            btn.KeyboardButtonType = WLKeyboardButtonTypeToggleCase;
            btn.tag = kKLGooleTag;
        }else if (i == keyBoards3.count - 1){
            //最后一个功能键
            btn.frame = CGRectMake(kWLCustomKeyboardWidth - funbtnWidth - kWLASCIIKeyboardBtnSideX , nextOffsetY, funbtnWidth, btnHeight);
            btn.KeyboardButtonType = WLKeyboardButtonTypeDelete;
            UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(reduceText:)];

            [btn addGestureRecognizer:press];
        }else{
            if (kWLScreenWidth == 812) {
                btn.frame = CGRectMake(((kWLASCIIKeyboardBtnSideX + funbtnWidth + kWLASCIIKeyboardBtnSpaceX) + (i - 1) * (btnWidth2 + kWLASCIIKeyboardBtnSpaceX)), nextOffsetY, btnWidth2, btnHeight);
            }else{
                btn.frame = CGRectMake(((kWLASCIIKeyboardBtnSideX + funbtnWidth + kWLASCIIKeyboardBtnSpaceX) + (i - 1) * (btnWidth2 + kWLASCIIKeyboardBtnSpaceX)), nextOffsetY, btnWidth2, btnHeight);
            }
            
            [btn setTitle:keyBoards3[i] forState:UIControlStateNormal];
            btn.KeyboardButtonType = WLKeyboardButtonTypeLetter;
        }
        [self addSubview:btn];
    }
    nextOffsetY = nextOffsetY + btnHeight + kWLASCIIKeyboardBtnSpaceY;
    
    //第四排键盘
    CGFloat btnSpaceWidth = kWLCustomKeyboardWidth - 70*kWLScaleWidth *2 - kWLASCIIKeyboardBtnSideX *2 - kWLASCIIKeyboardBtnSpaceX * 3 - 130*kWLScaleWidth;
    for (int i = 0; i < keyBoards4.count; i ++) {
        WLKeyboardButton *btn = [self createBtn];
        if (i == 0) {//切换数字键盘
            btn.KeyboardButtonType = WLKeyboardButtonTypeToNumber;
            btn.frame = CGRectMake(kWLASCIIKeyboardBtnSideX, nextOffsetY, 70*kWLScaleWidth, btnHeight);
        }else if (i == 1){//切换中英文
            btn.KeyboardButtonType = WLKeyboardButtonTypeABC;
            btn.frame = CGRectMake(kWLASCIIKeyboardBtnSideX + 70*kWLScaleWidth + kWLASCIIKeyboardBtnSpaceX, nextOffsetY, 70*kWLScaleWidth, btnHeight);
            btn.tag =kKLABCTag;
        }else if (i == 2){//空格键
            btn.KeyboardButtonType = WLKeyboardButtonTypeSpace;
            btn.frame = CGRectMake(kWLASCIIKeyboardBtnSideX + (70*kWLScaleWidth + kWLASCIIKeyboardBtnSpaceX) * 2, nextOffsetY, btnSpaceWidth, btnHeight);
        }else if(i == 3){//完成键
            btn.KeyboardButtonType = WLKeyboardButtonTypeComplete;
            btn.frame = CGRectMake(kWLASCIIKeyboardBtnSideX + (70*kWLScaleWidth + kWLASCIIKeyboardBtnSpaceX) * 2 + btnSpaceWidth + kWLASCIIKeyboardBtnSpaceX, nextOffsetY, 130 * kWLScaleWidth, btnHeight);
            btn.tag = kKLCompleteTag;
            btn.userInteractionEnabled = NO;
            [btn setTitleColor:kWLKeyboardBtnNoClickTitleColor forState:UIControlStateNormal];
            
            
        }
        
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

//长按删除
- (void)longClick{
    
//    UIView <UITextInput> *textView = [UIResponder firstResponderTextView];
//    UITextField *textField = (UITextField *)textView;
    NSString * textInputStr = [WLStringText sharedInstance].inputString;
    [[WLStringText sharedInstance] deleteInputeString];
    if ([WLStringText sharedInstance].inputString.length == 0) {
        [self setCommpleteBtn:@"完成" isUserEnable:NO color:kWLKeyboardBtnNoClickTitleColor];
    }
    if (_btnAllText.length) {
        [_btnAllText deleteCharactersInRange:NSMakeRange(_btnAllText.length-1, 1)];
    }
    
    BOOL needPinYin = NO;
    if (textInputStr != nil && textInputStr.length > 0) {
        textInputStr = [textInputStr substringToIndex:textInputStr.length - 1];//此时inputstr还未实际del所以-1获得删除后str
        if ((_textInputSaveStr != nil && _textInputSaveStr.length > 0 && textInputStr.length > _textInputSaveStr.length) || _textInputSaveStr == nil || _textInputSaveStr.length <= 0) {
            //判断删除后是否需要pinyin查询
            needPinYin = YES;
        }
        
        if (_textInputSaveStr != nil && _textInputSaveStr.length > 0 && textInputStr.length <= _textInputSaveStr.length) {
            //判断删除后是否需要清空pinyin查询结果区域
            _textInputSaveStr = textInputStr;
            [self clearPinYinArea];
        }
    }
    
    [self needPinyin:needPinYin];
}

//创建button
- (WLKeyboardButton *)createBtn
{
    WLKeyboardButton *btn = [WLKeyboardButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)needPinyin:(BOOL)needPinyin{
    
    if(needPinyin){
        //需要拼音查询
        if (_textInputSaveStr != nil && _textInputSaveStr.length > 0) {
            //输入框中存在内容
            //裁剪需要查询内容
            pySearchStr = [[WLStringText sharedInstance].inputString substringFromIndex:_textInputSaveStr.length];
        }
        else{
            //输入框中无内容
            pySearchStr = _btnAllText;
        }
        
        if(pySearchStr != nil && pySearchStr.length > 0 && pySearchStr.length < 25){
            [pinyinHandle pinyinSearch:[pySearchStr UTF8String]];
        }else{
            [pinyinHandle clean];
        }
        
        
        [self refreshPinYinArea:YES];
    }
}

//键盘收回恢复默认中文模式
- (void)endKeyBoard:(WLKeyboardButton *)btn{
    
    WLKeyboardButton *daxie = (WLKeyboardButton *)[self viewWithTag:kKLGooleTag];
    if (daxie.selected) {
        
        [self btnClick:daxie];
    }
    isPinYinModle = !isPinYinModle;
    btn.selected = !btn.selected;
    
}

- (void)btnClick:(WLKeyboardButton *)btn
{
    

    
//    UIView <UITextInput> *textView = [UIResponder firstResponderTextView];
//    if (![textView isKindOfClass:[UITextField class]]) {
//        return;
//    }
//    UITextField *textField = (UITextField *)textView;
   
    NSString * textInputStr = [WLStringText sharedInstance].inputString;
    if (textInputStr == nil || textInputStr.length == 0) {
        pySearchStr = nil;
        _textInputSaveStr = @"";
    }
    WLKeyboardButton *completeBtn = [self viewWithTag:kKLCompleteTag];
    BOOL needPinYin = NO;
    switch (btn.KeyboardButtonType) {
        case WLKeyboardButtonTypeLetter:{
            if ([WLStringText sharedInstance].inputString.length > 25) {
               return;
            }
            //字符
            if (isPinYinModle) {
                
                [self inputText:btn.titleLabel.text replaceAll:NO];
//                [_btnAllText appendString:btn.titleLabel.text];
                if ([WLStringText sharedInstance].inputString.length < 25) {
                   @try {
                       NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[WLStringText sharedInstance].inputString];
                       [_btnAllText appendString:btn.titleLabel.text];
                       [attrStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange([WLStringText sharedInstance].inputString.length - _btnAllText.length, _btnAllText.length)];
                       [attrStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleNone] range:NSMakeRange(0, [WLStringText sharedInstance].inputString.length- _btnAllText.length)];
                       [WLStringText sharedInstance].attributedText = attrStr;
                   } @catch (NSException *exception) {
                       NSLog(@"键盘点击出现异常");
                   } @finally {
                       
                   }
                }
                
                needPinYin = YES;
                
                [self setCommpleteBtn:@"确认" isUserEnable:YES color:kWLKeyboardBtnDarkTitleColor];
                
                
            }
            else{
                
                
                [self inputText:btn.titleLabel.text replaceAll:NO];
                textInputStr = [textInputStr stringByAppendingString:btn.titleLabel.text];
                _textInputSaveStr = textInputStr;
                [self setCommpleteBtn:@"完成" isUserEnable:YES color:kWLKeyboardBtnDarkTitleColor];
            }
            [self action];
            
        }
            break;
            
        case WLKeyboardButtonTypeABC:{
            //中英文切换
            WLKeyboardButton *daxie = (WLKeyboardButton *)[self viewWithTag:kKLGooleTag];
            if (daxie.selected) {
                
                [self btnClick:daxie];
            }
            isPinYinModle = !isPinYinModle;
            btn.selected = !btn.selected;
            if (!isPinYinModle) {
                _textInputSaveStr = textInputStr;
                NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_textInputSaveStr];
                [attrStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleNone] range:NSMakeRange(0, [WLStringText sharedInstance].inputString.length)];
                [WLStringText sharedInstance].attributedText = attrStr;
                [_btnAllText deleteCharactersInRange:NSMakeRange(0, _btnAllText.length)];
                [self clearPinYinArea];
                [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
            }
            [self action];
            
        }
            break;
            
        case WLKeyboardButtonTypeSpace:{
            if ([WLStringText sharedInstance].inputString.length > 25) {
                return;
            }
            //空格字符
            if(!isPinYinModle || textInputStr == nil || textInputStr.length <= 0 || (_textInputSaveStr != nil && _textInputSaveStr.length > 0 && textInputStr.length == _textInputSaveStr.length)){
                //1.不是pinyin模式 输入空格
                [self inputText:@" " replaceAll:NO];
                textInputStr = [textInputStr stringByAppendingString:@" "];
                _textInputSaveStr = textInputStr;
            }
            else{
                //直接默认pinyin查询结果第一个button值
                WLKeyboardButton * selectBtn = pinyinButton[0];
                NSString * selectString = @"";
                if (!selectBtn.hidden) {
                    selectString = [selectBtn currentTitle];
                    if (_textInputSaveStr != nil) {
                        _textInputSaveStr = [_textInputSaveStr stringByAppendingString:selectString];
                    }
                    else{
                        
                        //解决系统切换键盘后的问题
                        if ([WLStringText sharedInstance].inputString != nil) {
                            NSMutableString *str = [[NSMutableString alloc] init];
                            [str appendString:textInputStr];
                            [str deleteCharactersInRange:NSMakeRange(str.length - _btnAllText.length, _btnAllText.length)];
                            _textInputSaveStr = [str stringByAppendingString:selectString];
                        }else{
                            
                            _textInputSaveStr = selectString;
                            
                        }
                    }
                }else{
                    
                    _textInputSaveStr = textInputStr;
                }
                
                
                [self inputText:_textInputSaveStr replaceAll:YES];
                if (_textInputSaveStr) {
                    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_textInputSaveStr];
                    [attrStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleNone] range:NSMakeRange(0, [WLStringText sharedInstance].inputString.length)];
                    [WLStringText sharedInstance].attributedText = attrStr;
                    [_btnAllText deleteCharactersInRange:NSMakeRange(0, _btnAllText.length)];
                }
                
                [self clearPinYinArea];
                
            }
            [self setCommpleteBtn:@"完成" isUserEnable:YES color:kWLKeyboardBtnDarkTitleColor];
            
            [self action];
        }
            break;
            
        case WLKeyboardButtonTypeToNumber:{
            //切换到数字键盘
            WLKeyboardButton *daxie = (WLKeyboardButton *)[self viewWithTag:kKLGooleTag];
            if (daxie.selected) {
                
                [self btnClick:daxie];
            }
            if (self.changeNumberBlock) {
                if(!isPinYinModle || textInputStr == nil || textInputStr.length <= 0 || (_textInputSaveStr != nil && _textInputSaveStr.length > 0 && textInputStr.length == _textInputSaveStr.length)){
                    //1.不是pinyin模式 保存当前输入
                    _textInputSaveStr = textInputStr;
                }
                else{
                    //直接默认pinyin查询结果第一个button值
                    WLKeyboardButton * selectBtn = pinyinButton[0];
                    NSString * selectString = @"";
                    if (!selectBtn.hidden) {
                        selectString = [selectBtn currentTitle];
                        if (_textInputSaveStr != nil) {
                            _textInputSaveStr = [_textInputSaveStr stringByAppendingString:selectString];
                        }
                        else{
                            //解决系统切换键盘后的问题
                            if ([WLStringText sharedInstance].inputString != nil) {
                                NSMutableString *str = [[NSMutableString alloc] init];
                                [str appendString:textInputStr];
                                [str deleteCharactersInRange:NSMakeRange(str.length - _btnAllText.length, _btnAllText.length)];
                                _textInputSaveStr = [str stringByAppendingString:selectString];
                            }else{
                                
                                _textInputSaveStr = selectString;
                                
                            }
                            
                        }
                    }else{
                        
                        _textInputSaveStr = textInputStr;
                    }
                    [self inputText:_textInputSaveStr replaceAll:YES];
                    if (_textInputSaveStr) {
                       NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_textInputSaveStr];
                       [attrStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleNone] range:NSMakeRange(0, [WLStringText sharedInstance].inputString.length)];
                       [WLStringText sharedInstance].attributedText = attrStr;
                       [_btnAllText deleteCharactersInRange:NSMakeRange(0, _btnAllText.length)];
                    }
                   
                    [self clearPinYinArea];
                    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
                }
                
                self.changeNumberBlock();
            }
            [self action];
        }
            break;
            
        case WLKeyboardButtonTypeToggleCase:{
            //大小写转换
            //中文不支持切换大小写
//            WLKeyboardButton *abc = (WLKeyboardButton *)[self viewWithTag:kKLABCTag];
//            if (!abc.selected) {
//
//                return;
//            }
            [self keyBoardToggleCase:btn];
            [self action];
        }
            break;
            
        case WLKeyboardButtonTypeDelete:{
            //删除字符
            [[WLStringText sharedInstance] deleteInputeString];
            if (_btnAllText.length) {
                [_btnAllText deleteCharactersInRange:NSMakeRange(_btnAllText.length-1, 1)];
            }
            if (textInputStr != nil && textInputStr.length > 0) {
                textInputStr = [textInputStr substringToIndex:textInputStr.length - 1];//此时inputstr还未实际del所以-1获得删除后str
                if ((_textInputSaveStr != nil && _textInputSaveStr.length > 0 && textInputStr.length > _textInputSaveStr.length) || _textInputSaveStr == nil || _textInputSaveStr.length <= 0) {
                    //判断删除后是否需要pinyin查询
                    needPinYin = YES;
                }
                
                if (_textInputSaveStr != nil && _textInputSaveStr.length > 0 && textInputStr.length <= _textInputSaveStr.length) {
                    //判断删除后是否需要清空pinyin查询结果区域
                    _textInputSaveStr = textInputStr;
                    [self clearPinYinArea];
                }
            }
            
            if ([WLStringText sharedInstance].inputString.length == 0) {
                [self setCommpleteBtn:@"完成" isUserEnable:NO color:kWLKeyboardBtnNoClickTitleColor];
            }else{
                if (_btnAllText.length) {
                    [self setCommpleteBtn:@"确认" isUserEnable:YES color:kWLKeyboardBtnDarkTitleColor];
                }else{
                    [self setCommpleteBtn:@"完成" isUserEnable:YES color:kWLKeyboardBtnDarkTitleColor];
                }
                
            }
            [self action];
            
        }
            break;
            
        case WLKeyboardButtonTypeComplete:{
            //完成，收起键盘
            if ([WLStringText sharedInstance].inputString.length == 0) {
                return;
            }
            if ([btn.titleLabel.text isEqualToString:@"确认"]) {
                
                [btn setTitle:@"完成" forState:UIControlStateNormal];
                _textInputSaveStr = textInputStr;
                NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_textInputSaveStr];
                [attrStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleNone] range:NSMakeRange(0, [WLStringText sharedInstance].inputString.length)];
                [WLStringText sharedInstance].attributedText = attrStr;
                [_btnAllText deleteCharactersInRange:NSMakeRange(0, _btnAllText.length)];
                [self clearPinYinArea];
                return;
            }
            
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:textInputStr];
            [WLStringText sharedInstance].attributedText = attrStr;
            //执行return操作
            [[WLStringText sharedInstance] completeClick];
            
            [self clearPinYinArea];
//            [textView resignFirstResponder];
            [self action];
            
            //重置键盘参数
        }
            break;
        case WLKeyboardButtonTypePinYinLeft:{
            //拼音搜索往左翻
            [self refreshPinYinArea:NO];
            [self action];
        }
            break;
        case WLKeyboardButtonTypePinYinRight:{
            //拼音搜索往右翻
            [self refreshPinYinArea:YES];
            [self action];
        }
            break;
        case WLKeyboardButtonTypePinYin:{
            //拼音结果
            
            WLKeyboardButton * selectBtn = pinyinButton[btn.tag - PINYINTAGSTART];
            NSString * selectString =  [selectBtn currentTitle];
            if (_textInputSaveStr != nil) {
                _textInputSaveStr = [_textInputSaveStr stringByAppendingString:selectString];
            }
            else{
                if ([WLStringText sharedInstance].inputString != nil) {
                    NSMutableString *str = [[NSMutableString alloc] init];
                    [str appendString:textInputStr];
                    [str deleteCharactersInRange:NSMakeRange(str.length - _btnAllText.length, _btnAllText.length)];
                    _textInputSaveStr = [str stringByAppendingString:selectString];
                }else{
                    
                    _textInputSaveStr = selectString;
                }
                
            }
                        
            [self inputText:_textInputSaveStr replaceAll:YES];
            if (_textInputSaveStr) {
                NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_textInputSaveStr];
                [attrStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleNone] range:NSMakeRange(0, _textInputSaveStr.length)];
                [WLStringText sharedInstance].attributedText = attrStr;
                [_btnAllText deleteCharactersInRange:NSMakeRange(0, _btnAllText.length)];
            }
            [self clearPinYinArea];
            [self setCommpleteBtn:@"完成" isUserEnable:YES color:kWLKeyboardBtnDarkTitleColor];
            [self action];
        }
            break;
        default:
            break;
    }
    
    [self needPinyin:needPinYin];

}

-(void)action{
    NSLog(@"%@",self.aSCIIKeyboardAction);
  
    if (self.aSCIIKeyboardAction) {
        self.aSCIIKeyboardAction();
    }
    

}

//从numberkeyboard切换回来重制已输入内容
- (void) formNumberKeyboard:(NSString *) inputText{
    pySearchStr = nil;
    _textInputSaveStr = inputText;
}

//修改输入框内容
- (void)inputText:(NSString *)text replaceAll:(BOOL)replace
{
//    [UIResponder inputText:text replaceAll:replace];
    
    [[WLStringText sharedInstance] textInputChange:text replaceAll:replace];

}

//清理拼音查询结果区域
- (void)clearPinYinArea {
    pyLeftBtn.hidden = YES;
    pyRightBtn.hidden = YES;
    int loop = 0;
    while (loop < pinyinButton.count) {
        UIButton * btn = pinyinButton[loop];
        btn.hidden = YES;
        loop += 1;
    }
}

//刷新拼音查询结果区域
- (void)refreshPinYinArea:(bool)next{
    CGFloat areaWidth = kWLCustomKeyboardWidth - 2 * (kWLWordSpaceX + kWLWordWidth) - 2 * kWLWordSpaceX;
    NSMutableArray * result = [pinyinHandle getSearchNextResult:next areaWidth:areaWidth];
    int loop = 0;
    if(result != nil && result.count > 0){
        CGFloat totalLen = areaWidth;
        CGFloat remainingLen = kWLWordSpaceX;
        while(loop < result.count){
            NSString * word = (NSString *)result[loop];
            UIButton * btn = pinyinButton[loop];
            
            CGRect labelsize =[word      boundingRectWithSize:CGSizeMake(MAXFLOAT,kWLWordHeight)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kWLKeyboard24Font}context:nil];
            CGFloat wordLen = labelsize.size.width + 5;
//            if (wordLen < remainingLen) {
                
                if (wordLen > 200) {
                    wordLen = 155;
                }
                btn.hidden = NO;
//                btn.backgroundColor = [UIColor redColor];
                btn.frame = CGRectMake(remainingLen, kWLWordSideY, wordLen, kWLWordHeight);
                [btn setTitle:word forState:UIControlStateNormal];
                btn.titleLabel.adjustsFontSizeToFitWidth = NO;
//            }
            
            loop += 1;
            if (remainingLen >= totalLen) {
                break;
            }else{
                remainingLen += (wordLen + kWLWordSpaceX);
            }
            
        }
    }
    
    if(loop == 0){
        //清空pinyin查询结果区域
        [self clearPinYinArea];
    }
    else{
        pyLeftBtn.hidden = [pinyinHandle canMoveLeft];
        pyRightBtn.hidden = [pinyinHandle canMoveRight];
        
        while (loop < pinyinButton.count) {
            UIButton * btn = pinyinButton[loop];
            btn.hidden = YES;
            loop += 1;
        }
    }
}

//切换大小写
- (void)keyBoardToggleCase:(WLKeyboardButton *)btn
{
    btn.selected = !btn.selected;
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[WLKeyboardButton class]]) {
            WLKeyboardButton *subBtn = (WLKeyboardButton *)subview;
            if (subBtn.KeyboardButtonType == WLKeyboardButtonTypeLetter) {
                [subBtn setTitle:btn.isSelected ? [subBtn.titleLabel.text uppercaseString] : [subBtn.titleLabel.text lowercaseString] forState:UIControlStateNormal];
            }
        }
    }
}

-(void)actionWithPoint:(CGPoint)point{
    for (UIView * subview in self.subviews) {
        if ([subview isKindOfClass:[WLKeyboardButton class]]) {
            if (CGRectContainsPoint(subview.frame, point)) {
                WLKeyboardButton * button=(WLKeyboardButton*)subview;
//                NSLog(@"%@被点击 frame(x=%f,y=%f,width=%f,height=%f)",
//                      button.titleLabel.text,
//                      button.frame.origin.x,
//                      button.frame.origin.y,
//                      button.frame.size.width,
//                      button.frame.size.height
//                      );
                if (button.hidden==NO) {
                    [self btnClick:(WLKeyboardButton*)button];
                }
                
                break;
            }
        }
    }
}


@end
