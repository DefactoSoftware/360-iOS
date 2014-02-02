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
    
    beforeEach ( ^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _questionnaireViewController = [storyboard instantiateViewControllerWithIdentifier:@"TSFQuestionnaireViewController"];
        
        UIView *view = _questionnaireViewController.view;
        [[view shouldNot] beNil];
	});
    
    it(@"instantiates correctly from the storyboard", ^{
        [[_questionnaireViewController shouldNot] beNil];
        [[_questionnaireViewController should] beKindOfClass:[TSFQuestionnaireViewController class]];
	});
    
    it(@"has an outlet for the keyBehaviours tableView", ^{
        [[_questionnaireViewController.keyBehavioursTableView shouldNot] beNil];
    });
    
    it(@"has an outlet for the previous button", ^{
        [[_questionnaireViewController.previousButton shouldNot] beNil];
    });

    it(@"has an outlet for the next button", ^{
        [[_questionnaireViewController.nextButton shouldNot] beNil];
    });
    
    it(@"instantiates a competence service", ^{
        [[_questionnaireViewController.competenceService shouldNot] beNil];
        [[_questionnaireViewController.competenceService should] beKindOfClass:[TSFCompetenceService class]];
    });
    
    it(@"calls the competence service to update the competence when navigating to the next competence", ^{
        id mockCompetenceService = [KWMock mockForClass:[TSFCompetenceService class]];
        _questionnaireViewController.competenceService = mockCompetenceService;
        
        TSFQuestionnaire *stubQuestionnaire = [[TSFQuestionnaire alloc] init];
        TSFCompetence *stubCompetence = [[TSFCompetence alloc] init];
        TSFCompetence *stubCompetenceTwo = [[TSFCompetence alloc] init];
        stubQuestionnaire.competences = @[stubCompetence, stubCompetenceTwo];
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
