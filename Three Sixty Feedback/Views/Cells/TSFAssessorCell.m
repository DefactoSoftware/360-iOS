//
//  TSFAssessorCell.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFAssessorCell.h"
#import "TSFGenerics.h"
#import "NSDate+StringParsing.h"
#import "UIColor+TSFColor.h"

static NSString *const TSFCompletedImageName = @"checkmark-green";
static NSString *const TSFNotCompletedImageName = @"cross-red";

@interface TSFAssessorCell()
@property (nonatomic, strong) TSFAssessor *assessor;
@end

@implementation TSFAssessorCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.emailLabel.textColor = [UIColor TSFBlackColor];
    self.remindedAtLabel.textColor = [UIColor TSFLightGreyTextColor];
}

- (NSString *)remindedAtString:(NSDate *)remindedAt {
    NSString *remindedAtFormat = TSFLocalizedString(@"TSFUserQuestionnaireAssessorsViewControllerRemindedAt", @"Last reminded at %@");
    return [NSString stringWithFormat:remindedAtFormat, [NSDate stringFromDate:remindedAt]];
}

- (void)displayAssessor:(TSFAssessor *)assessor {
    self.assessor = assessor;
    self.emailLabel.text = assessor.email;
    
    if (assessor.completed) {
        self.completedImageView.image = [UIImage imageNamed:TSFCompletedImageName];
    } else {
        self.completedImageView.image = [UIImage imageNamed:TSFNotCompletedImageName];
    }
    
    self.completedImageView.alpha = 0.3f;
    
    if (assessor.lastRemindedAt) {
        self.remindedAtLabel.text = [self remindedAtString:assessor.lastRemindedAt];
    }
}

- (CGFloat)calculatedHeight {
    CGFloat textFontSize;
    CGFloat textWidth;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        textWidth = 728.0f;
        textFontSize  = 10.0f;
    } else {
        textWidth = 280.0f;
        textFontSize = 13.0f;
    }
    
    CGFloat margin = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 35.0f : 30.0f;
    
    CGSize constraint = CGSizeMake(textWidth, 20000.0f);
    CGSize emailSize = CGSizeMake(0, 0);
    CGSize remindedAtSize = CGSizeMake(0, 0);
    
    emailSize = [self.assessor.email boundingRectWithSize:constraint
                                             options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                          attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:textFontSize]}
                                             context:nil].size;
    
    if (self.assessor.lastRemindedAt) {
        remindedAtSize = [[self remindedAtString:self.assessor.lastRemindedAt] boundingRectWithSize:constraint
                                                        options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:textFontSize]}
                                                        context:nil].size;
    }
    return emailSize.height + remindedAtSize.height + margin;
}

@end
