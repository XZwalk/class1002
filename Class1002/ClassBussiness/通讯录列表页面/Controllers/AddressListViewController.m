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

@interface AddressListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) ContactServer *contactSever;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNSNotification) name:kDataFinishNSNotification object:nil];
    
    
    _contactSever = [[ContactServer alloc] init];
    
    if ([self isNeedRequestDataFromServer]) {
        [self requestContactData];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDataFinishNSNotification object:nil];
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
    

    [_contactSever requestContactListData:^(id resultObject) {
        [DataBaseHelper readDataFromDataBase];
        
    } fail:^(id resultObject) {
        
        
    }];
}



#pragma mark - NSNotificationCenter
- (void)handleNSNotification {
    
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
        NSLog(@"BBBB");
    }
}


@end
