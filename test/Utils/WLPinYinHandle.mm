//
//  WLPinYinHandle.m
//  WLCustomKeyboard
//
//  Created by 蔡元伟 on 2020/3/6.
//  Copyright © 2020 蔡元伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLPinYinHandle.h"
#import "WLPinYin.h"
#import "WLCustomKeyboardSetting.h"
#import "WLSourcePathHandle.h"

@interface WLPinYinHandle() {
    NSString * s_sys;
    NSString * s_usr;
    NSMutableArray * pinyinArray;
    NSMutableArray * curResult;
    int nextIndex;
}
@end

@implementation WLPinYinHandle

- (id)init {
    self = [super init];
    s_sys = nil;
    s_usr = nil;
    pinyinArray = nil;
    curResult = nil;
    nextIndex = 0;
    return self;
}

- (bool) pinyinSearch:(const char*)str{
    setlocale(LC_CTYPE,"chs");
    if(pinyinArray){
        [pinyinArray removeAllObjects];
        pinyinArray = nil;
        nextIndex = 0;
    }
    pinyinArray = [NSMutableArray array];

    if(s_sys == nil && s_usr == nil){
        NSString * path = [[NSBundle mainBundle] pathForResource:@"PinyinDict" ofType:@"bundle"];
        s_sys = [[NSBundle bundleWithPath:path] pathForResource:@"dict_pinyin32.dat" ofType:@"png"];
        s_usr = [[NSBundle bundleWithPath:path] pathForResource:@"user_pinyin.dat" ofType:@"png"];
    }
    
    const char * c_sys = [s_sys cStringUsingEncoding:NSASCIIStringEncoding];
    const char * c_usr = [s_usr cStringUsingEncoding:NSASCIIStringEncoding];
    
    std::list<wchar_t*> rr = pinyinSearch(c_sys, c_usr, str);
    std::list<wchar_t*>::iterator i;
    for (i = rr.begin(); i != rr.end(); ++i){
        NSString * word = [[NSString alloc] initWithBytes:*i length:wcslen(*i)*sizeof(**i) encoding:NSUTF32LittleEndianStringEncoding];
        [pinyinArray addObject:word];
    }
    //释放list
    for (i = rr.begin(); i != rr.end(); ++i){
        if(*i)
            delete *i;
    }
    
    if(pinyinArray.count > 0)
        return true;
    
    return false;
}

- (NSMutableArray *) getSearchNextResult:(bool)next areaWidth:(CGFloat)width{
    if(pinyinArray != nil && pinyinArray.count > 0){
        
        if(!next && curResult){
            if((nextIndex - curResult.count) == 0)
                return curResult;
            nextIndex -= curResult.count;
        }
        
        if(curResult){
            [curResult removeAllObjects];
            curResult = nil;
        }
        curResult = [NSMutableArray array];
        
        int loop = nextIndex;
        CGFloat remainingLen = width;
        if (next) {
            //向后返回结果
            while(remainingLen > 0 && loop < pinyinArray.count){
                NSString * word = (NSString *)pinyinArray[loop];
                long wordLen = kWLWordWidth * word.length;//确定当前字符总宽度
                if(remainingLen > wordLen){
                    [curResult addObject:word];
                    nextIndex += 1;
                    loop = nextIndex;
                    remainingLen = remainingLen - wordLen - kWLWordSpaceX;
                }
                else{
                    break;
                }
            }
        }
        else{
            //向前返回结果
            while(remainingLen > 0 && (loop - 1) >= 0){
                NSString * word = (NSString *)pinyinArray[loop - 1];
                long wordLen = kWLWordWidth * word.length;//确定当前字符总宽度
                if(remainingLen > wordLen){
                    [curResult addObject:word];
                }
                nextIndex = loop;
                loop -= 1;
                remainingLen = remainingLen - wordLen - kWLWordSpaceX;
            }
            NSArray *reverseArray = [[curResult reverseObjectEnumerator] allObjects];
            if(curResult){
                [curResult removeAllObjects];
                curResult = nil;
            }
            curResult = [NSMutableArray array];
            curResult = [reverseArray mutableCopy];
            nextIndex += curResult.count - 1;
        }
        
        if (curResult.count > 0) {
            return curResult;
        }
    }
    return nil;
}

- (void) clean{
    [pinyinArray removeAllObjects];
}

- (int) getNextIndex{
    return nextIndex;
}

- (BOOL)canMoveLeft{
    if(curResult != nil && nextIndex > curResult.count){
        return NO;
    }
    return YES;
}

- (BOOL)canMoveRight{
    if(pinyinArray != nil && nextIndex < pinyinArray.count){
        return NO;
    }
    return YES;
}

@end
