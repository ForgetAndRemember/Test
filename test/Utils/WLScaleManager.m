//
//  WLScaleManager.m
//  WLCustomKeyboard
//
//  Created by peiyu on 2020/6/29.
//  Copyright © 2020 蔡元伟. All rights reserved.
//

#import "WLScaleManager.h"

@implementation WLScaleManager

+ (WLScaleManager *)sharedInstance
{
    static WLScaleManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WLScaleManager alloc] init];
    
    });
    return sharedInstance;
}

-(instancetype)init{
    if (self=[super init]) {
        _carType=0;
    }
    return self;
}

@end
