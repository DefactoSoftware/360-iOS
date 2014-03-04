//
//  TSFNewQuestionnaireAssessorsViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 04-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFBaseViewController.h"
#import "TSFTemplate.h"

@interface TSFNewQuestionnaireAssessorsViewController : TSFBaseViewController

@property (weak, nonatomic) IBOutlet UITableView *assessorsTableView;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) TSFTemplate *questionnaireTemplate;
@property (weak, nonatomic) IBOutlet UILabel *addAssessorTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *addAssessorTextField;

@end
