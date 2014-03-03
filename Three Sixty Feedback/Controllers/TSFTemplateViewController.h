//
//  TSFTemplateViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFBaseViewController.h"
#import "TSFButton.h"
#import "TSFQuestionnaire.h"

@interface TSFTemplateViewController : TSFBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *templateTableView;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet TSFButton *closeButton;
@property (nonatomic, strong) TSFQuestionnaire *questionnaire;

@end
