//
//  TSFKeyBehaviourCell.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 31-01-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFKeyBehaviour.h"
#import "TSFKeyBehaviourRatingView.h"

@interface TSFKeyBehaviourCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet TSFKeyBehaviourRatingView *keyBehaviourRatingView;

@end
