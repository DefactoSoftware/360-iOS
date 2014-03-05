//
//  TSFTemplateCell.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFTemplateCell.h"
#import "TSFGenerics.h"
#import "UIColor+TSFColor.h"

@implementation TSFTemplateCell

- (void)layoutSubviews {
    [super layoutSubviews];
    NSString *templateTitle = TSFLocalizedString(@"TSFTemplateCellShowTemplate", @"Preview questions");
    [self.showTemplateButton setTitle:templateTitle forState:UIControlStateNormal];
    [self.showTemplateButton setIconImage:[UIImage imageNamed:@"clipboard"]];
    
    self.backgroundColor = [UIColor TSFBeigeColor];
}

@end
