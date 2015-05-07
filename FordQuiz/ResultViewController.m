//
//  ResultViewController.m
//  FordQuiz
//
//  Created by Santosh S on 06/05/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "ResultViewController.h"
#import "WebViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *identifier = [segue identifier];
    if([identifier isEqualToString:@"participate"]) {
        WebViewController *controller = (WebViewController *)[segue destinationViewController];
        controller.urlLink = @"https://whatdrivesyou.in/#participate";
    }
    if([identifier isEqualToString:@"informed"]) {
        WebViewController *controller = (WebViewController *)[segue destinationViewController];
        controller.urlLink = @"https://www.india.ford.com/cars/figoaspire/kmi?ctx=m:1249148574862-roadshow";
    }
    
    
}

@end
