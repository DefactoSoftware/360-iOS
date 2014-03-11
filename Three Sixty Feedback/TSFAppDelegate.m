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

static NSString *const TSFPadStoryboardIdentifier = @"Main_iPad";
static NSString *const TSFPhoneStoryboardIdentifier = @"Main_iPhone";
static NSString *const TSFQuestionnaireViewControllerIdentifier = @"TSFAssessorQuestionnaireViewControllerNavigation";

@implementation TSFAppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor TSFLightGreyColor];
    pageControl.currentPageIndicatorTintColor = [UIColor TSFOrangeColor];
    pageControl.backgroundColor = [UIColor TSFBeigeColor];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    [[TSFAPIClient sharedClient] setAssessorTokenWithURL:url];

    NSString *storyboardIdentifier = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? TSFPadStoryboardIdentifier : TSFPhoneStoryboardIdentifier;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardIdentifier
                                                         bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:TSFQuestionnaireViewControllerIdentifier];
    [self.window.rootViewController presentViewController:viewController
                                                 animated:YES
                                               completion:^{}];
    
    return YES;
}

@end
