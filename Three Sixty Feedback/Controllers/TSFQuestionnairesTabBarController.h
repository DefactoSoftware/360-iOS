//
//  TSFQuestionnairesViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TSFBaseViewController.h"
#import "RESideMenu.h"

@interface TSFQuestionnairesTabBarController : UITabBarController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

- (IBAction)menuButtonPressed:(id)sender;

@end