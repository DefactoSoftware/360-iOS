//
//  TSFQuestionnaireViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis on 30/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFQuestionnaireViewController.h"

@implementation TSFQuestionnaireViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		_questionnaireService = [TSFQuestionnaireService sharedService];
	}
	return self;
}

- (void)viewDidLoad {
}

@end
