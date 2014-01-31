//
//  TSFQuestionnaireViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis on 30/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFQuestionnaireViewController.h"

SPEC_BEGIN(TSFQuestionnaireViewControllerSpec)

describe(@"TSFQuestionnaireViewController", ^{
    __block TSFQuestionnaireViewController *_questionnaireViewController;
    __block id _mockQuestionnaireService;
    
    beforeEach ( ^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _questionnaireViewController = [storyboard instantiateViewControllerWithIdentifier:@"TSFQuestionnaireViewController"];
        
        _mockQuestionnaireService = [KWMock mockForClass:[TSFQuestionnaireService class]];
        _questionnaireViewController.questionnaireService = _mockQuestionnaireService;
        [[_mockQuestionnaireService should] receive:@selector(questionnairesWithSuccess:failure:)];
        
        UIView *view = _questionnaireViewController.view;
        [[view shouldNot] beNil];
	});
    
    it(@"instantiates correctly from the storyboard", ^{
        [[_questionnaireViewController shouldNot] beNil];
        [[_questionnaireViewController should] beKindOfClass:[TSFQuestionnaireViewController class]];
	});
    
    it(@"instantiates a questionnaire service", ^{
        [[_questionnaireViewController.questionnaireService shouldNot] beNil];
        [[_questionnaireViewController.questionnaireService should] beKindOfClass:[TSFQuestionnaireService class]];
	});
    
    it(@"instantiates a competence service", ^{
        [[_questionnaireViewController.competenceService shouldNot] beNil];
        [[_questionnaireViewController.competenceService should] beKindOfClass:[TSFCompetenceService class]];
    });
    
    it(@"calls the competence service to update the competence when navigating to the next competence", ^{
        id mockCompetenceService = [KWMock mockForClass:[TSFCompetenceService class]];
        _questionnaireViewController.competenceService = mockCompetenceService;
        
        TSFQuestionnaire *stubQuestionnaire = [[TSFQuestionnaire alloc] init];
        stubQuestionnaire.questionnaireId = @(arc4random());
        TSFCompetence *stubCompetence = [[TSFCompetence alloc] init];
        stubCompetence.competenceId = @(arc4random());
        stubQuestionnaire.competences = @[stubCompetence];
        _questionnaireViewController.questionnaire = stubQuestionnaire;
        
        [[mockCompetenceService should] receive:@selector(updateCompetence:forQuestionnaire:withSuccess:failure:)
                                  withArguments:stubCompetence, stubQuestionnaire, [KWAny any], [KWAny any]];
        
        [_questionnaireViewController nextCompetenceButtonPressed:nil];
    });
});

SPEC_END
