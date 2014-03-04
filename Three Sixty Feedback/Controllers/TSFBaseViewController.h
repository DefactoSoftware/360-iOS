//
//  TSFBaseViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface TSFBaseViewController : UIViewController

@property (nonatomic, strong) UIProgressView *progressView;

- (IBAction)openMenu:(id)sender;
- (IBAction)rewindFromModal:(UIStoryboardSegue *)unwindSegue;

@end
