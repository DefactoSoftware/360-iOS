//
//  TSFCompetenceViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis on 30/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFCompetenceViewController.h"
#import "TSFKeyBehaviourRatingView.h"

SPEC_BEGIN(TSFCompetenceViewControllerSpec)

describe(@"TSFCompetenceViewController", ^{
    __block TSFCompetenceViewController *_competenceViewController;
    
    beforeEach ( ^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _competenceViewController = [storyboard instantiateViewControllerWithIdentifier:@"TSFCompetenceViewController"];
        
        UIView *view = _competenceViewController.view;
        [[view shouldNot] beNil];
	});
    
    context(@"iPhone", ^{
        it(@"instantiates correctly from the storyboard", ^{
            [[_competenceViewController shouldNot] beNil];
            [[_competenceViewController should] beKindOfClass:[TSFCompetenceViewController class]];
        });
        
        it(@"has an outlet for the keyBehaviours tableView", ^{
            [[_competenceViewController.keyBehavioursTableView shouldNot] beNil];
        });
        
        it(@"has an outlet for the previous button", ^{
            [[_competenceViewController.previousButton shouldNot] beNil];
        });
        
        it(@"has an outlet for the next button", ^{
            [[_competenceViewController.nextButton shouldNot] beNil];
        });
        
        it(@"instantiates a competence service", ^{
            [[_competenceViewController.competenceService shouldNot] beNil];
            [[_competenceViewController.competenceService should] beKindOfClass:[TSFCompetenceService class]];
        });
    });
    
    context(@"iPad", ^{
        beforeEach(^{
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _competenceViewController = [storyboard instantiateViewControllerWithIdentifier:@"TSFCompetenceViewController"];
            
            UIView *view = _competenceViewController.view;
            [[view shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_competenceViewController shouldNot] beNil];
            [[_competenceViewController should] beKindOfClass:[TSFCompetenceViewController class]];
        });
        
        it(@"has an outlet for the keyBehaviours tableView", ^{
            [[_competenceViewController.keyBehavioursTableView shouldNot] beNil];
        });
        
        it(@"has an outlet for the previous button", ^{
            [[_competenceViewController.previousButton shouldNot] beNil];
        });
        
        it(@"has an outlet for the next button", ^{
            [[_competenceViewController.nextButton shouldNot] beNil];
        });
        
        it(@"instantiates a competence service", ^{
            [[_competenceViewController.competenceService shouldNot] beNil];
            [[_competenceViewController.competenceService should] beKindOfClass:[TSFCompetenceService class]];
        });
    });
    
    it(@"calls the competence service to update the competence when navigating to the next competence", ^{
        id mockCompetenceService = [KWMock mockForClass:[TSFCompetenceService class]];
        _competenceViewController.competenceService = mockCompetenceService;
        
        TSFQuestionnaire *stubQuestionnaire = [[TSFQuestionnaire alloc] init];
        TSFCompetence *stubCompetence = [[TSFCompetence alloc] init];
        TSFKeyBehaviour *stubKeyBehaviour = [[TSFKeyBehaviour alloc] init];
        stubCompetence.keyBehaviours = @[stubKeyBehaviour];
        _competenceViewController.questionnaire = stubQuestionnaire;
        _competenceViewController.competence = stubCompetence;
        
        TSFKeyBehaviourRatingView *stubKeyBehaviourRatingView = [[TSFKeyBehaviourRatingView alloc] init];
        stubKeyBehaviourRatingView.selectedRating = 1;
        [_competenceViewController.currentKeyBehaviourRatingViews addObject:stubKeyBehaviourRatingView];
        
        [[mockCompetenceService should] receive:@selector(updateCompetence:forQuestionnaire:withSuccess:failure:)
                                  withArguments:stubCompetence, stubQuestionnaire, [KWAny any], [KWAny any]];
        
        [_competenceViewController updateCompetenceWithCompletion:nil];
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
            
            _competenceViewController.questionnaire = _stubQuestionnaire;
        });
        
        it(@"is not valid without key behaviour rating views", ^{
            [[theValue([_competenceViewController validateInput]) should] equal:theValue(NO)];
        });
        
        it(@"is not valid when not every key behaviour rating view is loaded", ^{
            TSFKeyBehaviourRatingView *keyBehaviourRatingViewOne = [[TSFKeyBehaviourRatingView alloc] init];
            keyBehaviourRatingViewOne.selectedRating = 5;
            [_competenceViewController.currentKeyBehaviourRatingViews addObject:keyBehaviourRatingViewOne];
            
            [[theValue([_competenceViewController validateInput]) should] equal:theValue(NO)];
        });
        
        it(@"is not valid when not every key behaviour is rated", ^{
            TSFKeyBehaviourRatingView *keyBehaviourRatingViewOne = [[TSFKeyBehaviourRatingView alloc] init];
            TSFKeyBehaviourRatingView *keyBehaviourRatingViewTwo = [[TSFKeyBehaviourRatingView alloc] init];
            keyBehaviourRatingViewOne.selectedRating = 5;
            
            [_competenceViewController.currentKeyBehaviourRatingViews addObjectsFromArray:@[keyBehaviourRatingViewOne, keyBehaviourRatingViewTwo]];
            
            [[theValue([_competenceViewController validateInput]) should] equal:theValue(NO)];
        });
        
        it(@"is valid when every key behaviour rating view is loaded and rated", ^{
            TSFKeyBehaviourRatingView *keyBehaviourRatingViewOne = [[TSFKeyBehaviourRatingView alloc] init];
            TSFKeyBehaviourRatingView *keyBehaviourRatingViewTwo = [[TSFKeyBehaviourRatingView alloc] init];
            keyBehaviourRatingViewOne.selectedRating = 5;
            keyBehaviourRatingViewTwo.selectedRating = 5;
            
            [_competenceViewController.currentKeyBehaviourRatingViews addObjectsFromArray:@[keyBehaviourRatingViewOne, keyBehaviourRatingViewTwo]];
            
            [[theValue([_competenceViewController validateInput]) should] equal:theValue(YES)];
        });
    });
});

SPEC_END
