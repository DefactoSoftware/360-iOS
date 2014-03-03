//
//  TSFTemplateViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFTemplateViewController.h"
#import "TSFGenerics.h"

@implementation TSFTemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *closeButtonTitle = TSFLocalizedString(@"TSFTemplateViewControllerCloseButton", @"Close");
    [self.closeButton setTitle:closeButtonTitle forState:UIControlStateNormal];
}

@end
