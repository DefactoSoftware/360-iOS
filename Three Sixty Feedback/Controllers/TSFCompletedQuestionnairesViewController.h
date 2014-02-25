//
//  TSFCompletedQuestionnairesViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFQuestionnairesTabBarController.h"

@class TSFQuestionnairesTabBarController;

@interface TSFCompletedQuestionnairesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) TSFQuestionnairesTabBarController *questionnairesTabBarController;
@property (weak, nonatomic) IBOutlet UITableView *questionnairesTableView;

- (void)reloadData;

@end
