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
	[self loadQuestionnaire];
}

- (void)loadQuestionnaire {
	__block typeof(self) _self = self;
    
	[self.questionnaireService questionnairesWithSuccess: ^(TSFQuestionnaire *questionnaire) {
	    _self.questionnaire = questionnaire;
	} failure: ^(NSError *error) {
	    NSLog(@"Error loading questionnaires. Userinfo: %@. Error: %@", error.userInfo, error.localizedDescription);
	}];
}

@end
