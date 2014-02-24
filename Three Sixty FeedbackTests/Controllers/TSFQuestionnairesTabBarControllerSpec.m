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
        
        it(@"displays the questionnaires in the active questionnaires viewcontroller", ^{
            id mockActiveQuestionnairesViewController = [KWMock mockForClass:[TSFActiveQuestionnairesViewController class]];
            __block NSArray *_stubQuestionnaires = @[ [[TSFQuestionnaire alloc] init], [[TSFQuestionnaire alloc] init] ];
            
            [_mockQuestionnaireService stub:@selector(userQuestionnairesWithSuccess:failure:) withBlock:^id(NSArray *params) {
                void (^successBlock)(id responseObject) = params[0];
                successBlock(_stubQuestionnaires);
                return nil;
            }];
            
            [[mockActiveQuestionnairesViewController should] receive:@selector(displayQuestionnaires:)
                                                       withArguments:_stubQuestionnaires];
            
            _questionnairesTabBarController.activeQuestionnairesViewController = mockActiveQuestionnairesViewController;
            [_questionnairesTabBarController loadQuestionnaires];
        });
    });
});

SPEC_END