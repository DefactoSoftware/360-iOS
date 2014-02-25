//
//  TSFUserQuestionnaireViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFQUestionnaire.h"

@interface TSFUserQuestionnaireViewController : UITabBarController
@property (nonatomic, strong) TSFQuestionnaire *questionnaire;
@end
