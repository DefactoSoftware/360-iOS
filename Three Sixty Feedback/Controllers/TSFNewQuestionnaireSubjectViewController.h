//
//  TSFNewQuestionnaireSubjectViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFBaseViewController.h"
#import "TSFNewQuestionnaireTemplateViewController.h"
#import "TSFButton.h"

@interface TSFNewQuestionnaireSubjectViewController : TSFBaseViewController

@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UITextField *subjectTextField;
@property (weak, nonatomic) IBOutlet TSFButton *nextButton;

- (BOOL)validate;
- (IBAction)nextButtonPressed:(id)sender;

@end
