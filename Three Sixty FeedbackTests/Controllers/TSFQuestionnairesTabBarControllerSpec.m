//
//  TSFQuestionnairesTabBarControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFQuestionnairesTabBarController.h"

SPEC_BEGIN(TSFQuestionnairesTabBarControllerSpec)

describe(@"TSFQuestionnairesTabBarController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFQuestionnairesTabBarController *_questionnairesTabBarController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _questionnairesTabBarController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFQuestionnairesTabBarController"];
        [[[_questionnairesTabBarController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"instantiates correctly from the storyboard", ^{
            [[_questionnairesTabBarController shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFQuestionnairesTabBarController *_questionnairesTabBarController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _questionnairesTabBarController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFQuestionnairesTabBarController"];
            [[[_questionnairesTabBarController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_questionnairesTabBarController shouldNot] beNil];
        });
    });
    
    it(@"has a reference to questionnaire service", ^{
        [[_questionnairesTabBarController.questionnaireService should] beKindOfClass:[TSFQuestionnaireService class]];
    });
    
    it(@"has a reference to the assessor service", ^{
        [[_questionnairesTabBarController.assessorService should] beKindOfClass:[TSFAssessorService class]];
    });
    
    context(@"getting the user's questionnaires", ^{
        __block id _mockQuestionnaireService;
        
        beforeEach(^{
            _mockQuestionnaireService = [KWMock mockForClass:[TSFQuestionnaireService class]];
            _questionnairesTabBarController.questionnaireService = _mockQuestionnaireService;
        });
        
        it(@"calls the questionnaire service for a list of questionnaires", ^{
            [[_mockQuestionnaireService should] receive:@selector(userQuestionnairesWithSuccess:failure:)];
            
            [_questionnairesTabBarController loadQuestionnaires];
        });
        
        it(@"calls the active questionnaires viewcontroller to reload data", ^{
            id mockActiveQuestionnairesViewController = [KWMock mockForClass:[TSFActiveQuestionnairesViewController class]];
            __block NSArray *_stubQuestionnaires = @[ [[TSFQuestionnaire alloc] init], [[TSFQuestionnaire alloc] init] ];
            
            [_mockQuestionnaireService stub:@selector(userQuestionnairesWithSuccess:failure:) withBlock:^id(NSArray *params) {
                void (^successBlock)(id responseObject) = params[0];
                successBlock(_stubQuestionnaires);
                return nil;
            }];
            
            [[mockActiveQuestionnairesViewController should] receive:@selector(reloadData)];
            
            _questionnairesTabBarController.activeQuestionnairesViewController = mockActiveQuestionnairesViewController;
            [_questionnairesTabBarController loadQuestionnaires];
            
            [[_questionnairesTabBarController.questionnaires should] equal:_stubQuestionnaires];
        });
    });
    
    context(@"getting the questionnaires assessors", ^{
        __block id _mockAssessorService;
        __block TSFQuestionnaire *_questionnaire;
        __block TSFQuestionnaire *_questionnaireTwo;
        
        beforeEach(^{
            _mockAssessorService = [KWMock mockForClass:[TSFAssessorService class]];
            _questionnairesTabBarController.assessorService = _mockAssessorService;
            
            _questionnaire = [[TSFQuestionnaire alloc] init];
            _questionnaireTwo = [[TSFQuestionnaire alloc] init];
            _questionnaire.questionnaireId = @(arc4random());
            _questionnaireTwo.questionnaireId = @(arc4random());
            
            _questionnairesTabBarController.questionnaires = @[ _questionnaire, _questionnaireTwo ];
        });
        
        it(@"calls the assessor service for every questionnaire", ^{
            [[_mockAssessorService should] receive:@selector(assessorsForQuestionnaireId:withSuccess:failure:)
                                     withArguments:_questionnaire.questionnaireId, [KWAny any], [KWAny any]];
            [[_mockAssessorService should] receive:@selector(assessorsForQuestionnaireId:withSuccess:failure:)
                                     withArguments:_questionnaireTwo.questionnaireId, [KWAny any], [KWAny any]];
            
            [_questionnairesTabBarController loadAssessors];
        });
        
        it(@"sets the assessors in the questionnaire object", ^{
            __block NSArray *_stubAssessors = @[ [[TSFAssessor alloc] init], [[TSFAssessor alloc] init] ];
            
            [_mockAssessorService stub:@selector(assessorsForQuestionnaireId:withSuccess:failure:) withBlock:^id(NSArray *params) {
                void (^successBlock)(id response) = params[1];
                successBlock(_stubAssessors);
                return nil;
            }];
            
            [_questionnairesTabBarController loadAssessors];
            
            TSFQuestionnaire *questionnaire = [_questionnairesTabBarController.questionnaires firstObject];
            [[questionnaire.assessors should] equal:_stubAssessors];
        });
        
        it(@"calls the viewcontrollers to reload their data", ^{
            [_mockAssessorService stub:@selector(assessorsForQuestionnaireId:withSuccess:failure:) withBlock:^id(NSArray *params) {
                void (^successBlock)(id responseObject) = params[1];
                successBlock(@YES);
                return nil;
            }];
            
            id mockActiveQuestionnairesViewController = [KWMock mockForClass:[TSFActiveQuestionnairesViewController class]];
            _questionnairesTabBarController.activeQuestionnairesViewController = mockActiveQuestionnairesViewController;
            
            [[mockActiveQuestionnairesViewController should] receive:@selector(reloadData) withCount:2];
            
            [_questionnairesTabBarController loadAssessors];
        });
    });
});

SPEC_END