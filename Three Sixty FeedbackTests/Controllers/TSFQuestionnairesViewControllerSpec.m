//
//  TSFQuestionnairesViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 26-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFQuestionnairesViewController.h"

SPEC_BEGIN(TSFQuestionnairesViewControllerSpec)

describe(@"TSFQuestionnairesViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFQuestionnairesViewController *_questionnairesViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _questionnairesViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFQuestionnairesViewController"];
        [[[_questionnairesViewController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"instantiates correctly from the storyboard", ^{
            [[_questionnairesViewController shouldNot] beNil];
        });
        
        it(@"has a questionnaire tableview", ^{
            [[_questionnairesViewController.questionnairesTableView shouldNot] beNil];
        });
        
        it(@"has a active segmentedcontrol", ^{
            [[_questionnairesViewController.activeSegmentedControl shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFQuestionnairesViewController *_questionnairesViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _questionnairesViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFQuestionnairesViewController"];
            [[[_questionnairesViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_questionnairesViewController shouldNot] beNil];
        });
        
        it(@"has a questionnaire tableview", ^{
            [[_questionnairesViewController.questionnairesTableView shouldNot] beNil];
        });
        
        it(@"has a active segmented control", ^{
            [[_questionnairesViewController.activeSegmentedControl shouldNot] beNil];
        });
    });
    
    it(@"has a reference to questionnaire service", ^{
        [[_questionnairesViewController.questionnaireService should] beKindOfClass:[TSFQuestionnaireService class]];
    });
    
    it(@"has a reference to the assessor service", ^{
        [[_questionnairesViewController.assessorService should] beKindOfClass:[TSFAssessorService class]];
    });
    
    context(@"getting the user's questionnaires", ^{
        __block id _mockQuestionnaireService;
        
        beforeEach(^{
            _mockQuestionnaireService = [KWMock mockForClass:[TSFQuestionnaireService class]];
            _questionnairesViewController.questionnaireService = _mockQuestionnaireService;
        });
        
        it(@"calls the questionnaire service for a list of questionnaires", ^{
            [[_mockQuestionnaireService should] receive:@selector(userQuestionnairesWithSuccess:failure:)];
            
            [_questionnairesViewController loadQuestionnaires];
        });
    });
    
    context(@"getting the questionnaires assessors", ^{
        __block id _mockAssessorService;
        __block TSFQuestionnaire *_questionnaire;
        __block TSFQuestionnaire *_questionnaireTwo;
        
        beforeEach(^{
            _mockAssessorService = [KWMock mockForClass:[TSFAssessorService class]];
            _questionnairesViewController.assessorService = _mockAssessorService;
            
            _questionnaire = [[TSFQuestionnaire alloc] init];
            _questionnaireTwo = [[TSFQuestionnaire alloc] init];
            _questionnaire.questionnaireId = @(arc4random());
            _questionnaireTwo.questionnaireId = @(arc4random());
            
            _questionnairesViewController.questionnaires = @[ _questionnaire, _questionnaireTwo ];
        });
        
        it(@"calls the assessor service for every questionnaire", ^{
            [[_mockAssessorService should] receive:@selector(assessorsForQuestionnaireId:withSuccess:failure:)
                                     withArguments:_questionnaire.questionnaireId, [KWAny any], [KWAny any]];
            [[_mockAssessorService should] receive:@selector(assessorsForQuestionnaireId:withSuccess:failure:)
                                     withArguments:_questionnaireTwo.questionnaireId, [KWAny any], [KWAny any]];
            
            [_questionnairesViewController loadAssessors];
        });
        
        it(@"sets the assessors in the questionnaire object", ^{
            __block NSArray *_stubAssessors = @[ [[TSFAssessor alloc] init], [[TSFAssessor alloc] init] ];
            
            [_mockAssessorService stub:@selector(assessorsForQuestionnaireId:withSuccess:failure:) withBlock:^id(NSArray *params) {
                void (^successBlock)(id response) = params[1];
                successBlock(_stubAssessors);
                return nil;
            }];
            
            [_questionnairesViewController loadAssessors];
            
            TSFQuestionnaire *questionnaire = [_questionnairesViewController.questionnaires firstObject];
            [[questionnaire.assessors should] equal:_stubAssessors];
        });
    });
    
    it(@"filters the active and completed questionnaires", ^{
        id activeQuestionnaire = [KWMock mockForClass:[TSFQuestionnaire class]];
        id completedQuestionnaire = [KWMock mockForClass:[TSFQuestionnaire class]];
        [activeQuestionnaire stub:@selector(completed) andReturn:theValue(NO)];
        [completedQuestionnaire stub:@selector(completed) andReturn:theValue(YES)];
        
        _questionnairesViewController.questionnaires = @[ activeQuestionnaire, completedQuestionnaire ];
        [_questionnairesViewController filterQuestionnaires];
        
        [[_questionnairesViewController.activeQuestionnaires should] equal:@[ activeQuestionnaire ]];
        [[_questionnairesViewController.completedQuestionnaires should] equal:@[ completedQuestionnaire ]];
        
    });
});

SPEC_END