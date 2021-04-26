//
//  WLKeyboardDefine.h
//  WLCustomKeyboard
//
//  Created by 蔡元伟 on 2020/2/13.
//  Copyright © 2020 蔡元伟. All rights reserved.
//

#ifndef WLKeyboardDefine_h
#define WLKeyboardDefine_h

#import "WLColor.h"
#import "WLScaleManager.h"

#define kWLScreenWidth  [WLScaleManager sharedInstance].screenWidth
#define kWLScreenHeight  [WLScaleManager sharedInstance].screenHeight

//#define SafeSpace (kWLScreenWidth/kWLScreenHeight > 2 ? (kWLScreenWidth-kWLScreenHeight*16/9)/2 : 0)

//键盘设置宽度系数
#define kWLScaleWidth kWLScreenWidth/667
//键盘设置高度系数
#define kWLScaleHeight kWLScreenHeight/375
//键盘拼音查询结果宽度
#define kWLPinYinWidth 667*kWLScaleWidth
//键盘拼音查询结果高度
#define kWLPinYinHeight 26*kWLScaleHeight
//键盘高度
#define kWLCustomKeyboardHeight 200*kWLScaleHeight
//键盘宽度
#define kWLCustomKeyboardWidth kWLScreenWidth


//文字宽
#define kWLWordWidth 24*kWLScaleWidth
//文字高
#define kWLWordHeight 24*kWLScaleHeight
//文字间距
#define kWLWordSpaceX 15*kWLScaleWidth
#define kWLWordSideY 5*kWLScaleHeight
//文字左右翻页button尺寸
#define kWLPinYinBtnWidth 12
#define kWLPinYinBtnHeight 12


//数字键盘按键水平边际距离
#define kWLNumberKeyboardBtnSideX 4*kWLScaleWidth
//数字键盘按键水平边际距离2
#define kWLNumberKeyboardBtnSideX2 35*kWLScaleWidth
//数字键盘按键水平间距距离
#define kWLNumberKeyboardBtnSpaceX 7*kWLScaleWidth
//数字键盘按键水平间距距离2
#define kWLNumberKeyboardBtnSpaceX2 7*kWLScaleWidth
//数字键盘按键水平间距距离3
#define kWLNumberKeyboardBtnSpaceX3 71*kWLScaleWidth
//数字键盘按键垂直上边际距离
#define kWLNumberKeyboardBtnSideY 8*kWLScaleHeight
//数字键盘按键垂直间距距离
#define kWLNumberKeyboardBtnSpaceY 8*kWLScaleHeight
//字母键盘按键水平边际距离
#define kWLASCIIKeyboardBtnSideX 4*kWLScaleWidth
//字母键盘按键水平边际距离2
#define kWLASCIIKeyboardBtnSideX2 35*kWLScaleWidth
//字母键盘按键水平边际距离3
#define kWLASCIIKeyboardBtnSideX3 35*kWLScaleWidth
//字母键盘按键水平间距距离
#define kWLASCIIKeyboardBtnSpaceX 7*kWLScaleWidth
//字母键盘按键水平间距距离2
#define kWLASCIIKeyboardBtnSpaceX2 33*kWLScaleWidth
//字母键盘按键水平间距距离3
#define kWLASCIIKeyboardBtnSpaceX3 20*kWLScaleWidth
//字母键盘按键水平间距距离4
#define kWLASCIIKeyboardBtnSpaceX4 44*kWLScaleWidth
//字母键盘按键垂直上边际距离
#define kWLASCIIKeyboardBtnSideY 8*kWLScaleHeight
//字母键盘按键垂直间距距离
#define kWLASCIIKeyboardBtnSpaceY 8*kWLScaleHeight
//大小写按钮tag
#define kKLGooleTag  25

//中英文按钮tag
#define kKLABCTag   32

//完成按钮tag
#define kKLCompleteTag   26

//返回按钮tag
#define kKLBackTag   27



//字母键盘按钮圆角
#define kWLASCIIKeyboardBtnCornerRadius 5
//数字键盘边框宽度
#define kWLASCIIKeyboardBtnBorderWith 1.5
//键盘背景色
#define kWLKeyboardViewBackgroundColor [WLColor colorWithHex:@"d1d4d9"]
//键盘字体
#define kWLKeyboardBtnDarkTitleColor [WLColor colorWithHex:@"000000"]
//不可点字体
#define kWLKeyboardBtnNoClickTitleColor [WLColor colorWithHex:@"82878f"]
//空格字体
#define kWLKeyboardBtnKongColor [WLColor colorWithHex:@"010101"]
//功能键背景颜色
#define kWLKeyboardBtnDefaultColor [WLColor colorWithHex:@"aab1bb"]
//键盘按钮选中状态颜色
#define kWLKeyboardBtnHighhlightColor [WLColor colorWithHex:@"c6c9ce"]
//白色背景按钮颜色
#define kWLKeyboardBtnWhiteColor [WLColor whiteColor]



//数字键盘边框颜色
#define kWLKeyboardBtnLayerColor [WLColor colorWithHex:@"dadada"]
////键盘按钮高亮状态颜色
//#define kWLKeyboardBtnHighhlightColor [WLColor colorWithHex:@"d2d2d2"]
//
////白色背景按钮颜色
//#define kWLKeyboardBtnWhiteColor [WLColor whiteColor]

//浅色字体
#define kWLKeyboardBtnLightTitleColor [WLColor colorWithHex:@"000000"]

//字体30px
#define kWLKeyboard30Font [UIFont systemFontOfSize:19]
//字体32px
#define kWLKeyboard32Font [UIFont systemFontOfSize:22]
//字体25px
#define kWLKeyboard24Font [UIFont systemFontOfSize:18]


/**
 按钮类型
 
 - WLKeyboardButtonTypeNone: 空白
 - WLKeyboardButtonTypeNumber: 数字
 - WLKeyboardButtonTypeLetter: 字母
 - WLKeyboardButtonTypeDelete: 删除按钮
 - WLKeyboardButtonTypeABC: 切换英文键盘
 - WLKeyboardButtonTypeComplete: 完成
 - WLKeyboardButtonTypeToggleCase: 大小写切换
 - WLKeyboardButtonTypeToNumber: 切换数字键盘按钮
 - WLKeyboardButtonTypeHyphen:  -
 - WLKeyboardButtonTypeSlash:   /
 - WLKeyboardButtonTypeColon:   :
 - WLKeyboardButtonTypeSemicolon:   ;
 - WLKeyboardButtonTypeOpeningParenthesis:  (
 - WLKeyboardButtonTypeClosingParenthesis:  )
 - WLKeyboardButtonTypeOther1:  ¥
 - WLKeyboardButtonTypeAt:  @
 - WLKeyboardButtonTypeQuotationMark1:  “
 - WLKeyboardButtonTypeQuotationMark2:  ”
 - WLKeyboardButtonTypeHash:    #
 - WLKeyboardButtonTypePeriod:  句号
 - WLKeyboardButtonTypeComma:   ,
 - WLKeyboardButtonTypeCaesura:     顿号
 - WLKeyboardButtonTypeQuestion:    ?
 - WLKeyboardButtonTypeBang:    !
 - WLKeyboardButtonTypeDecimal: 数字键盘小数点.
 - WLKeyboardButtonTypeBack:    返回
 - WLKeyboardButtonTypeSpace:     键盘空格键
 */
typedef NS_ENUM(NSInteger,WLKeyboardButtonType) {
    WLKeyboardButtonTypeNone = 10000,
    WLKeyboardButtonTypePinYin,
    WLKeyboardButtonTypePinYinLeft,
    WLKeyboardButtonTypePinYinRight,
    WLKeyboardButtonTypeNumber,
    WLKeyboardButtonTypeLetter,
    WLKeyboardButtonTypeDelete,
    WLKeyboardButtonTypeABC,
    WLKeyboardButtonTypeComplete,
    WLKeyboardButtonTypeToggleCase,
    WLKeyboardButtonTypeToNumber,
    WLKeyboardButtonTypeHyphen,
    WLKeyboardButtonTypeSlash,
    WLKeyboardButtonTypeColon,
    WLKeyboardButtonTypeSemicolon,
    WLKeyboardButtonTypeOpeningParenthesis,
    WLKeyboardButtonTypeClosingParenthesis,
    WLKeyboardButtonTypeOther1,
    WLKeyboardButtonTypeAt,
    WLKeyboardButtonTypeQuotationMark1,
    WLKeyboardButtonTypeQuotationMark2,
    WLKeyboardButtonTypeHash,
    WLKeyboardButtonTypePeriod,
    WLKeyboardButtonTypeComma,
    WLKeyboardButtonTypeCaesura,
    WLKeyboardButtonTypeQuestion,
    WLKeyboardButtonTypeBang,
    WLKeyboardButtonTypeDecimal,
    WLKeyboardButtonTypeBack,
    WLKeyboardButtonTypeSpace
};



#endif /* WLKeyboardDefine_h */
