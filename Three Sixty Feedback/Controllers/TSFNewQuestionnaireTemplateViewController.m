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
@property (nonatomic, strong) TSFTemplate *selectedTemplate;
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
    self.templateService = [TSFTemplateService sharedService];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchTemplates];
    
    self.templatesTableView.dataSource = self;
    self.templatesTableView.delegate = self;
    
    self.templatesTableView.separatorInset = UIEdgeInsetsMake(0, 15.0f, 0, 15.0f);
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

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender {
    if ([segue.identifier isEqualToString:TSFNewTemplateModalSegue]) {
        TSFTemplateViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.questionnaireTemplate = self.previewTemplate;
    } else if ([segue.identifier isEqualToString:TSFNewQuestionnaireAssessorsSegue]) {
        TSFNewQuestionnaireAssessorsViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.subject = self.subject;
        destinationViewController.questionnaireTemplate = self.selectedTemplate;
    }
}

#pragma mark - UITableVIew

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
    templateCell.backgroundColor = [UIColor TSFBeigeColor];
    templateCell.showTemplateButton.tag = indexPath.row;
    templateCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return templateCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat titleFontSize;
    CGFloat descriptionFontSize;
    CGFloat buttonHeight;
    CGFloat textWidth;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        textWidth = 567.0f;
        titleFontSize  = 14.0f;
        descriptionFontSize = 12.0f;
        buttonHeight = 0.0f;
    } else {
        textWidth = 275.0f;
        titleFontSize = 13.0f;
        descriptionFontSize = 11.0f;
        buttonHeight = 30.0f;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedTemplate = self.templates[indexPath.row];
    [self performSegueWithIdentifier:TSFNewQuestionnaireAssessorsSegue
                              sender:self];
}

@end
