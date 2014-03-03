//
//  TSFNewQuestionnaireSubjectViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFBaseViewController.h"

@interface TSFNewQuestionnaireSubjectViewController : TSFBaseViewController

@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UITextField *subjectTextField;

- (BOOL)validate;

@end
