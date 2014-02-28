//
//  TSFQuestionnaireCell.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 24-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSFQuestionnaireCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *assessorsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pointerImageView;
@property (weak, nonatomic) IBOutlet UIView *colorView;

- (void)select;
- (void)unselect;

@end