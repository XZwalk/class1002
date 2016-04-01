//
//  AddressCell.m
//  lessonSqlite
//
//  Created by lanouhn on 15-2-3.
//  Copyright (c) 2015年 XZH. All rights reserved.
//

#import "AddressCell.h"
#import "Contact.h"
#import "HXInitializeInfoManager.h"
#import "UIImageView+WebCache.h"

@implementation AddressCell
//重写setter方法，完成控件的赋值操作
- (void)setContact:(Contact *)contact {

    //为自身控件赋值
    
//    NSString *timeStr = [Tools getTimestampStr];
    NSString *urlStr = [NSString stringWithFormat:kRequestImageUrl, contact.con_imageStr];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //480*640   60*80
    // 张祥   图片加载是否需要更新, 需要再增加一个字段来控制, 上面方法整理
    [self.photoView sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"AppIcon40x40.png"] options:SDWebImageRefreshCached];
    
//    self.photoView.image = contact.con_image;
    self.nameLabel.text = contact.con_name;
    self.phoneLabel.text = contact.con_phone;
    
    
    
    //初始化显示这里还需要优化
    if ([HXInitializeInfoManager shareInstance].isShowFaimly) {
        self.isHaveFamilyLabel.text = [NSString stringWithFormat:@"%ld", contact.con_isHaveFamily];
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
