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
#import "CRToast.h"
#import "UIColor+TSFColor.h"

static NSString *const TSFMenuCellIdentifier = @"TSFMenuCell";
static NSString *const TSFMenuLogoutIdentifier = @"TSFLoginViewControllerNavigation";
static NSInteger const TSFMenuLogoutCellIndex = 2;

@interface TSFMenuViewController()
@property (nonatomic, strong) NSArray *items;
@end

@implementation TSFMenuViewController

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
    self.sessionService = [TSFSessionService sharedService];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.menuTableView.dataSource = self;
    self.menuTableView.delegate = self;
    
    self.menuTableView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [self initializeMenuItems];
}

- (void)initializeMenuItems {
    self.items = @[
                   @[ TSFLocalizedString(@"TSFMenuItemQuestionnaires", @"Questionnaires"),
                      @"TSFQuestionnairesViewControllerNavigation" ],
                   @[ TSFLocalizedString(@"TSFMenuItemNewQuestionnaire", @"Create a new questionnaire"), @"TSFNewQuestionnaireViewControllerNavigation" ],
                   @[ TSFLocalizedString(@"TSFMenuItemLogout", @"Logout"),
                      @"TSFLoginViewControllerNavigation" ]
                   ];
    
    self.menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.menuTableView reloadData];
}

- (void)logout {
    __weak typeof (self) _self = self;
    [self.sessionService deleteCurrentSessionWithSuccess:^(id response) {
        UIViewController *loginViewController = [_self.storyboard instantiateViewControllerWithIdentifier:TSFMenuLogoutIdentifier];
        [_self.sideMenuViewController setContentViewController:loginViewController];
        [_self.sideMenuViewController hideMenuViewController];
        _self.sideMenuViewController.panGestureEnabled = NO;
    } failure:^(NSError *error) {
        NSDictionary *options = @{kCRToastTextKey : TSFLocalizedString(@"TSFMenuViewControllerLogoutError", @"Failed logging out."),
                                  kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                  kCRToastBackgroundColorKey : [UIColor TSFErrorColor]};
        [CRToastManager showNotificationWithOptions:options completionBlock:^{ }];
        NSLog(@"Error deleting current session: %@.", error);
    }];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSFMenuCell *menuCell = [self.menuTableView dequeueReusableCellWithIdentifier:TSFMenuCellIdentifier];
    if (!menuCell) {
        menuCell= [[TSFMenuCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:TSFMenuCellIdentifier];
    }
    menuCell.titleLabel.text = self.items[indexPath.row][0];
    menuCell.titleLabel.textColor = [UIColor whiteColor];
    return menuCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 80.f : 50.f;
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
    if (indexPath.row == TSFMenuLogoutCellIndex) {
        [self logout];
        return;
    }
    
    NSArray *item = self.items[indexPath.row];
    NSString *viewControllerIdentifier = item[1];
    
    UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:viewControllerIdentifier];
    self.sideMenuViewController.panGestureEnabled = YES;
    [self.sideMenuViewController setContentViewController:newViewController];
    [self.sideMenuViewController hideMenuViewController];
}

@end