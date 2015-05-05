//
//  QuestionView.m
//  FordQuiz
//
//  Created by Santosh S on 05/05/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "QuestionView.h"

@implementation QuestionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib {
    [[NSBundle mainBundle] loadNibNamed:@"QuestionView" owner:self options:nil];
    [self addSubview:self.contentView];
}

@end
