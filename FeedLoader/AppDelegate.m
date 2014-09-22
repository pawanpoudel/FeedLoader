//
//  AppDelegate.m
//  FeedLoader
//
//  Created by Pawan Poudel on 9/20/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "AppDelegate.h"
#import "FeedListViewController.h"
#import "ObjectConfigurator.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    FeedListViewController *feedListVC = [[ObjectConfigurator sharedInstance] feedListViewController];
    UINavigationController *feedListNavController = [[UINavigationController alloc] initWithRootViewController:feedListVC];
    
    self.window.rootViewController = feedListNavController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
