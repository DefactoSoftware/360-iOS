//
//  TSFNewQuestionnaireConfirmViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 04-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFQuestionnaireService.h"
#import "TSFAssessorService.h"
#import "TSFTemplate.h"
#import "TSFBaseViewController.h"
#import "TSFButton.h"

@interface TSFNewQuestionnaireConfirmViewController : TSFBaseViewController
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) TSFTemplate *questionnaireTemplate;
@property (nonatomic, strong) NSArray *assessors;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *templateLabel;
@property (weak, nonatomic) IBOutlet UILabel *assessorsLabel;
@property (weak, nonatomic) IBOutlet TSFButton *createButton;
@property (nonatomic, strong) TSFQuestionnaireService *questionnaireService;
@property (nonatomic, strong) TSFAssessorService *assessorService;

- (void)createQuestionnaire;
- (IBAction)confirmButtonPressed:(id)sender;

@end
