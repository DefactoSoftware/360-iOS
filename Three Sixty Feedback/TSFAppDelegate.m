//
//  TSFAppDelegate.m
//  Three Sixty Feedback
//
//  Created by Girgis on 28/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//
#import "TSFAppDelegate.h"
#import "TSFAPIClient.h"
#import "UIColor+TSFColor.h"

@implementation TSFAppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor TSFLightGreyColor];
    pageControl.currentPageIndicatorTintColor = [UIColor TSFOrangeColor];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    [[TSFAPIClient sharedClient] setAssessorTokenWithURL:url];
    return YES;
}

@end
