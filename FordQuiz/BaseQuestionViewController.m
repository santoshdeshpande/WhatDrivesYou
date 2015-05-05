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
@end

@implementation BaseQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.optionView.delegate = self;
    self.optionView.dataSource = self;
    self.currentSelection = -1;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Questions" ofType:@"plist"];
    self.questions = [NSMutableArray arrayWithContentsOfFile:path];
    NSInteger tag = self.view.tag;
    NSDictionary *dict = [self.questions objectAtIndex:tag];
    self.options = [dict objectForKey:@"Options"];
    self.questionLabel.text = [dict objectForKey:@"Question"];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self updateSelection];
//    [self.navigationItem setHidesBackButton:YES];

}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
//    [self.navigationItem setHidesBackButton:YES];

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
    cell.optionView.layer.borderWidth = 1.0f;
    cell.optionView.layer.borderColor = [UIColor whiteColor].CGColor;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(self.currentSelection != -1) {
        NSIndexPath *path = [NSIndexPath indexPathForItem:self.currentSelection inSection:0];
        OptionCollectionViewCell *previous = (OptionCollectionViewCell*) [collectionView cellForItemAtIndexPath:path];
        NSLog(@"Previous - %@",previous);
        previous.optionView.backgroundColor = [UIColor clearColor];
    }
    OptionCollectionViewCell *cell = (OptionCollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
    cell.optionView.backgroundColor = [UIColor redColor];
    [self setCurrentSelection:indexPath.row];
    NSInteger tag = self.view.tag;
    NSString *key = [NSString stringWithFormat:@"answer-%ld", (long)tag];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setInteger:indexPath.row+1 forKey:key];
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
        cell.optionView.backgroundColor = [UIColor redColor];
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

@end
