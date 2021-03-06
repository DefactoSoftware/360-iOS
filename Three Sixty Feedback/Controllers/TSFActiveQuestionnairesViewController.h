//
//  TSFActiveQuestionnairesViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFQuestionnairesTabBarController.h"

@class TSFQuestionnairesTabBarController;

@interface TSFActiveQuestionnairesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) TSFQuestionnairesTabBarController *questionnairesTabBarController;
@property (weak, nonatomic) IBOutlet UITableView *questionnairesTableView;

- (void)reloadData;

@end