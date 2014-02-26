//
//  TSFAssessorCell.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFAssessor.h"

@interface TSFAssessorCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *remindedAtLabel;
@property (weak, nonatomic) IBOutlet UIImageView *completedImageView;

- (CGFloat)calculatedHeight;
- (void)displayAssessor:(TSFAssessor *)assessor;

@end
