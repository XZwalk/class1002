//
//  AddressListController.m
//  lessonSqlite
//
//  Created by lanouhn on 15-2-3.
//  Copyright (c) 2015年 XZH. All rights reserved.
//

#import "AddressListController.h"
#import "AddressCell.h"
#import "DataBaseHelper.h"
#import "DetailViewController.h"
#import "ProgressHUD.h"


#define kFileName   @"addressBook.sqlite"


@interface AddressListController ()

@end

@implementation AddressListController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if ([self isNeedRequestDataFromServer]) {
        [self requestContactData];
    }
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


#pragma mark - private api

- (BOOL)isNeedRequestDataFromServer {
    
    NSString * fullPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    fullPath = [fullPath stringByAppendingPathComponent:kFileName];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:fullPath]) {
        return NO;
    }
    
    return YES;
}


- (void)requestContactData {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://7xrdjn.com1.z0.glb.clouddn.com/addressBook.sqlite"];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            [self writeNewsAtFirstPage:data toLocalFile:@"addressBook.sqlite"];
        }
    }];
    
    [task resume];
}

- (void)writeNewsAtFirstPage:(NSData *)fileData toLocalFile:(NSString *)fileName {
    NSString * fullPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    fullPath = [fullPath stringByAppendingPathComponent:fileName];
    
    if (NO == [[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
        if (NO == [[NSFileManager defaultManager] createFileAtPath:fullPath contents:nil attributes:nil]) {
            NSLog(@"------------------file create fail------------------");
        }
    }
    
    if (NO == [fileData writeToFile:fullPath atomically:YES]) {
        NSLog(@"------------------file write fail------------------");
    }else
    {
        
        [self.tableView reloadData];
        
        NSLog(@"------------------file write success------------------");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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

    return 50;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //判断是否需要删除分区
    if ([DataBaseHelper isNeedToDeleteSection:indexPath.section]) {
        [DataBaseHelper deleteSection:indexPath.section];
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
        [tableView deleteSections:indexSet withRowAnimation:(UITableViewRowAnimationLeft)];
    } else {
        [DataBaseHelper deleteRowAtIndexPath:indexPath];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationLeft)];
    }
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
