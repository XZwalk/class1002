//
//  ContactServer.h
//  Class1002
//
//  Created by 张祥 on 16/3/27.
//  Copyright © 2016年 张祥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactServer : NSObject


- (void)requestContactListData:(RequestSuccess)requestSuccess fail:(RequestFaild)requestFaild;



@end
