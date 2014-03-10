//
//  TSFMenuViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "TSFSessionService.h"

@interface TSFMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (nonatomic, strong) TSFSessionService *sessionService;

- (void)logout;

@end