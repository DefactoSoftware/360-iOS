//
//  TSFActiveQuestionnairesViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFQuestionnaire.h"

@interface TSFActiveQuestionnairesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *questionnaires;
@property (weak, nonatomic) IBOutlet UITableView *questionnairesTableView;

- (void)displayQuestionnaires:(NSArray *)questionnaires;

@end