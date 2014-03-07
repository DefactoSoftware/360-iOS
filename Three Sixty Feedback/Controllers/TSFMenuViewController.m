//
//  TSFMenuViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFMenuViewController.h"
#import "TSFAppDelegate.h"
#import "TSFGenerics.h"
#import "TSFMenuCell.h"

static NSString *const TSFMenuCellIdentifier = @"TSFMenuCell";

@interface TSFMenuViewController()
@property (nonatomic, strong) NSArray *items;
@end

@implementation TSFMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.menuTableView.dataSource = self;
    self.menuTableView.delegate = self;
    self.menuTableView.backgroundColor = [UIColor clearColor];
    
    [self.closeButton setIconImage:[UIImage imageNamed:@"cross-1"]];
    [self.closeButton setIconX:8.0f];
    [self initializeMenuItems];
}

- (void)initializeMenuItems {
    self.items = @[
                   @[ TSFLocalizedString(@"TSFMenuItemQuestionnaires", @"Questionnaires"), @"TSFQuestionnairesViewControllerNavigation" ],
                   @[ TSFLocalizedString(@"TSFMenuItemNewQuestionnaire", @"Create new questionnaire"), @"TSFNewQuestionnaireViewControllerNavigation" ]
                   ];
    
    self.menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.menuTableView reloadData];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSFMenuCell *menuCell = [self.menuTableView dequeueReusableCellWithIdentifier:TSFMenuCellIdentifier];
    if (!menuCell) {
        menuCell= [[TSFMenuCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:TSFMenuCellIdentifier];
    }
    menuCell.titleLabel.text = self.items[indexPath.row][0];
    return menuCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat contentHeight = 0.0;
    for (int row = 0; row < [self tableView:tableView numberOfRowsInSection:0]; row++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        contentHeight += [self tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return (tableView.bounds.size.height - contentHeight) / 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *item = self.items[indexPath.row];
    NSString *viewControllerIdentifier = item[1];
    
    UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:viewControllerIdentifier];
    [self.contentViewControlller.rootViewController setNewContentViewController:newViewController];
    [self dismissViewControllerAnimated:YES
                             completion:^{}];
}

@end