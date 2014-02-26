//
//  TSFUserQuestionnaireAssessorsViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFQuestionnaire.h"
#import "TSFAssessorService.h"

@interface TSFUserQuestionnaireAssessorsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) TSFQuestionnaire *questionnaire;
@property (nonatomic, strong) TSFAssessorService *assessorService;
@property (weak, nonatomic) IBOutlet UITableView *assessorsTableView;

- (void)remindAssessors;

@end
