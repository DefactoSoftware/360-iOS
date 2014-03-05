//
//  TSFNewQuestionnaireAssessorsViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 04-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFBaseViewController.h"
#import "TSFTemplate.h"
#import "TSFButton.h"
#import <AddressBookUI/AddressBookUI.h>

@interface TSFNewQuestionnaireAssessorsViewController : TSFBaseViewController <ABPeoplePickerNavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *assessorsTableView;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) TSFTemplate *questionnaireTemplate;
@property (weak, nonatomic) IBOutlet UILabel *addAssessorTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *addAssessorTextField;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet TSFButton *addButton;
@property (weak, nonatomic) IBOutlet TSFButton *nextButton;

- (IBAction)addButtonPressed:(id)sender;
- (IBAction)removeButtonPressed:(id)sender;
- (IBAction)nextButtonPressed:(id)sender;
- (IBAction)showAddressPicker:(id)sender;

@end
