//
//  TSFTemplateViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFTemplateViewController.h"
#import "TSFGenerics.h"
#import "UIColor+TSFColor.h"

static NSString *const TSFTemplateCompetenceCellIdentifier = @"TSFTemplateCompetenceCell";

@implementation TSFTemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.templateTableView.dataSource = self;
    self.templateTableView.delegate = self;
    self.templateTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.templateTableView.backgroundColor = [UIColor TSFBeigeColor];
    
    NSString *closeButtonTitle = TSFLocalizedString(@"TSFTemplateViewControllerCloseButton", @"Close");
    [self.closeButton setTitle:closeButtonTitle forState:UIControlStateNormal];
    
    NSString *headerFormat = TSFLocalizedString(@"TSFTemplateViewControllerHeaderFormat", @"%@ questions");
    self.headerLabel.text = [NSString stringWithFormat:headerFormat, self.questionnaire.title];
    self.headerLabel.textColor = [UIColor TSFLightGreyTextColor];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.questionnaire.competences count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    TSFCompetence *competence = self.questionnaire.competences[section];
    return competence.title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.templateTableView dequeueReusableCellWithIdentifier:TSFTemplateCompetenceCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    
    TSFCompetence *competence = self.questionnaire.competences[indexPath.section];
    TSFKeyBehaviour *keyBehaviour = competence.keyBehaviours[indexPath.row];
    
    cell.textLabel.text = keyBehaviour.keyBehaviourDescription;
    cell.textLabel.textColor = [UIColor TSFLightGreyTextColor];
    CGFloat fontSize = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 15.0f : 13.0f;
    cell.textLabel.font = [UIFont systemFontOfSize:fontSize];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.numberOfLines = 0;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TSFCompetence *competence = self.questionnaire.competences[section];
    return [competence.keyBehaviours count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat textFontSize;
    CGFloat textWidth;
    CGFloat margin;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        textWidth = 728.0f;
        textFontSize  = 15.0f;
        margin = 35.0f;
    } else {
        textWidth = 280.0f;
        textFontSize = 13.0f;
        margin = 20.0f;
    }
    
    CGSize constraint = CGSizeMake(textWidth, 20000.0f);
    CGSize titleSize = CGSizeMake(0, 0);
    
    
    TSFKeyBehaviour *keyBehaviour = ((TSFCompetence *)self.questionnaire.competences[indexPath.section]).keyBehaviours[indexPath.row];
    titleSize = [keyBehaviour.keyBehaviourDescription boundingRectWithSize:constraint
                                                                   options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                                attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:textFontSize]}
                                                                   context:nil].size;

    return titleSize.height + margin;
}

@end
