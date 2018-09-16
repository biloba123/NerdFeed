//
// Created by 吕晴阳 on 2018/9/16.
// Copyright (c) 2018 Lv Qingyang. All rights reserved.
//

#import "NFWebViewController.h"

@interface NFWebViewController ()
@property(weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;

@end

@implementation NFWebViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.scalesPageToFit=YES;
}

- (void)viewWillAppear:(BOOL)animated {
    NSURLRequest *request = [NSURLRequest requestWithURL:[[NSURL alloc] initWithString:self.url]];
    [self.webView loadRequest:request];
    self.backItem.enabled=self.goBackEnable;
    self.forwardItem.enabled=self.goForwardEnable;
}

- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}

- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}
@end
