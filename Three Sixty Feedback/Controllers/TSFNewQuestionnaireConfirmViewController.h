//
//  TSFNewQuestionnaireConfirmViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 04-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFTemplate.h"

@interface TSFNewQuestionnaireConfirmViewController : UIViewController
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) TSFTemplate *questionnaireTemplate;
@property (nonatomic, strong) NSArray *assessors;
@end
