//
//  WLStringText.h
//  WLCustomKeyboard
//
//  Created by peiyu on 2020/6/24.
//  Copyright © 2020 蔡元伟. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLStringText : NSObject

@property (nonatomic,strong)NSMutableString *inputString;

@property (nonatomic,copy)NSMutableAttributedString *attributedText;
+ (WLStringText *)sharedInstance;
- (void)deleteInputeString;
- (void)textInputChange:(NSString *)text replaceAll:(BOOL)replace;
- (void)completeClick;

@end

NS_ASSUME_NONNULL_END
