//
//  TSFNewQuestionnaireAssessorsViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 04-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFNewQuestionnaireAssessorsViewController.h"
#import "TSFNewQuestionnaireConfirmViewController.h"
#import "TSFGenerics.h"
#import "UIColor+TSFColor.h"
#import "UITextField+Shake.h"
#import "TSFAddAssessorCell.h"

static NSString *const TSFNewAssessorCellIdentifier = @"TSFAddAssessorCell";
static NSString *const TSFNewQuestionnaireConfirmSegue = @"TSFNewQuestionnaireConfirmSegue";
static NSInteger const TSFNewAssessorsTableViewHorizontalInset = 106.0f;

@interface TSFNewQuestionnaireAssessorsViewController()
@property (nonatomic, strong) NSMutableArray *assessors;
@end

@implementation TSFNewQuestionnaireAssessorsViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self sharedSetup];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        [self sharedSetup];
    }
    return self;
}

- (void)sharedSetup {
    _assessors = [[NSMutableArray alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = TSFLocalizedString(@"TSFNewQuestionnaireAssessorsViewControllerTitle", @"Invite assessors");
    self.addAssessorTitleLabel.text = TSFLocalizedString(@"TSFNewQuestionnaireAssessorsViewControllerTitle", @"Add the email addresses of assessors you would like to invite to this feedback evaluation.");
    
    self.assessorsTableView.delegate = self;
    self.assessorsTableView.dataSource = self;
    self.addAssessorTextField.delegate = self;
    
    [self.addButton setIconImage:[UIImage imageNamed:@"add"]];
    self.addAssessorTitleLabel.textColor = [UIColor TSFLightGreyTextColor];
    
    self.assessorsTableView.separatorInset = UIEdgeInsetsMake(0.0f, TSFNewAssessorsTableViewHorizontalInset, 0.0f, TSFNewAssessorsTableViewHorizontalInset);
    
    [self.nextButton setTitle:TSFLocalizedString(@"TSFNewQuestionnaireAssessorsViewControllerNext", @"Check information")
                     forState:UIControlStateNormal];
    [self.nextButton setIconImage:[UIImage imageNamed:@"forward"]];
    
    [self.importButton setTitle:TSFLocalizedString(@"TSFNewQuestionnaireAssessorsViewControllerImport", @"Import")
                       forState:UIControlStateNormal];
    
    [self addResignGestureRecognizer];
    [self updateHeaderViewHeight];
}

- (BOOL) stringIsEmail:(NSString *)string {
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:string];
}

- (void)insertAssessor:(NSString *)assessor {
    [self.assessors insertObject:assessor
                         atIndex:0];
    NSArray *indexArray = @[ [NSIndexPath indexPathForItem:0 inSection:0] ];
    [self.assessorsTableView insertRowsAtIndexPaths:indexArray
                                   withRowAnimation:UITableViewRowAnimationTop];
    [self.addAssessorTextField setText:@""];
}

- (IBAction)addButtonPressed:(id)sender {
    NSString *newAssessor = self.addAssessorTextField.text;
    if ([self stringIsEmail:newAssessor]) {
        [self insertAssessor:newAssessor];
    } else {
        [self.addAssessorTextField shake:5
                               withDelta:10];
    }
}

- (IBAction)removeButtonPressed:(TSFButton *)sender {
    NSInteger index = [self.assessors indexOfObject:sender.stringTag];
    [self.assessors removeObjectAtIndex:index];
        NSArray *indexPaths = @[ [NSIndexPath indexPathForRow:index inSection:0] ];
    [self.assessorsTableView deleteRowsAtIndexPaths:indexPaths
                                   withRowAnimation:UITableViewRowAnimationRight];
}

- (IBAction)nextButtonPressed:(id)sender {
    if (![self.assessors count]) {
        [self.addAssessorTextField shake:5
                               withDelta:10.0f
                                andSpeed:0.05];
    } else {
        [self performSegueWithIdentifier:TSFNewQuestionnaireConfirmSegue
                                  sender:self];
    }
}

- (IBAction)showAddressPicker:(id)sender {
    ABPeoplePickerNavigationController *peoplePickerController = [[ABPeoplePickerNavigationController alloc] init];
    peoplePickerController.peoplePickerDelegate = self;
    peoplePickerController.displayedProperties = @[@(kABPersonEmailProperty)];
    [self presentViewController:peoplePickerController
                       animated:YES
                     completion:nil];
}

- (void)updateHeaderViewHeight {
    CGFloat textFontSize;
    CGFloat textWidth;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        textWidth = 728.0f;
        textFontSize  = 14.0f;
    } else {
        textWidth = 280.0f;
        textFontSize = 13.0f;
    }
    
    CGFloat buttonHeight = 40.0f;
    CGFloat textFieldHeight = 40.0f;
    CGFloat margin = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 212.0f : 60.0f;
    
    CGSize constraint = CGSizeMake(textWidth, 20000.0f);
    CGSize titleSize = CGSizeMake(0, 0);
    
    titleSize = [self.addAssessorTextField.text boundingRectWithSize:constraint
                                                             options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                          attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:textFontSize]}
                                                             context:nil].size;
    
    CGFloat headerViewHeight = titleSize.height + buttonHeight + textFieldHeight + margin;
    
    CGRect headerViewFrame = self.headerView.frame;
    headerViewFrame.size.height = headerViewHeight;
    self.headerView.frame = headerViewFrame;
}

#pragma mark - ABPeoplePickerNavigationController

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    ABMultiValueRef emailReference = ABRecordCopyValue(person, kABPersonEmailProperty);
    CFIndex emailCount = ABMultiValueGetCount(emailReference);
    if (emailCount < 2) {
        CFStringRef emailString = ABMultiValueCopyValueAtIndex(emailReference, 0);
        [self insertAssessor:(__bridge NSString *)emailString];
        [self dismissViewControllerAnimated:YES
                                 completion:nil];
    }
    
    return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier {
    ABMultiValueRef emailReference = ABRecordCopyValue(person, kABPersonEmailProperty);
    CFStringRef emailString = ABMultiValueCopyValueAtIndex(emailReference, identifier);
    [self insertAssessor:(__bridge NSString *)emailString];
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    return YES;
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}


#pragma mark - UITextField

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self addButtonPressed:nil];
    return YES;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender {
    TSFNewQuestionnaireConfirmViewController *destinationViewController = segue.destinationViewController;
    destinationViewController.subject = self.subject;
    destinationViewController.questionnaireTemplate = self.questionnaireTemplate;
    destinationViewController.assessors = self.assessors;
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.assessors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSFAddAssessorCell *cell = [self.assessorsTableView dequeueReusableCellWithIdentifier:TSFNewAssessorCellIdentifier
                                                                             forIndexPath:indexPath];
    if (!cell) {
        cell = [[TSFAddAssessorCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:TSFNewAssessorCellIdentifier];
        
    }
    
    NSString *assessor = self.assessors[indexPath.row];
    cell.emailLabel.text = assessor;
    cell.backgroundColor = [UIColor clearColor];
    cell.removeButton.stringTag = assessor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

@end
