//
//  TSFQuestionnaireViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis on 30/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFQuestionnaireViewController.h"
#import "TSFKeyBehaviourRatingView.h"

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
        TSFKeyBehaviour *stubKeyBehaviour = [[TSFKeyBehaviour alloc] init];
        stubCompetence.keyBehaviours = @[stubKeyBehaviour];
        _questionnaireViewController.questionnaire = stubQuestionnaire;
        
        TSFKeyBehaviourRatingView *stubKeyBehaviourRatingView = [[TSFKeyBehaviourRatingView alloc] init];
        stubKeyBehaviourRatingView.selectedRating = 1;
        [_questionnaireViewController.currentKeyBehaviourRatingViews addObject:stubKeyBehaviourRatingView];
        
        [[mockCompetenceService should] receive:@selector(updateCompetence:forQuestionnaire:withSuccess:failure:)
                                  withArguments:stubCompetence, stubQuestionnaire, [KWAny any], [KWAny any]];
        
        [_questionnaireViewController nextCompetenceButtonPressed:nil];
    });
    
    context(@"validating the user input", ^{
        __block TSFQuestionnaire *_stubQuestionnaire;
        __block TSFCompetence *_stubCompetence;
        __block TSFKeyBehaviour *_stubKeyBehaviourOne;
        __block TSFKeyBehaviour *_stubKeyBehaviourTwo;
        
        beforeEach(^{
            _stubQuestionnaire = [[TSFQuestionnaire alloc] init];
            _stubCompetence = [[TSFCompetence alloc] init];
            _stubKeyBehaviourOne = [[TSFKeyBehaviour alloc] init];
            _stubKeyBehaviourTwo = [[TSFKeyBehaviour alloc] init];
            
            _stubCompetence.keyBehaviours = @[_stubKeyBehaviourOne, _stubKeyBehaviourTwo];
            _stubQuestionnaire.competences = @[_stubCompetence];
            
            _questionnaireViewController.questionnaire = _stubQuestionnaire;
        });
        
        it(@"is not valid without key behaviour rating views", ^{
            [[theValue([_questionnaireViewController validateInput]) should] beFalse];
        });
        
        it(@"is not valid when not every key behaviour rating view is loaded", ^{
            TSFKeyBehaviourRatingView *keyBehaviourRatingViewOne = [[TSFKeyBehaviourRatingView alloc] init];
            keyBehaviourRatingViewOne.selectedRating = 5;
            [_questionnaireViewController.currentKeyBehaviourRatingViews addObject:keyBehaviourRatingViewOne];
            
            [[theValue([_questionnaireViewController validateInput]) should] beFalse];
        });
        
        it(@"is not valid when not every key behaviour is rated", ^{
            TSFKeyBehaviourRatingView *keyBehaviourRatingViewOne = [[TSFKeyBehaviourRatingView alloc] init];
            TSFKeyBehaviourRatingView *keyBehaviourRatingViewTwo = [[TSFKeyBehaviourRatingView alloc] init];
            keyBehaviourRatingViewOne.selectedRating = 5;
            
            [_questionnaireViewController.currentKeyBehaviourRatingViews addObjectsFromArray:@[keyBehaviourRatingViewOne, keyBehaviourRatingViewTwo]];
            
            [[theValue([_questionnaireViewController validateInput]) should] beFalse];
        });
        
        it(@"is valid when every key behaviour rating view is loaded and rated", ^{
            TSFKeyBehaviourRatingView *keyBehaviourRatingViewOne = [[TSFKeyBehaviourRatingView alloc] init];
            TSFKeyBehaviourRatingView *keyBehaviourRatingViewTwo = [[TSFKeyBehaviourRatingView alloc] init];
            keyBehaviourRatingViewOne.selectedRating = 5;
            keyBehaviourRatingViewTwo.selectedRating = 5;
            
            [_questionnaireViewController.currentKeyBehaviourRatingViews addObjectsFromArray:@[keyBehaviourRatingViewOne, keyBehaviourRatingViewTwo]];
            
            [[theValue([_questionnaireViewController validateInput]) should] beTrue];
        });
    });
});

SPEC_END
