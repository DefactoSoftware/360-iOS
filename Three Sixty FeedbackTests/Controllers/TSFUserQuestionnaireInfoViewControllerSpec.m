//
//  TSFUserQuestionnaireInfoViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFUserQuestionnaireInfoViewController.h"
#import "TSFUserQuestionnaireTabBarController.h"

SPEC_BEGIN(TSFUserQuestionnaireInfoViewControllerSpec)

describe(@"TSFUserQuestionnaireInfoViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFUserQuestionnaireTabBarController *_userQuestionnaireViewController;
    __block TSFUserQuestionnaireInfoViewController *_userQuestionnaireInfoViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _userQuestionnaireViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFUserQuestionnaireTabBarController"];
        _userQuestionnaireInfoViewController = [_userQuestionnaireViewController.viewControllers firstObject];
        [[[_userQuestionnaireViewController view] shouldNot] beNil];
        [[[_userQuestionnaireInfoViewController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"has an outlet for the title label", ^{
            [[_userQuestionnaireInfoViewController.titleLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the subject label", ^{
            [[_userQuestionnaireInfoViewController.subjectLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the description label", ^{
            [[_userQuestionnaireInfoViewController.descriptionLabel shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFUserQuestionnaireTabBarController *_userQuestionnaireViewController;
        __block TSFUserQuestionnaireInfoViewController *_userQuestionnaireInfoViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _userQuestionnaireViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFUserQuestionnaireTabBarController"];
            _userQuestionnaireInfoViewController = [_userQuestionnaireViewController.viewControllers firstObject];
            [[[_userQuestionnaireViewController view] shouldNot] beNil];
            [[[_userQuestionnaireInfoViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[[_userQuestionnaireViewController.viewControllers firstObject] shouldNot] beNil];
            [[[_userQuestionnaireViewController.viewControllers firstObject] should] beKindOfClass:[TSFUserQuestionnaireInfoViewController class]];
        });
        
        it(@"has an outlet for the title label", ^{
            [[_userQuestionnaireInfoViewController.titleLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the subject label", ^{
            [[_userQuestionnaireInfoViewController.subjectLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the description label", ^{
            [[_userQuestionnaireInfoViewController.descriptionLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the assessors label", ^{
            [[_userQuestionnaireInfoViewController.assessorsLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the assessors tableview", ^{
            [[_userQuestionnaireInfoViewController.assessorsTableView shouldNot] beNil];
        });
        
        it(@"has an outlet for the remind assessors button", ^{
            [[_userQuestionnaireInfoViewController.remindAssessorsButton shouldNot] beNil];
        });
    });
    
    it(@"has a reference to the assessor service", ^{
        [[_userQuestionnaireInfoViewController.assessorService should] beKindOfClass:[TSFAssessorService class]];
    });
    
    it(@"can reload the assessors", ^{
        id mockAssessorService = [KWMock mockForClass:[TSFAssessorService class]];
        _userQuestionnaireInfoViewController.assessorService = mockAssessorService;
        
        TSFQuestionnaire *questionnaire = [[TSFQuestionnaire alloc] init];
        questionnaire.questionnaireId = @(arc4random());
        _userQuestionnaireInfoViewController.questionnaire = questionnaire;
        
        [[mockAssessorService should] receive:@selector(assessorsForQuestionnaireId:withSuccess:failure:)
                                withArguments:questionnaire.questionnaireId, [KWAny any], [KWAny any]];
        
        [_userQuestionnaireInfoViewController reloadAssessors];
    });
    
    context(@"with assessors", ^{
        __block id _mockAssessorService;
        __block TSFQuestionnaire *_questionnaire;
        __block NSArray *_assessors;
        __block TSFAssessor *_assessor;
        __block TSFAssessor *_assessorTwo;
        
        beforeEach(^{
            _mockAssessorService = [KWMock mockForClass:[TSFAssessorService class]];
            _userQuestionnaireInfoViewController.assessorService = _mockAssessorService;
            
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
            
            _userQuestionnaireInfoViewController.questionnaire = questionnaire;
        });
        
        it(@"calls the assessor service to remind every uncompleted assessor", ^{
            [[_mockAssessorService should] receive:@selector(remindAssessorWithId:success:failure:)
                                    withArguments:_assessor.assessorId, [KWAny any], [KWAny any]];
            [[_mockAssessorService should] receive:@selector(remindAssessorWithId:success:failure:)
                                     withArguments:_assessorTwo.assessorId, [KWAny any], [KWAny any]];
            
            [_userQuestionnaireInfoViewController remindAssessors];
        });
        
        it(@"only reminds the incompleted assessors", ^{
            _assessorTwo.completed = YES;
            _questionnaire.assessors = @[ _assessor, _assessorTwo ];
            _userQuestionnaireInfoViewController.questionnaire = _questionnaire;
            
            [[_mockAssessorService should] receive:@selector(remindAssessorWithId:success:failure:)
                                     withArguments:_assessor.assessorId, [KWAny any], [KWAny any]];
           
            [_userQuestionnaireInfoViewController remindAssessors];
        });
    });
});

SPEC_END