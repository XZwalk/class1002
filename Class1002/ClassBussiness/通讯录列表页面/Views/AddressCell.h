//
//  AddressCell.h
//  lessonSqlite
//
//  Created by lanouhn on 15-2-3.
//  Copyright (c) 2015年 XZH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact;
@interface AddressCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *photoView;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UILabel *phoneLabel;
@property (nonatomic, retain) Contact *contact;//存储传入的Contact对象

@property (strong, nonatomic) IBOutlet UILabel *isHaveFamilyLabel
;


@end
