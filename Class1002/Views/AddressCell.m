//
//  AddressCell.m
//  lessonSqlite
//
//  Created by lanouhn on 15-2-3.
//  Copyright (c) 2015年 XZH. All rights reserved.
//

#import "AddressCell.h"
#import "Contact.h"
@implementation AddressCell
//重写setter方法，完成控件的赋值操作
- (void)setContact:(Contact *)contact {

    //为自身控件赋值
//    self.photoView.image = contact.con_image;
    self.nameLabel.text = contact.con_name;
    self.phoneLabel.text = contact.con_phone;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
