//
//  TSFLoginViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 19-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFAppDelegate.h"
#import "TSFLoginViewController.h"
#import "TSFGenerics.h"
#import "UIColor+TSFColor.h"
#import <CRToast/CRToast.h>

static NSString *const TSFMainViewControllerIdentifier = @"TSFMainViewController";

@implementation TSFLoginViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self sharedSetup];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        [self sharedSetup];
    }
    return self;
}

- (void)sharedSetup {
    _sessionService = [TSFSessionService sharedService];
    _credentialStore = _sessionService.credentialStore;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = TSFLocalizedString(@"TSFLoginViewControllerTitle", @"Login");
    self.emailLabel.text = TSFLocalizedString(@"TSFLoginViewControllerEmail", @"E-mail address");
    self.passwordLabel.text = TSFLocalizedString(@"TSFLoginViewControllerPassword", @"Password");
    [self.loginButton setTitle:TSFLocalizedString(@"TSFLoginViewControllerButton", @"Login") forState:UIControlStateNormal];
    [self addResignGestureRecognizer];
    
    [self checkSession];
}

- (void)checkSession {
    if ([self.credentialStore hasStoredCredentials]) {
        [self pushToMainViewController];
    }
}

- (IBAction)loginButtonPressed:(id)sender {
    __weak typeof(self) _self = self;
    [self.sessionService createNewSessionWithEmail:self.emailTextField.text
                                          password:self.passwordTextField.text
                                           success:^(TSFUser *user) {
       [_self pushToMainViewController];
    } failure:^(NSError *error) {
        NSDictionary *options = @{kCRToastTextKey : TSFLocalizedString(@"TSFLoginViewControllerFail", @"Failed logging in"),
                                  kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                  kCRToastBackgroundColorKey : [UIColor TSFErrorColor]};
        [CRToastManager showNotificationWithOptions:options completionBlock:^{ }];
        NSLog(@"Error logging in. Message: %@", error.localizedDescription);
    }];
}

- (void)pushToMainViewController {
    TSFAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    delegate.window.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:TSFMainViewControllerIdentifier];
}

@end
