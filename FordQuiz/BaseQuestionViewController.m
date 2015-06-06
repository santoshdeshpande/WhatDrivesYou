//
//  BaseQuestionViewController.m
//  FordQuiz
//
//  Created by Santosh S on 04/05/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "BaseQuestionViewController.h"
#import "OptionCollectionViewCell.h"

@interface BaseQuestionViewController ()
@property NSArray *options;
@property NSArray *questions;
@property NSArray *answerKeys;
@property UIColor *backgroundColor;
@end

@implementation BaseQuestionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundColor = [UIColor colorWithRed:(229/255.0f) green:(45/255.0f) blue:(61/255.0f) alpha:1.0];
    // Do any additional setup after loading the view.
    self.optionView.delegate = self;
    self.optionView.dataSource = self;
    self.currentSelection = -1;
    self.questions = [[NSUserDefaults standardUserDefaults] objectForKey:@"Questions"];
    NSInteger tag = self.view.tag;
    NSDictionary *dict = [self.questions objectAtIndex:tag];
    self.options = [dict objectForKey:@"Options"];
    self.answerKeys = [dict objectForKey:@"AnswerKeys"];
    self.questionLabel.text = [dict objectForKey:@"Question"];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self updateSelection];
    [self setupImage1];
    self.backgroundImage.alpha = 1.0f;
    self.backgroundImage.contentMode = UIViewContentModeScaleToFill;
    self.navigationItem.title = @"Back";
}

- (void) viewWillAppear:(BOOL)animated {
    self.navigationItem.title = @"Back";
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    [self setupImage1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.options count];
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"questionCell";
    OptionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.optionLabel.text = [self.options objectAtIndex:indexPath.row];
    cell.points = [[self.answerKeys objectAtIndex:indexPath.row] intValue];
    cell.optionView.layer.borderWidth = 1.0f;
    cell.optionView.layer.borderColor = [UIColor whiteColor].CGColor;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(self.currentSelection != -1) {
        NSIndexPath *path = [NSIndexPath indexPathForItem:self.currentSelection inSection:0];
        OptionCollectionViewCell *previous = (OptionCollectionViewCell*) [collectionView cellForItemAtIndexPath:path];
        previous.optionView.backgroundColor = [UIColor clearColor];
    }
    OptionCollectionViewCell *cell = (OptionCollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
    cell.optionView.backgroundColor = self.backgroundColor;
    [self setCurrentSelection:indexPath.row];
    NSInteger tag = self.view.tag;
    NSString *key = [NSString stringWithFormat:@"answer-%ld", (long)tag];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setInteger:indexPath.row+1 forKey:key];
    NSInteger numberOfPoints = cell.points;
//    NSArray *array = (NSArray *) [defaults objectForKey:@"Points"];
    NSMutableArray *array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Points"]];
    NSString *points = [NSString stringWithFormat:@"%ld", (long)numberOfPoints];
    [array replaceObjectAtIndex:tag withObject:points];
    [defaults setObject:array forKey:@"Points"];
    NSLog(@"Array - %@",array);
    /*if(numberOfPoints == 2) {
        long current = [defaults integerForKey:@"NumberOfTwos"];
        NSString *answerPattern = [defaults objectForKey:@"AnswerPattern"];
        if(current < 4) {
            [defaults setInteger:current+1 forKey:@"NumberOfTwos"];
            NSString *option = [self.optionKey objectAtIndex:indexPath.row];
            if([answerPattern containsString:option] == FALSE) {
                NSString *newPattern = [answerPattern stringByAppendingString:option];
                NSLog(@"Pattern - %@",newPattern);
                [defaults setObject:newPattern forKey:@"AnswerPattern"];                
            }
        }
    }*/
    if(self.validationLabel) {
        [self.validationLabel setHidden:YES];
    }
    
}

- (void) updateSelection {
    NSInteger tag = self.view.tag;
    NSString *key = [NSString stringWithFormat:@"answer-%ld", (long)tag];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults integerForKey:key] != 0) {
        NSIndexPath *path = [NSIndexPath indexPathForItem:[defaults integerForKey:key]-1 inSection:0];
        OptionCollectionViewCell *cell = (OptionCollectionViewCell*) [self.optionView cellForItemAtIndexPath:path];
        [self setCurrentSelection:path.row];
        if(cell == nil) {
            [self.optionView layoutIfNeeded];
            cell = (OptionCollectionViewCell*)[self.optionView cellForItemAtIndexPath:path];
        }
        cell.optionView.backgroundColor = self.backgroundColor;
    }
    
    if(self.validationLabel) {
        [self.validationLabel setHidden:YES];
    }


}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if(self.currentSelection == -1) {
        if(self.validationLabel != nil) {
            [self.validationLabel setHidden:NO];
        }
        return NO;
    }
    return YES;
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
