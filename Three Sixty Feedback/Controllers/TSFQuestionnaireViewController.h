//
//  TSFQuestionnaireViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis on 30/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFQuestionnaireService.h"
#import "TSFGenerics.h"

@interface TSFQuestionnaireViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) TSFQuestionnaireService *questionnaireService;
@property (nonatomic, strong) TSFQuestionnaire *questionnaire;
@property (weak, nonatomic) IBOutlet UITableView *keyBehavioursTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousKeyBehaviourButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextKeyBehaviourButton;

- (void)loadQuestionnaire;

@end
