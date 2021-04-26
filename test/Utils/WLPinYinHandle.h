//
//  WLPinYinHandle.h
//  WLCustomKeyboard
//
//  Created by 蔡元伟 on 2020/3/6.
//  Copyright © 2020 蔡元伟. All rights reserved.
//

#ifndef WLPinYinHandle_h
#define WLPinYinHandle_h
#import <UIKit/UIKit.h>

@interface WLPinYinHandle : NSObject
- (bool)pinyinSearch:(const char*)str;
- (NSMutableArray *)getSearchNextResult:(bool)next areaWidth:(CGFloat)width;
- (void)clean;
- (int)getNextIndex;
- (BOOL)canMoveLeft;
- (BOOL)canMoveRight;
@end

#endif /* WLPinYinHandle_h */
