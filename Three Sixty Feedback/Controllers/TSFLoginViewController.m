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
#import <CRToast/CRToast.h>

static NSString *const TSFMainViewControllerIdentifier = @"TSFMainViewController";
static NSString *const TSFRequestPasswordSegue = @"TSFRequestPasswordSegue";

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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = TSFLocalizedString(@"TSFLoginViewControllerTitle", @"Login");
    self.emailLabel.text = TSFLocalizedString(@"TSFLoginViewControllerEmail", @"E-mail address");
    self.passwordLabel.text = TSFLocalizedString(@"TSFLoginViewControllerPassword", @"Password");
    [self.loginButton setTitle:TSFLocalizedString(@"TSFLoginViewControllerButton", @"Login") forState:UIControlStateNormal];
    [self.requestPasswordButton setTitle:TSFLocalizedString(@"TSFLoginViewControllerRequestPasswordButton", @"Forgot password?") forState:UIControlStateNormal];
}

- (IBAction)loginButtonPressed:(id)sender {
    __weak typeof(self) _self = self;
    [self.sessionService createNewSessionWithEmail:self.emailTextField.text
                                          password:self.passwordTextField.text
                                           success:^(TSFUser *user) {
       TSFAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
       delegate.window.rootViewController = [_self.storyboard instantiateViewControllerWithIdentifier:TSFMainViewControllerIdentifier];
    } failure:^(NSError *error) {
        NSDictionary *options = @{kCRToastTextKey : TSFLocalizedString(@"TSFLoginViewControllerFail", @"Failed logging in"),
                                  kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                  kCRToastBackgroundColorKey : [UIColor redColor]};
        [CRToastManager showNotificationWithOptions:options completionBlock:^{ }];
        NSLog(@"Error logging in. Message: %@", error.localizedDescription);
    }];
}

- (IBAction)requestPasswordButtonPressed:(id)sender {
    [self performSegueWithIdentifier:TSFRequestPasswordSegue sender:self];
}

@end
