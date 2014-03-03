//
//  TSFTemplateViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFBaseViewController.h"
#import "TSFButton.h"

@interface TSFTemplateViewController : TSFBaseViewController

@property (weak, nonatomic) IBOutlet UITableView *templateTableView;
@property (weak, nonatomic) IBOutlet TSFButton *closeButton;

@end
