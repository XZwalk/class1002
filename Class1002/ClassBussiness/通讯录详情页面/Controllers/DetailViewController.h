//
//  DetailViewController.h
//  lessonSqlite
//
//  Created by lanouhn on 15-2-3.
//  Copyright (c) 2015年 XZH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact;
@interface DetailViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *name;
@property (retain, nonatomic) IBOutlet UITextField *phone;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UITextField *nowPlace;


@property (retain, nonatomic) Contact *contact;//存储前一个界面传来的contact对象


@end
