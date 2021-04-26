//
//  WLScaleManager.h
//  WLCustomKeyboard
//
//  Created by peiyu on 2020/6/29.
//  Copyright © 2020 蔡元伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLScaleManager : NSObject
@property (nonatomic,assign) CGFloat screenHeight;
@property (nonatomic,assign) CGFloat screenWidth;
//判断车机端屏幕类型  0为37w  1 为ap32
@property (nonatomic,assign) NSInteger carType;

+ (WLScaleManager *)sharedInstance;
@end

NS_ASSUME_NONNULL_END
