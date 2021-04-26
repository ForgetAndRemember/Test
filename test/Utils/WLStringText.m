//
//  WLStringText.m
//  WLCustomKeyboard
//
//  Created by peiyu on 2020/6/24.
//  Copyright © 2020 蔡元伟. All rights reserved.
//

#import "WLStringText.h"

@implementation WLStringText

+ (WLStringText *)sharedInstance
{
    static WLStringText *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WLStringText alloc] init];
    
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.inputString = [[NSMutableString alloc] init];
    }
    return self;
}

- (void)deleteInputeString{
    if ([WLStringText sharedInstance].inputString.length) {
        [[WLStringText sharedInstance].inputString deleteCharactersInRange:NSMakeRange([WLStringText sharedInstance].inputString.length - 1,1)];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"KeyBoardTextChange" object:self userInfo:@{@"text" : [WLStringText sharedInstance].inputString}];
}

- (void)textInputChange:(NSString *)text replaceAll:(BOOL)replace{
    
    if (!replace) {
        [[WLStringText sharedInstance].inputString appendString:text];
    }else{
        [WLStringText sharedInstance].inputString = [[NSMutableString alloc] initWithString:text];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"KeyBoardTextChange" object:[WLStringText sharedInstance] userInfo:@{@"text" : self.inputString}];
    
}

- (void)completeClick{
    
   [[NSNotificationCenter defaultCenter] postNotificationName:@"KeyBoardComplete" object:self userInfo:@{@"text" : [WLStringText sharedInstance].inputString}];
}


@end
