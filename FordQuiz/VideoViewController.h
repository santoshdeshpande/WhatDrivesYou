//
//  VideoViewController.h
//  FordQuiz
//
//  Created by Santosh S on 05/05/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AVKit;

@interface VideoViewController : AVPlayerViewController

- (void)playerItemDidReachEnd: (NSNotification *)notification;

@end
