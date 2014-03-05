//
//  TSFTemplateNavigationController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 05-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFBaseViewController.h"
#import "TSFTemplate.h"

@interface TSFTemplateNavigationController : UINavigationController
@property (nonatomic, strong) TSFTemplate *questionnaireTemplate;
@end
