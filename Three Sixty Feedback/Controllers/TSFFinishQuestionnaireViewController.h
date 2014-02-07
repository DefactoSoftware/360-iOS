//
//  TSFFinishQuestionnaireViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 02-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFAssessorService.h"
#import "TSFBaseViewController.h"
#import "TSFQuestionnaireViewController.h"

@class TSFQuestionnaireViewController;

@interface TSFFinishQuestionnaireViewController : TSFBaseViewController

@property (nonatomic, strong) TSFAssessorService *assessorService;
@property (weak, nonatomic) IBOutlet UILabel *thankLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousButton;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) TSFQuestionnaireViewController *questionnaireViewController;

- (void)canComplete;
- (IBAction)sendButtonPressed:(id)sender;
- (IBAction)previousButtonPressed:(id)sender;

@end
