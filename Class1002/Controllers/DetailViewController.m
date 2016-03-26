//
//  DetailViewController.m
//  lessonSqlite
//
//  Created by lanouhn on 15-2-3.
//  Copyright (c) 2015年 XZH. All rights reserved.
//

#import "DetailViewController.h"
#import "Contact.h"
#import "DataBaseHelper.h"
@interface DetailViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //为自身控件赋值
//    self.imageView.image = _contact.con_image;
    self.name.text = _contact.con_name;
    self.phone.text = _contact.con_phone;
    //设置编辑按钮
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //关闭控件交互
    [self dependUserInterationEnabled:NO];
}
//点击Edit按钮触发
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self dependUserInterationEnabled:editing];//控件交互
    if (editing == NO) {
        //当点击Done时，取消编辑状态，保存数据
        //保存修改之前的名字
        //当contact对象重新修改con_name,setter方法内部会对原有的对象release，原有对象空间回收，为了防止以后出现野指针问题。
        NSString *sourceName = self.contact.con_name;
        //修改内存数据
        self.contact.con_name = self.name.text;
//        self.contact.con_gendar = self.gendar.text;
//        self.contact.con_age = self.age.text;
//        self.contact.con_motto = self.motto.text;
//        self.contact.con_image = self.imageView.image;
        self.contact.con_phone = self.phone.text;
        
        [DataBaseHelper updateContact:self.contact withSourceName:sourceName];
        //更新数据库
        //[DataBaseHelper updateDataBaseWithContact:self.contact];
    }
}
//控制控件是否可交互
- (void)dependUserInterationEnabled:(BOOL)enabled {
    self.imageView.userInteractionEnabled = enabled;
    self.name.userInteractionEnabled = enabled;
    self.phone.userInteractionEnabled = enabled;
}
- (IBAction)handlePicture:(UITapGestureRecognizer *)sender {
    //提供 相册 以及 拍照 两种读取图片的功能.
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"拍照", nil];
    [sheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
//action sheet button clicked
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            //从相册中读取
            [self readImageFromAlbum];
            break;
        case 1:
            //拍照
            [self readImageFromCamera];
            break;
        default:
            break;
    }
}
//从相册中读取
- (void)readImageFromAlbum {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];//创建对象
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//（选择类型）表示仅仅从相册中选取照片
    imagePicker.delegate = self;//指定代理，因此我们要实现UIImagePickerControllerDelegate,  UINavigationControllerDelegate协议
    imagePicker.allowsEditing = YES;//设置在相册选完照片后，是否跳到编辑模式进行图片剪裁。(允许用户编辑)
    [self presentViewController:imagePicker animated:YES completion:nil];//显示相册
}
//拍照
- (void)readImageFromCamera {
    //判断选择的模式是否为相机模式，如果没有弹窗警告
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.allowsEditing = YES; //允许编辑
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        //弹出窗口响应点击事件
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"未检测到摄像头" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];//警告。。确认按钮
        [alert show];
    }
}
#pragma mark -  UIImagePickerControllerDelegate
//图片编辑完成之后触发
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    self.imageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
