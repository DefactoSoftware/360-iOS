//
//  TSFPasswordRequestViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFPasswordRequestViewController.h"
#import "TSFGenerics.h"
#import <CRToast/CRToast.h>

@implementation TSFPasswordRequestViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self sharedSetup];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        [self sharedSetup];
    }
    return self;
}

- (void)sharedSetup {
    _sessionService = [TSFSessionService sharedService];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = TSFLocalizedString(@"TSFPasswordRequestViewControllerTitle", @"Forgot password");
    self.emailLabel.text = TSFLocalizedString(@"TSFPasswordRequestEmailLabel", @"E-mail address");
    [self.requestButton setTitle:TSFLocalizedString(@"TSFPasswordRequestButton", @"Request new password") forState:UIControlStateNormal];
    [self.closeButton setTitle:TSFLocalizedString(@"TSFPasswordRequestCloseButton", @"Close") forState:UIControlStateNormal];
}

- (void)requestNewPassword {
    __weak typeof (self) _self = self;
    [self.sessionService createNewPasswordRequestForEmail:self.emailTextField.text withSuccess:^(NSNumber *success) {
        _self.successLabel.text = TSFLocalizedString(@"TSFPasswordRequestViewControllerSuccess", @"An email has been sent to the given address. Please follow the instructions in the mail to reset your password.");
        _self.requestButton.enabled =  NO;
    } failure:^(NSError *error) {
        NSDictionary *options = @{kCRToastTextKey : TSFLocalizedString(@"TSFPasswordRequestViewControllerFail", @"Could not find e-mail address"),
                                  kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                  kCRToastBackgroundColorKey : [UIColor redColor]};
        [CRToastManager showNotificationWithOptions:options completionBlock:^{ }];
        NSLog(@"Error logging in. Message: %@", error.localizedDescription);
    }];
}

- (IBAction)requestButtonPressed:(id)sender {
    [self requestNewPassword];
}

- (IBAction)closeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
