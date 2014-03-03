//
//  TSFNewQuestionnaireTemplateViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFBaseViewController.h"
#import "TSFTemplateService.h"

@interface TSFNewQuestionnaireTemplateViewController : TSFBaseViewController

@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) TSFTemplateService *templateService;

- (BOOL)validate;

@end
