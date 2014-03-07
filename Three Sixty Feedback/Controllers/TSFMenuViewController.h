//
//  TSFMenuViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFMainViewController.h"
#import "TSFSecondaryButton.h"
#import "TSFBaseViewController.h"

@interface TSFMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) IBOutlet TSFSecondaryButton *closeButton;
@property (nonatomic, strong) TSFMainViewController *contentViewControlller;

@end