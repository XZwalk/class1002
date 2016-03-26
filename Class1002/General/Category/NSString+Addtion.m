//
//  NSString+Addtion.m
//  AddressBook_Primary
//
//  Created by Frank on 15/1/28.
//  Copyright (c) 2015年 Frank. All rights reserved.
//

#import "NSString+Addtion.h"
#import "ChineseToPinyin.h"
@implementation NSString (Addtion)
//获取拼音首字母
- (NSString *)firstElement {
    //1.将中文转为拼音,并且全部大写,获取首字母
    return [[[ChineseToPinyin pinyinFromChiniseString:self] uppercaseString] substringToIndex:1];
}
@end





