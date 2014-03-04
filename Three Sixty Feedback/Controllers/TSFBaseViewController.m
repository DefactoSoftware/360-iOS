//
//  TSFBaseViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFBaseViewController.h"
#import "UIColor+TSFColor.h"

@interface TSFBaseViewController()
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@end

@implementation TSFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self paint];

    [self addProgressView];
}

- (void)paint {
    self.navigationController.navigationBar.barTintColor = [UIColor TSFBlueColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes =  @{ NSForegroundColorAttributeName : [UIColor whiteColor] };
    [self.view setBackgroundColor:[UIColor TSFBeigeColor]];
}

- (void)viewDidLayoutSubviews {
    self.progressView.frame = [self progressViewFrame];
}

- (void)addResignGestureRecognizer {
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(dismissKeyboard:)];
    [self.tapRecognizer setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:self.tapRecognizer];
}

- (void)dismissKeyboard:(id)sender {
    [self.view endEditing:YES];
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

- (IBAction)openMenu:(id)sender {
    [self.sideMenuViewController presentMenuViewController];
}

- (void)rewindFromModal:(UIStoryboardSegue *)unwindSegue {
    
}

@end
