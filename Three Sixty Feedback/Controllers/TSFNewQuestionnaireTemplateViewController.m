//
//  TSFNewQuestionnaireTemplateViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFNewQuestionnaireTemplateViewController.h"
#import "TSFNewQuestionnaireAssessorsViewController.h"
#import "TSFTemplateViewController.h"
#import "CRToast.h"
#import "UIColor+TSFColor.h"
#import "TSFGenerics.h"
#import "TSFTemplateCell.h"

static NSString *const TSFTemplateCellIdentifier = @"TSFTemplateCell";
static NSString *const TSFNewTemplateModalSegue = @"TSFNewTemplateModalSegue";
static NSString *const TSFNewQuestionnaireAssessorsSegue = @"TSFNewQuestionnaireAssessorsSegue";

@interface TSFNewQuestionnaireTemplateViewController()
@property (nonatomic, strong) NSArray *templates;
@property (nonatomic, assign) TSFTemplate *previewTemplate;
@end

@implementation TSFNewQuestionnaireTemplateViewController

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
    _templateService = [TSFTemplateService sharedService];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchTemplates];
    
    self.templatesTableView.dataSource = self;
    self.templatesTableView.delegate = self;
    
    self.templatesTableView.separatorInset = UIEdgeInsetsMake(0, 15.0f, 0, 15.0f);
    
    self.navigationItem.title = TSFLocalizedString(@"TSFNewQuestionnaireTemplateViewControllerTitle", @"Choose questions");
    
    [self.nextButton setTitle:TSFLocalizedString(@"TSFNewQuestionnaireTeplateViewControllerNext", @"Invite assessors")
                     forState:UIControlStateNormal];
    [self.nextButton setIconImage:[UIImage imageNamed:@"forward"]];
}

- (void)fetchTemplates {
    __weak typeof (self) _self = self;
    [self.templateService templatesWithSuccess:^(NSArray *templates) {
        _self.templates = templates;
        [_self.templatesTableView reloadData];
    } failure:^(NSError *error) {
        NSDictionary *options = @{kCRToastTextKey : TSFLocalizedString(@"TSFNewQuestionnaireTemplateViewControllerError", @"Could not get templates"),
                                  kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                  kCRToastBackgroundColorKey : [UIColor TSFErrorColor]};
        [CRToastManager showNotificationWithOptions:options completionBlock:^{ }];
    }];
}

- (BOOL)validate {
    return YES;
}

- (void)showTemplateButtonPressed:(TSFButton *)sender {
    NSInteger rowNumber = sender.tag;
    TSFTemplate *template = self.templates[rowNumber];
    self.previewTemplate = template;
    [self performSegueWithIdentifier:TSFNewTemplateModalSegue
                              sender:self];
}

- (IBAction)goToNextStep:(id)sender {
    if ([self.templatesTableView indexPathForSelectedRow]) {
        [self performSegueWithIdentifier:TSFNewQuestionnaireAssessorsSegue
                                  sender:self];
    } else {
        NSDictionary *options = @{kCRToastTextKey : TSFLocalizedString(@"TSFNewQuestionnaireTemplateViewControllerNoSelectedError", @"Please choose a question template"),
                                  kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                  kCRToastBackgroundColorKey : [UIColor TSFErrorColor]};
        [CRToastManager showNotificationWithOptions:options completionBlock:^{ }];

    }
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender {
    if ([segue.identifier isEqualToString:TSFNewTemplateModalSegue]) {
        TSFTemplateViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.questionnaireTemplate = self.previewTemplate;
    } else if ([segue.identifier isEqualToString:TSFNewQuestionnaireAssessorsSegue]) {
        TSFNewQuestionnaireAssessorsViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.subject = self.subject;
        NSIndexPath *selectedIndexPath = [self.templatesTableView indexPathForSelectedRow];
        destinationViewController.questionnaireTemplate = self.templates[selectedIndexPath.row];
    }
}

#pragma mark - UITableVIew

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.templates count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSFTemplateCell *templateCell = [self.templatesTableView dequeueReusableCellWithIdentifier:TSFTemplateCellIdentifier];
    if (!templateCell) {
        templateCell = [[TSFTemplateCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:TSFTemplateCellIdentifier];
    }
    TSFTemplate *template = self.templates[indexPath.row];
    templateCell.titleLabel.text = template.title;
    templateCell.descriptionLabel.text = template.templateDescription;
    templateCell.showTemplateButton.tag = indexPath.row;
    
    CGFloat tableRowHeight = [self tableView:tableView
                     heightForRowAtIndexPath:indexPath];
    UIView *selectedView = [[UIView alloc] initWithFrame:templateCell.frame];
    
    CGRect padRect = CGRectMake(20.0f, (tableRowHeight / 2) - 10.0f, 20.0f, 20.0f);
    CGRect phoneRect = CGRectMake(self.view.frame.size.width - 40.0f, 20.0f, 20.0f, 20.0f);
    CGRect rect = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? padRect : phoneRect;
    
    UIImageView *checkMarkImage = [[UIImageView alloc] initWithFrame:rect];
    checkMarkImage.image = [UIImage imageNamed:@"checkmark-dark"];
    [selectedView addSubview:checkMarkImage];
    selectedView.backgroundColor = [UIColor TSFLightBlueColor];
    templateCell.selectedBackgroundView = selectedView;
    
    return templateCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat titleFontSize;
    CGFloat descriptionFontSize;
    CGFloat buttonHeight;
    CGFloat textWidth;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        textWidth = 515.0f;
        titleFontSize  = 17.0f;
        descriptionFontSize = 14.0f;
        buttonHeight = 0.0f;
    } else {
        textWidth = 275.0f;
        titleFontSize = 13.0f;
        descriptionFontSize = 11.0f;
        buttonHeight = 40.0f;
    }
    
    CGFloat margin = 60.0f;
    CGSize constraint = CGSizeMake(textWidth, 20000.0f);
    
    TSFTemplate *template = self.templates[indexPath.row];
    
    CGSize titleSize = [template.title boundingRectWithSize:constraint
                                                    options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                 attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:titleFontSize]}
                                                    context:nil].size;
    
    CGSize descriptionSize = [template.templateDescription boundingRectWithSize:constraint
                                                                        options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:descriptionFontSize]}
                                                                        context:nil].size;

    return titleSize.height + descriptionSize.height + buttonHeight + margin;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

@end
