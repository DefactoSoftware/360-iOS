//
//  TSFNewQuestionnaireSubjectViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFNewQuestionnaireSubjectViewController.h"
#import "TSFGenerics.h"
#import "UIColor+TSFColor.h"

@implementation TSFNewQuestionnaireSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.subjectLabel.text = TSFLocalizedString(@"TSFNewQuestionnaireSubjectViewControllerTitle", @"What is the subject of this feedback evaluation?");
    self.subjectLabel.textColor = [UIColor TSFLightGreyTextColor];
}

@end
