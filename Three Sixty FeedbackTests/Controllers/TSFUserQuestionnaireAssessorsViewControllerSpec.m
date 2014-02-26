//
//  TSFUserQuestionnaireAssessorsViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFUserQuestionnaireAssessorsViewController.h"
#import "TSFUserQuestionnaireTabBarController.h"

SPEC_BEGIN(TSFUserQuestionnaireAssessorViewControllerSpec)

describe(@"TSFUserQuestionnaireAssessorsViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFUserQuestionnaireTabBarController *_userQuestionnaireViewController;
    __block TSFUserQuestionnaireAssessorsViewController *_userQuestionnaireAssessorsViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _userQuestionnaireViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFUserQuestionnaireTabBarController"];
        _userQuestionnaireAssessorsViewController = [_userQuestionnaireViewController.viewControllers lastObject];
        [[[_userQuestionnaireViewController view] shouldNot] beNil];
        [[[_userQuestionnaireAssessorsViewController view] shouldNot] beNil];
    });
    
    it(@"has an outlet for the assessors tableview", ^{
        [[_userQuestionnaireAssessorsViewController.assessorsTableView shouldNot] beNil];
    });
    
    it(@"has a reference to the assessor service", ^{
        [[[_userQuestionnaireAssessorsViewController.assessorService class] should] equal:[TSFAssessorService class]];
    });
    
    context(@"with assessors", ^{
        __block id _mockAssessorService;
        __block TSFQuestionnaire *_questionnaire;
        __block NSArray *_assessors;
        __block TSFAssessor *_assessor;
        __block TSFAssessor *_assessorTwo;
        
        beforeEach(^{
            _mockAssessorService = [KWMock mockForClass:[TSFAssessorService class]];
            _userQuestionnaireAssessorsViewController.assessorService = _mockAssessorService;
            
            _questionnaire = [[TSFQuestionnaire alloc] init];
            _assessor = [[TSFAssessor alloc] init];
            _assessor.completed = NO;
            _assessor.assessorId = @(arc4random());
            _assessorTwo = [[TSFAssessor alloc] init];
            _assessorTwo.assessorId = @(arc4random());
            
            _assessorTwo.completed = NO;
            _assessors = @[ _assessor, _assessorTwo ];
            
            TSFQuestionnaire *questionnaire = [[TSFQuestionnaire alloc] init];
            questionnaire.assessors = _assessors;
            
            _userQuestionnaireAssessorsViewController.questionnaire = questionnaire;
        });
        
        it(@"calls the assessor service to remind every uncompleted assessor", ^{
            [[_mockAssessorService should] receive:@selector(remindAssessorWithId:success:failure:)
                                     withArguments:_assessor.assessorId, [KWAny any], [KWAny any]];
            [[_mockAssessorService should] receive:@selector(remindAssessorWithId:success:failure:)
                                     withArguments:_assessorTwo.assessorId, [KWAny any], [KWAny any]];
            
            [_userQuestionnaireAssessorsViewController remindAssessors];
        });
        
        it(@"only reminds the incompleted assessors", ^{
            _assessorTwo.completed = YES;
            _questionnaire.assessors = @[ _assessor, _assessorTwo ];
            _userQuestionnaireAssessorsViewController.questionnaire = _questionnaire;
            
            [[_mockAssessorService should] receive:@selector(remindAssessorWithId:success:failure:)
                                     withArguments:_assessor.assessorId, [KWAny any], [KWAny any]];
            
            [_userQuestionnaireAssessorsViewController remindAssessors];
        });
    });
});

SPEC_END