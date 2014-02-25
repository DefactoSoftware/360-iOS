//
//  TSFUserQuestionnaireViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFUserQuestionnaireInfoViewController.h"
#import "TSFUserQuestionnaireAssessorsViewController.h"
#import "TSFQUestionnaire.h"

@interface TSFUserQuestionnaireTabBarController : UITabBarController
@property (nonatomic, strong) TSFQuestionnaire *questionnaire;
@property (nonatomic, strong) TSFUserQuestionnaireInfoViewController *infoViewController;
@property (nonatomic, strong) TSFUserQuestionnaireAssessorsViewController *assessorsViewController;
@end
