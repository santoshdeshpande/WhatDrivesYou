//
//  BaseQuestionViewController.h
//  FordQuiz
//
//  Created by Santosh S on 04/05/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseQuestionViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *optionView;
@property NSInteger currentSelection;
@property (weak, nonatomic) IBOutlet UILabel *validationLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property NSArray *optionKey;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@end
