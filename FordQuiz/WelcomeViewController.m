//
//  WelcomeViewController.m
//  FordQuiz
//
//  Created by Santosh S on 05/05/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupImage1];
    // Do any additional setup after loading the view.
//    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self setupImage1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)unwindToResourceBankView:(UIStoryboardSegue *)segue {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@[@"",@"",@"",@"",@"",@"",@"",@""] forKey:@"Points"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Questions" ofType:@"plist"];
    NSMutableArray *questions = [NSMutableArray arrayWithContentsOfFile:path];
    for (int i = 0; i < questions.count; i++) {
        NSDictionary *question = [questions objectAtIndex:i];
        NSMutableArray *options = [NSMutableArray arrayWithArray:[question objectForKey:@"Options"]];
        NSMutableArray *keys = [NSMutableArray arrayWithArray:[question objectForKey:@"AnswerKeys"]];
        for(int j=0;j<options.count;j++) {
            int randomInt1 = arc4random() % [options count];
            int randomInt2 = arc4random() % [options count];
            [options exchangeObjectAtIndex:randomInt1 withObjectAtIndex:randomInt2];
            [keys exchangeObjectAtIndex:randomInt1 withObjectAtIndex:randomInt2];
        }
        [question setValue:options forKey:@"Options"];
        [question setValue:keys forKey:@"AnswerKeys"];
    }
    [defaults setObject:questions forKey:@"Questions"];
    
}

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self setupImage];
}

- (void) setupImage {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    NSLog(@"Orientation - %ld",orientation);
    switch ((long)orientation) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            [self.backgroundImage setImage:[UIImage imageNamed:@"main-background"]];
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            [self.backgroundImage setImage:[UIImage imageNamed:@"Background-image-portrait-1"]];
            break;
    }
}

- (void) setupImage1 {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    NSLog(@"Orientation - %ld",orientation);
    switch ((long)orientation) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            [self.backgroundImage setImage:[UIImage imageNamed:@"Background-image-portrait-1"]];
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            [self.backgroundImage setImage:[UIImage imageNamed:@"main-background"]];
            break;
    }
}



@end
