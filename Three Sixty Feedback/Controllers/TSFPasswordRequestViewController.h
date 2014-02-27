//
//  TSFPasswordRequestViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFSessionService.h"
#import "TSFBaseViewController.h"

@interface TSFPasswordRequestViewController : TSFBaseViewController

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIButton *requestButton;
@property (weak, nonatomic) IBOutlet UILabel *successLabel;
@property (nonatomic, strong) TSFSessionService *sessionService;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

- (void)requestNewPassword;
- (IBAction)requestButtonPressed:(id)sender;
- (IBAction)closeButtonPressed:(id)sender;

@end
