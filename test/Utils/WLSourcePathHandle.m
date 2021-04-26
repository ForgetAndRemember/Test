//
//  WLSourcePathHandle.m
//  WLCustomKeyboard
//
//  Created by wangxu的air on 2020/7/1.
//  Copyright © 2020 蔡元伟. All rights reserved.
//

#import "WLSourcePathHandle.h"

@implementation WLSourcePathHandle
+(NSString *)imagePath:(NSString *)currentPath{
    return [NSString stringWithFormat:@"keyborad_plugin.bundle/%@",currentPath];
}
@end
