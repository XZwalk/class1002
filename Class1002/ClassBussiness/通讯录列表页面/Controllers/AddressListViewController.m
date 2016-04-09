//
//  AddressListViewController.m
//  Class1002
//
//  Created by 张祥 on 16/3/26.
//  Copyright © 2016年 张祥. All rights reserved.
//

#import "AddressListViewController.h"
#import "AddressCell.h"
#import "DataBaseHelper.h"
#import "DetailViewController.h"
#import "ContactServer.h"
#import "ProgressHUD.h"
#import <QiniuSDK.h>
#import "QiniuPutPolicy.h"



@interface AddressListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) ContactServer *contactSever;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDataFinishNSNotification) name:kDataFinishNSNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInitializeInfoNSNotification) name:kInitializeInfoFinishNSNotification object:nil];
    
    _contactSever = [[ContactServer alloc] init];
    
    if ([self isNeedRequestDataFromServer]) {
        [self requestContactData];
    } else {
        [DataBaseHelper readDataFromDataBase];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDataFinishNSNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kInitializeInfoFinishNSNotification object:nil];

}

#pragma mark - private api

- (BOOL)isNeedRequestDataFromServer {
    
    NSString * fullPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    fullPath = [fullPath stringByAppendingPathComponent:kDataBaseName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:fullPath]) {
        return NO;
    }
    
    return YES;
}


- (void)requestContactData {
    
    [ProgressHUD show:@"正在请求"];

    [_contactSever requestContactListData:^(id resultObject) {
        [DataBaseHelper readDataFromDataBase];
        [ProgressHUD dismiss];
        
    } fail:^(id resultObject) {
        
        
    }];
}

- (NSString *)tokenWithScope:(NSString *)scope
{
    QiniuPutPolicy *policy = [QiniuPutPolicy new];
    policy.scope = scope;
    return [policy makeToken:QiniuAccessKey secretKey:QiniuSecretKey];
    
}



#pragma mark - eventRespond

- (IBAction)refreshAction:(UIBarButtonItem *)sender {
    
    [self requestContactData];
    
}

- (IBAction)synchronizationAction:(UIBarButtonItem *)sender {
    
    //44j5VjQZJgrDXeZbA4_-ii6edzqoCe_sGB8vNO7y:J9IXVu231rxZ22JOHQLt5WdwkRQ=:eyJzY29wZSI6InhpYW5nemkiLCJkZWFkbGluZSI6MTQ2MDEyMjA0Nn0=
    
    NSString *key = @"xiangzi:addressBook.sqlite";

    NSString *token = [self tokenWithScope:key];
    
    NSString *filePath = [self dataBasePath];
    NSData *data = [NSData dataWithContentsOfFile:filePath];

    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    [upManager putData:data key:@"addressBook.sqlite" token:token complete:
     ^(QNResponseInfo *info, NSString *key, NSDictionary *resp)
    {
        NSLog(@"%@", info);
        NSLog(@"%@", resp);
        
        
    } option:nil];
    
    
    
}

//获取数据库路径
- (NSString *)dataBasePath {
    //1.获取document文件夹路径
    NSString *documentpath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //2.拼接上数据库文件路径
    return [documentpath stringByAppendingPathComponent:kDataBaseName];
}
#pragma mark - NSNotificationCenter
- (void)handleDataFinishNSNotification {
    [self.tableView reloadData];
}

- (void)handleInitializeInfoNSNotification {
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [DataBaseHelper numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [DataBaseHelper numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AA" forIndexPath:indexPath];
    [DataBaseHelper contactIndextPath:indexPath];
    cell.contact = [DataBaseHelper contactIndextPath:indexPath];
    
    return cell;
    
    
}

//设置分区title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [DataBaseHelper titleForHeaderInSection:section];
}
//设置分区索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return [DataBaseHelper sectionIndexTitles];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    //张祥   名字换掉
    
    //通过视图控制器与视图控制器之间的桥，跳转到下一界面
    [self performSegueWithIdentifier:@"push" sender:indexPath];
    NSLog(@"AAAAA");
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //当选中Cell进入下一界面之前，需要把选中cell对应的contact对象传入下一界面
    if ([segue.identifier isEqualToString:@"push"]) {
        DetailViewController *detailVC = segue.destinationViewController;
        detailVC.contact = [DataBaseHelper contactIndextPath:sender];
        
        AddressCell *cell = [self.tableView cellForRowAtIndexPath:sender];
        detailVC.photo = cell.photoView.image;
        NSLog(@"BBBB");
    }
}


@end
