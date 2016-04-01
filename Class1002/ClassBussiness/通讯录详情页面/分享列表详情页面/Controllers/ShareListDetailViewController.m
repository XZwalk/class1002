//
//  ShareListDetailViewController.m
//  Class1002
//
//  Created by 张祥 on 16/4/1.
//  Copyright © 2016年 张祥. All rights reserved.
//

#import "ShareListDetailViewController.h"

@interface ShareListDetailViewController ()


@property (strong, nonatomic) IBOutlet UIWebView *webView;



@end

@implementation ShareListDetailViewController

- (void)viewDidLoad {
    
    
    NSURL *url = [NSURL URLWithString:self.linkUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    
}


@end
