//
//  TSFQuestionnaireIntroViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 02-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFGenerics.h"
#import "TSFQuestionnaireService.h"

@interface TSFQuestionnaireIntroViewController : UIViewController

@property (nonatomic, strong) TSFQuestionnaireService *questionnaireService;
@property (weak, nonatomic) IBOutlet UIScrollView *introScrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (nonatomic, strong) TSFQuestionnaire *questionnaire;

- (IBAction)startButtonPressed:(id)sender;

@end
