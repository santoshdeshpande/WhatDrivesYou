//
//  WebViewController.m
//  FordQuiz
//
//  Created by Santosh S on 06/05/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString: self.urlLink]];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.indicatorView setHidden:NO];
    [self.activityIndicator setHidden:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
    [self.indicatorView setHidden:YES];    
    [self.activityIndicator setHidden:YES];
}


#pragma mark - Navigation

- (IBAction)onCloseButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
