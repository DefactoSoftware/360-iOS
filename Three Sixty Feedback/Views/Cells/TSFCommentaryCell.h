//
//  TSFCommentaryCell.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 12-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSFCommentaryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end
