//
//  TSFNewQuestionnaireTemplateViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFBaseViewController.h"
#import "TSFTemplateService.h"
#import "TSFButton.h"
#import "TSFSecondaryButton.h"

@interface TSFNewQuestionnaireTemplateViewController : TSFBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) TSFTemplateService *templateService;
@property (weak, nonatomic) IBOutlet UITableView *templatesTableView;
@property (weak, nonatomic) IBOutlet TSFSecondaryButton *nextButton;

- (BOOL)validate;
- (IBAction)showTemplateButtonPressed:(TSFButton *)sender;
- (IBAction)goToNextStep:(id)sender;

@end
