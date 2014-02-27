//
//  TSFBaseViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFBaseViewController.h"
#import "UIColor+TSFColor.h"

@implementation TSFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self paint];

    [self addProgressView];
}

- (void)paint {
    self.navigationController.navigationBar.barTintColor = [UIColor TSFBlueColor];
    self.navigationController.navigationBar.titleTextAttributes =  @{ NSForegroundColorAttributeName : [UIColor whiteColor] };
    [self.view setBackgroundColor:[UIColor TSFBeigeColor]];
}

- (void)viewDidLayoutSubviews {
    self.progressView.frame = [self progressViewFrame];
}

- (void)addProgressView {
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    
    self.progressView.frame = [self progressViewFrame];
    
    self.progressView.progress = 0;
    self.progressView.progressTintColor = [UIColor TSFOrangeColor];
    self.progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.progressView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    [self.navigationController.navigationBar addSubview:self.progressView];
}

- (CGRect)progressViewFrame {
    return CGRectMake(0,
                      self.navigationController.navigationBar.frame.size.height - self.progressView.frame.size.height,
                      self.navigationController.navigationBar.frame.size.width,
                      self.progressView.frame.size.height);
}

- (void)updateProgressViewFrame {
    self.progressView.frame = [self progressViewFrame];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self updateProgressViewFrame];
}

@end
