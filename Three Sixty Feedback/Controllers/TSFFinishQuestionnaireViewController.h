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

@interface TSFFinishQuestionnaireViewController : TSFBaseViewController

@property (nonatomic, strong) TSFAssessorService *assessorService;
@property (weak, nonatomic) IBOutlet UILabel *thankLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousButton;

- (void)sendCompletion;
- (IBAction)sendButtonPressed:(id)sender;
- (IBAction)previousButtonPressed:(id)sender;

@end
