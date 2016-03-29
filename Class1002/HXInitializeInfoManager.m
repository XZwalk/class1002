//
//  HXInitializeInfoManager.m
//  Class1002
//
//  Created by 张祥 on 16/3/27.
//  Copyright © 2016年 张祥. All rights reserved.
//

#import "HXInitializeInfoManager.h"

@implementation HXInitializeInfoManager


+ (HXInitializeInfoManager *)shareInstance
{
    static HXInitializeInfoManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[HXInitializeInfoManager alloc] init];
    });
    return shareInstance;
}


- (void)requestInitializeInfo {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *timeStr = [Tools getTimestampStr];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kRequestInitializeInfoUrl, timeStr]];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSString *isShowFaimly = result[@"isShowFamily"];
                
                if ([isShowFaimly length] > 0) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        _isShowFaimly = [isShowFaimly boolValue];
                        [[NSNotificationCenter defaultCenter] postNotificationName:kInitializeInfoFinishNSNotification object:nil];
                        
                    });
                }
            }
        }
    }];
    
    [task resume];
    
}

@end
