//
//  Contact.m
//  lessonSqlite
//
//  Created by lanouhn on 15-2-3.
//  Copyright (c) 2015年 XZH. All rights reserved.
//

#import "Contact.h"

@implementation Contact
//提供自定义的初始化方法
- (instancetype)initWithConID:(NSInteger)conID conName:(NSString *)conName conSection:(NSString *)conSection conPhone:(NSString *)conPhone conNowPlace:(NSString *)conNowPlace conImage:(NSString *)conImage conHaveFam:(NSInteger)conHaveFam {
    self = [super init];
    if (self) {
        self.con_id = conID;
        self.con_name = conName;
        self.con_section = conSection;
        self.con_imageStr = conImage;
        self.con_phone = conPhone;
        self.con_nowPlace = conNowPlace;
        self.con_isHaveFamily = conHaveFam;
    }
    return self;
}
//便利构造器
+ (instancetype)contactWithConID:(NSInteger)conID conName:(NSString *)conName conSection:(NSString *)conSection conPhone:(NSString *)conPhone conNowPlace:(NSString *)conNowPlace conImage:(NSString *)conImage conHaveFam:(NSInteger)conHaveFam {
    return [[Contact alloc] initWithConID:conID conName:conName conSection:conSection conPhone:conPhone conNowPlace:conNowPlace conImage:conImage conHaveFam:conHaveFam];
}



@end
