//
//  WLPinYin.h
//  WLPinYin
//
//  Created by 蔡元伟 on 2020/2/9.
//  Copyright © 2020 蔡元伟. All rights reserved.
//

#ifndef WLPinYin_h
#define WLPinYin_h

#include <stdio.h>
#include <list>

std::list<wchar_t*> pinyinSearch(const char *fn_sys_dict, const char *fn_usr_dict, const char *keyword);

#endif /* WelinkPinYin_h */
