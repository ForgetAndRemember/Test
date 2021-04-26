//
//  WLCustomKeyboardDefine.h
//  WLCustomKeyboard
//
//  Created by 蔡元伟 on 2020/2/24.
//  Copyright © 2020 蔡元伟. All rights reserved.
//

#ifndef WLCustomKeyboardDefine_h
#define WLCustomKeyboardDefine_h

/**
 自定义键盘类型
 
 - WLCustomKeyboardTypeASCII: 字母-ASCII键盘，类似系统键盘
 - WLCustomKeyboardTypeNumber: 数字键盘，不随机
 */
typedef NS_ENUM(NSInteger,WLCustomKeyboardType) {
    WLCustomKeyboardTypeASCII,
    WLCustomKeyboardTypeNumber,
};

#endif /* WLCustomKeyboardDefine_h */
