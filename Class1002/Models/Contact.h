//
//  Contact.h
//  lessonSqlite
//
//  Created by lanouhn on 15-2-3.
//  Copyright (c) 2015年 XZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Contact : NSObject

@property (nonatomic, assign) NSInteger con_id;//存储唯一标识
@property (nonatomic, copy) NSString *con_section;
@property (nonatomic, copy) NSString *con_name;
@property (nonatomic, copy) NSString *con_phone;
@property (nonatomic, copy) NSString *con_nowPlace;
@property (nonatomic, copy) NSString *con_imageStr;

//提供自定义的初始化方法
- (instancetype)initWithConID:(NSInteger)conID conName:(NSString *)conName conSection:(NSString *)conSection conPhone:(NSString *)conPhone conNowPlace:(NSString *)conNowPlace conImage:(NSString *)conImage;
//便利构造器
+ (instancetype)contactWithConID:(NSInteger)conID conName:(NSString *)conName conSection:(NSString *)conSection conPhone:(NSString *)conPhone conNowPlace:(NSString *)conNowPlace conImage:(NSString *)conImage;



@end
