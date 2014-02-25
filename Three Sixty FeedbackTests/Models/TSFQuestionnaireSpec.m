//
//  TSFQuestionnaireSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFQuestionnaire.h"

SPEC_BEGIN(TSFQuestionnaireSpec)

describe(@"TSFQuestionnaire", ^{
    __block TSFQuestionnaire *_questionnaire;
    
    beforeEach(^{
        _questionnaire = [[TSFQuestionnaire alloc] init];
    });

    context(@"with assessors", ^{
        __block TSFAssessor *_assessorOne;
        __block TSFAssessor *_assessorTwo;
        
        beforeEach(^{
            _assessorOne = [[TSFAssessor alloc] init];
            _assessorTwo = [[TSFAssessor alloc] init];
            _questionnaire.assessors = @[ _assessorOne, _assessorTwo ];
        });
        
        it(@"returns the number completed assessors", ^{
            [[theValue([_questionnaire completedAssessors]) should] equal:theValue(0)];
            ((TSFAssessor *) [_questionnaire.assessors firstObject]).completed = YES;
            [[theValue([_questionnaire completedAssessors]) should] equal:theValue(1)];
        });
    });
    
});

SPEC_END