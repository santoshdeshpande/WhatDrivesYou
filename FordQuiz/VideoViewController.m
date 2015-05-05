//
//  VideoViewController.m
//  FordQuiz
//
//  Created by Santosh S on 05/05/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "VideoViewController.h"
@import AVKit;
@import AVFoundation;

@interface VideoViewController ()

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL * urlA1 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Commercial"ofType:@"mp4"]];
    
    self.player = [AVPlayer playerWithURL:urlA1];
    [self setShowsPlaybackControls:NO];
    [self.navigationController setNavigationBarHidden:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:[self.player currentItem]];
    [self.player play];
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

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
