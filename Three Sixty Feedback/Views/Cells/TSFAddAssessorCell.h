//
//  TSFAddAssessorCell.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 04-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFButton.h"

@interface TSFAddAssessorCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet TSFButton *removeButton;

@end
