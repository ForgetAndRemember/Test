//
//  WLKeyboardButton.m
//  WLCustomKeyboard
//
//  Created by 蔡元伟 on 2020/2/16.
//  Copyright © 2020 蔡元伟. All rights reserved.
//

#import "WLKeyboardButton.h"
#import "WLImage.h"
#import "WLSourcePathHandle.h"

@interface WLKeyboardButton()

@end

@implementation WLKeyboardButton



- (void)setKeyboardButtonType:(WLKeyboardButtonType)KeyboardButtonType
{
    _KeyboardButtonType = KeyboardButtonType;

    switch (KeyboardButtonType) {
        case WLKeyboardButtonTypeNumber:{
            //数字
            
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:NO];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            self.titleLabel.font = kWLKeyboard30Font;
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg_n"] forState:UIControlStateHighlighted];
            
        }
            break;
        case WLKeyboardButtonTypeLetter:{
            //字母
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:NO];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg_n"] forState:UIControlStateHighlighted];
            
            if ([WLScaleManager sharedInstance].carType==1) {
                self.titleLabel.font = kWLKeyboard24Font;
            }
            
            UIImage * image= [UIImage imageNamed:@"Image.bundle/zimu_bg"];
            
            
            
            NSLog(@"budle 图片  %@",image);
//            self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
//            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        case WLKeyboardButtonTypeHyphen:{
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:NO];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            self.titleLabel.font = kWLKeyboard30Font;
            [self setTitle:@"-" forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg_n"] forState:UIControlStateHighlighted];
        }
            break;
        case WLKeyboardButtonTypeSlash:{
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:NO];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setTitle:@"/" forState:UIControlStateNormal];
            self.titleLabel.font = kWLKeyboard30Font;
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg_n"] forState:UIControlStateHighlighted];
        }
            break;
        case WLKeyboardButtonTypeColon:{
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:NO];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setTitle:@":" forState:UIControlStateNormal];
            self.titleLabel.font = kWLKeyboard30Font;
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg_n"] forState:UIControlStateHighlighted];
        }
            break;
        case WLKeyboardButtonTypeSemicolon:{
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:NO];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setTitle:@";" forState:UIControlStateNormal];
            self.titleLabel.font = kWLKeyboard30Font;
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg_n"] forState:UIControlStateHighlighted];
        }
            break;
        case WLKeyboardButtonTypeOpeningParenthesis:{
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:NO];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setTitle:@"(" forState:UIControlStateNormal];
            self.titleLabel.font = kWLKeyboard30Font;
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg_n"] forState:UIControlStateHighlighted];
        }
            break;
        case WLKeyboardButtonTypeClosingParenthesis:{
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:NO];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setTitle:@")" forState:UIControlStateNormal];
            self.titleLabel.font = kWLKeyboard30Font;
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg_n"] forState:UIControlStateHighlighted];
        }
            break;
        case WLKeyboardButtonTypeOther1:{
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:NO];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setTitle:@"¥" forState:UIControlStateNormal];
            self.titleLabel.font = kWLKeyboard30Font;
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg_n"] forState:UIControlStateHighlighted];
        }
            break;
        case WLKeyboardButtonTypeAt:{
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:NO];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setTitle:@"@" forState:UIControlStateNormal];
            self.titleLabel.font = kWLKeyboard30Font;
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg_n"] forState:UIControlStateHighlighted];
        }
            break;
        case WLKeyboardButtonTypeQuotationMark1:{
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:NO];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setTitle:@"“" forState:UIControlStateNormal];
            self.titleLabel.font = kWLKeyboard30Font;
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg_n"] forState:UIControlStateHighlighted];
        }
            break;
        case WLKeyboardButtonTypeQuotationMark2:{
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:NO];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setTitle:@"”" forState:UIControlStateNormal];
            self.titleLabel.font = kWLKeyboard30Font;
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/zimu_bg_n"] forState:UIControlStateHighlighted];
        }
            break;
        case WLKeyboardButtonTypeHash:{
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:NO];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setTitle:@"#" forState:UIControlStateNormal];
            self.titleLabel.font = kWLKeyboard30Font;
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/shuzi_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/shuzi_bg_n"] forState:UIControlStateHighlighted];
        }
            break;
        case WLKeyboardButtonTypePeriod:{
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:NO];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setTitle:@"。" forState:UIControlStateNormal];
            self.titleLabel.font = kWLKeyboard30Font;
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/shuzi_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/shuzi_bg_n"] forState:UIControlStateHighlighted];
        }
            break;
        case WLKeyboardButtonTypeComma:{
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:NO];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setTitle:@"," forState:UIControlStateNormal];
            self.titleLabel.font = kWLKeyboard30Font;
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/shuzi_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/shuzi_bg_n"] forState:UIControlStateHighlighted];
        }
            break;
        case WLKeyboardButtonTypeCaesura:{
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:NO];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setTitle:@"、" forState:UIControlStateNormal];
            self.titleLabel.font = kWLKeyboard30Font;
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/shuzi_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/shuzi_bg_n"] forState:UIControlStateHighlighted];
        }
            break;
        case WLKeyboardButtonTypeQuestion:{
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:NO];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setTitle:@"?" forState:UIControlStateNormal];
            self.titleLabel.font = kWLKeyboard30Font;
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/shuzi_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/shuzi_bg_n"] forState:UIControlStateHighlighted];
        }
            break;
        case WLKeyboardButtonTypeBang:{
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:NO];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setTitle:@"!" forState:UIControlStateNormal];
            self.titleLabel.font = kWLKeyboard30Font;
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/shuzi_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/shuzi_bg_n"] forState:UIControlStateHighlighted];
        }
            break;
        case WLKeyboardButtonTypeDecimal:{
            
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:NO];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setTitle:@"." forState:UIControlStateNormal];
            self.titleLabel.font = kWLKeyboard30Font;
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/shuzi_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/shuzi_bg_n"] forState:UIControlStateHighlighted];
        }
            break;
        case WLKeyboardButtonTypeDelete:{
            [self setImage:[UIImage imageNamed:@"Image.bundle/delete"] forState:UIControlStateNormal];
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:YES];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/daxie_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/daxie_bg_n"] forState:UIControlStateHighlighted];
        }
            break;
            
        case WLKeyboardButtonTypeBack:{
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:YES];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setTitle:@"返回" forState:UIControlStateNormal];
            self.tag = kKLBackTag;
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/shuzi_fanhui"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/shuzi_fanhui_n"] forState:UIControlStateHighlighted];
        }
            break;
        case WLKeyboardButtonTypeSpace:{
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:YES];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setTitle:@"空格" forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/kouge_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/kouge_bg_n"] forState:UIControlStateHighlighted];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/kouge_bg"] forState:UIControlStateHighlighted | UIControlStateSelected];
        }
            break;
        case WLKeyboardButtonTypeComplete:{
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:YES];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setTitle:@"完成" forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/wancheng_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/wancheng_bg_n"] forState:UIControlStateHighlighted];
        }
            break;
        case WLKeyboardButtonTypeToNumber:{
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:YES];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setTitle:@"123" forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/qiehuan_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/qiehuan_bg_n"] forState:UIControlStateHighlighted];
        }
            break;
        case WLKeyboardButtonTypeABC:{
            //ascii键盘中英文切换
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:YES];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            
            NSMutableAttributedString * zhongStr = [self creatString:@"中" font:[UIFont boldSystemFontOfSize:19] color:kWLKeyboardBtnDarkTitleColor];
            NSMutableAttributedString * zhongStrSel = [self creatString:@"中" font:[UIFont systemFontOfSize:13] color:kWLKeyboardBtnDarkTitleColor];
            NSMutableAttributedString * line = [self creatString:@"/" font:[UIFont systemFontOfSize:13] color:kWLKeyboardBtnDarkTitleColor];
            
            NSMutableAttributedString * yingStr = [self creatString:@"英" font:[UIFont systemFontOfSize:13] color:kWLKeyboardBtnDarkTitleColor];
            NSMutableAttributedString * yingStrSel = [self creatString:@"英" font:[UIFont boldSystemFontOfSize:19] color:kWLKeyboardBtnDarkTitleColor];
            [zhongStr appendAttributedString:line];
            [zhongStr appendAttributedString:yingStr];
            [zhongStrSel appendAttributedString:line];
            [zhongStrSel appendAttributedString:yingStrSel];
            [self setAttributedTitle:zhongStr forState:UIControlStateNormal];
            [self setAttributedTitle:zhongStrSel forState:UIControlStateSelected];
//            [self setBackgroundImage:[WLImage imageWithColor:kWLKeyboardBtnDefaultColor] forState:UIControlStateSelected];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/qiehuan_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/qiehuan_bg_n"] forState:UIControlStateHighlighted];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/qiehuan_bg"] forState:UIControlStateHighlighted | UIControlStateSelected];
        }
            break;
        case WLKeyboardButtonTypeToggleCase:{
            [self setImage:[UIImage imageNamed:@"Image.bundle/daxie"] forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:@"Image.bundle/daxie_p"] forState:UIControlStateSelected];
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:YES];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/daxie_bg"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/daxie_bg_n"] forState:UIControlStateHighlighted];
            [self setBackgroundImage:[UIImage imageNamed:@"Image.bundle/daxie_bg"] forState:UIControlStateHighlighted | UIControlStateSelected];
        }
            break;
        case WLKeyboardButtonTypePinYin:{
            self.layer.cornerRadius = kWLASCIIKeyboardBtnCornerRadius;
            [self setTitleColor:kWLKeyboardBtnDarkTitleColor forState:UIControlStateNormal];
            self.titleLabel.font = kWLKeyboard24Font;
            self.titleLabel.textAlignment = NSTextAlignmentLeft;
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            self.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 0);
        }
            break;
        case WLKeyboardButtonTypePinYinLeft:{
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:YES];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setImage:[UIImage imageNamed:@"Image.bundle/left_n"] forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:@"Image.bundle/left"] forState:UIControlStateHighlighted];
        }
            break;
        case WLKeyboardButtonTypePinYinRight:{
            [self configKeyboardButtonTypeWithIsFunctionKeyBoard:YES];
            [self configKeyboardButtonTypeWithisNumberKeyBoard:NO];
            [self setImage:[UIImage imageNamed:@"Image.bundle/right_n"] forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:@"Image.bundle/right"] forState:UIControlStateHighlighted];
        }
            break;
            
        default:
            break;
    }
}

- (NSMutableAttributedString *)creatString:(NSString *)str font:(UIFont *)font color:(UIColor *)color{
    
    NSDictionary * yingAtt = @{
    NSFontAttributeName:font,
    NSForegroundColorAttributeName:color
    };
    NSMutableAttributedString * yingStr = [[NSMutableAttributedString alloc] initWithString:str attributes:yingAtt];
    return yingStr;
}

/**
 数字键盘和字母键盘按钮样式
 
 @param isNumberKeyBoard 是否是数字键盘
 */
- (void)configKeyboardButtonTypeWithisNumberKeyBoard:(BOOL)isNumberKeyBoard
{
//    if (isNumberKeyBoard) {
//        self.layer.borderWidth = kWLASCIIKeyboardBtnBorderWith;
//        self.layer.borderColor = [kWLKeyboardBtnLayerColor CGColor];
//    }else{
        self.layer.cornerRadius = kWLASCIIKeyboardBtnCornerRadius;
        self.clipsToBounds = YES;
//    }
}



/**
 功能按钮和可输入按钮样式
 
 @param isFunctionKeyBoard 是否是功能按钮
 */
- (void)configKeyboardButtonTypeWithIsFunctionKeyBoard:(BOOL)isFunctionKeyBoard
{
    if (isFunctionKeyBoard) {
        [self setTitleColor:kWLKeyboardBtnDarkTitleColor forState:UIControlStateNormal];
        self.titleLabel.font = kWLKeyboard30Font;

        
    }else{
        [self setTitleColor:kWLKeyboardBtnDarkTitleColor forState:UIControlStateNormal];
        self.titleLabel.font = kWLKeyboard32Font;

    }
}

@end
