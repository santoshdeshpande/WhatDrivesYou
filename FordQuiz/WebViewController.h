//
//  WebViewController.h
//  FordQuiz
//
//  Created by Santosh S on 06/05/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>
- (IBAction)onCloseButtonClicked:(id)sender;
@property NSString *urlLink;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@end
