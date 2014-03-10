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
#import "TSFButton.h"
#import "TSFCredentialStore.h"

@interface TSFLoginViewController : TSFBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet TSFButton *loginButton;
@property (nonatomic, strong) TSFSessionService *sessionService;
@property (nonatomic, strong) TSFCredentialStore *credentialStore;

- (IBAction)loginButtonPressed:(id)sender;
@end
