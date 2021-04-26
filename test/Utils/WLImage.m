//
//  WLImage.m
//  WLSelfKeyboard
//
//  Created by 蔡元伟 on 2020/2/14.
//  Copyright © 2020 蔡元伟. All rights reserved
//

#import "WLImage.h"

@implementation WLImage : UIImage

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
