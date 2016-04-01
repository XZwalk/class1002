//
//  ShareListViewController.m
//  Class1002
//
//  Created by 张祥 on 16/4/1.
//  Copyright © 2016年 张祥. All rights reserved.
//

#import "ShareListViewController.h"
#import "ShareListCell.h"
#import "ShareListDetailViewController.h"

@interface ShareListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *listAry;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end



@implementation ShareListViewController


- (void)viewDidLoad {
    
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self requestInitData];
    
}


#pragma mark - private apis
- (void)requestInitData {
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSString *timeStr = [Tools getTimestampStr];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kRequestShareListUrl, timeStr]];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if ([result isKindOfClass:[NSDictionary class]]) {
                
                self.listAry = result[@"data"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.tableView reloadData];
                });
            }
            
        } else {
            
            
        }
    }];
    
    [task resume];
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShareListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShareListCell"];
    
    if (indexPath.row < self.listAry.count) {
        NSDictionary *dataDic = self.listAry[indexPath.row];
        
        NSString *title = dataDic[@"name"];
        
        cell.titleLabel.text = title;
        
    }

    return cell;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"shareListToDetail" sender:indexPath];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //当选中Cell进入下一界面之前，需要把选中cell对应的contact对象传入下一界面
    if ([segue.identifier isEqualToString:@"shareListToDetail"]) {
        ShareListDetailViewController *detailVC = segue.destinationViewController;
        
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        
        if (indexPath.row < self.listAry.count) {
            NSDictionary *dataDic = self.listAry[indexPath.row];
            NSString *linkUrl = dataDic[@"url"];
            detailVC.linkUrl = linkUrl;

        }
        
        NSLog(@"BBBB");
    }
}




@end
