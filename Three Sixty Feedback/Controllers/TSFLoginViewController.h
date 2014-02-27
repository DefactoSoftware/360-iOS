//
//  TSFLoginViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 19-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFSessionService.h"
#import "TSFBaseViewController.h"

@interface TSFLoginViewController : TSFBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *requestPasswordButton;
@property (nonatomic, strong) TSFSessionService *sessionService;

- (IBAction)loginButtonPressed:(id)sender;
- (IBAction)requestPasswordButtonPressed:(id)sender;
@end
