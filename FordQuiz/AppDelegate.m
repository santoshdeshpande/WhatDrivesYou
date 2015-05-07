//
//  AppDelegate.m
//  FordQuiz
//
//  Created by Santosh S on 04/05/15.
//  Copyright (c) 2015 Santosh S. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
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
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
