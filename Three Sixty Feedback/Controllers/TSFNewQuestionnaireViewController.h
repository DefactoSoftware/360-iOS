//
//  TSFNewQuestionnaireViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFBaseViewController.h"
#import "TSFNewQuestionnaireSubjectViewController.h"

@interface TSFNewQuestionnaireViewController : TSFBaseViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) UIPageViewController *pageViewController;

@end
