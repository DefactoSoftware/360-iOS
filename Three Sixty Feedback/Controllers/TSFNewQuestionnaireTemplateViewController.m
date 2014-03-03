//
//  TSFNewQuestionnaireTemplateViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFNewQuestionnaireTemplateViewController.h"
#import "CRToast.h"
#import "UIColor+TSFColor.h"
#import "TSFGenerics.h"

@interface TSFNewQuestionnaireTemplateViewController()
@property (nonatomic, strong) NSArray *templates;
@end

@implementation TSFNewQuestionnaireTemplateViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self sharedSetup];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        [self sharedSetup];
    }
    return self;
}

- (void)sharedSetup {
    self.templateService = [TSFTemplateService sharedService];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchTemplates];
}

- (void)fetchTemplates {
    __weak typeof (self) _self = self;
    [self.templateService templatesWithSuccess:^(NSArray *templates) {
        _self.templates = templates;
    } failure:^(NSError *error) {
        NSDictionary *options = @{kCRToastTextKey : TSFLocalizedString(@"TSFNewQuestionnaireTemplateViewControllerError", @"Could not get templates"),
                                  kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                  kCRToastBackgroundColorKey : [UIColor TSFErrorColor]};
        [CRToastManager showNotificationWithOptions:options completionBlock:^{ }];
    }];
}

- (BOOL)validate {
    return YES;
}

@end
