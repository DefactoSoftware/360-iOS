//
//  TSFTemplateViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFBaseViewController.h"
#import "TSFButton.h"
#import "TSFTemplate.h"

@interface TSFTemplateViewController : TSFBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (weak, nonatomic) IBOutlet UITableView *templateTableView;
@property (nonatomic, strong) TSFTemplate *questionnaireTemplate;

@end
