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
@property NSArray *optionKey;
@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupImage1];
    self.optionKey = @[@"C ",@"I ",@"P ",@"A ",@"T ",@"R ",@"U "];
    NSDictionary *types = @{@"C" : @"Creativity",@"I":@"Innovation",@"P":@"Pride",@"A":@"Ambition",@"T":@"Togetherness",@"R":@"Responsibility",@"U":@"Trust"};
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = (NSArray *) [defaults objectForKey:@"Points"];
    NSString *key = @"";
    int numberOfTwo = 0;
    for (NSUInteger i=0; i<[array count]-1; i++) {
        NSString *value = [array objectAtIndex:i];
        if([value isEqualToString:@"2"] && numberOfTwo < 4) {
            numberOfTwo++;
            key = [key stringByAppendingString:[self.optionKey objectAtIndex:i]];
        }
    }
    NSArray *sorted =[[key componentsSeparatedByString:@" "] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *final = [sorted componentsJoinedByString:@""];
    if([final isEqualToString:@""]) {
        final = @"C";
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Values" ofType:@"plist"];
    NSDictionary *values = [NSDictionary dictionaryWithContentsOfFile:path];
    NSDictionary *vals = [values objectForKey:@"One"];
    NSString *finalTrait = [vals objectForKey:final];

    NSLog(@"%@ - %@",final, finalTrait);
    
    path = [[NSBundle mainBundle] pathForResource:@"Results" ofType:@"plist"];
    values = [NSDictionary dictionaryWithContentsOfFile:path];
    
    self.typeLabel.text = [NSString stringWithFormat:@"You're Driven By:  %@",[types objectForKey:finalTrait]];
    self.valueLabel.text = [values objectForKey:finalTrait];
    

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

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self setupImage];
}

- (void) setupImage {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    switch ((long)orientation) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            [self.backgroundImage setImage:[UIImage imageNamed:@"background"]];
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            [self.backgroundImage setImage:[UIImage imageNamed:@"Background-image-portrait-2"]];
            break;
    }
}

- (void) setupImage1 {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    switch ((long)orientation) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            [self.backgroundImage setImage:[UIImage imageNamed:@"Background-image-portrait-2"]];
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            [self.backgroundImage setImage:[UIImage imageNamed:@"background"]];
            break;
    }
}



@end
