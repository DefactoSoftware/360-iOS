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
    
    context(@"calling the competence service to update", ^{
        __block id _mockCompetenceService;
        __block TSFQuestionnaire *_stubQuestionnaire;
        __block TSFCompetence *_stubCompetence;
        __block TSFKeyBehaviour *_stubKeyBehaviour;
        
        beforeEach(^{
            _mockCompetenceService = [KWMock mockForClass:[TSFCompetenceService class]];
            _competenceViewController.competenceService = _mockCompetenceService;
            
            _stubQuestionnaire = [[TSFQuestionnaire alloc] init];
            _stubCompetence = [[TSFCompetence alloc] init];
            _stubKeyBehaviour = [[TSFKeyBehaviour alloc] init];
            _stubCompetence.keyBehaviours = @[_stubKeyBehaviour];
            _competenceViewController.questionnaire = _stubQuestionnaire;
            _competenceViewController.competence = _stubCompetence;
            
            TSFKeyBehaviourRatingView *stubKeyBehaviourRatingView = [[TSFKeyBehaviourRatingView alloc] init];
            stubKeyBehaviourRatingView.selectedRating = 1;
            [_competenceViewController.currentKeyBehaviourRatingViews addObject:stubKeyBehaviourRatingView];
        });
        
        it(@"calls the competence service to update the competence when navigating to the next competence", ^{
            [[_mockCompetenceService should] receive:@selector(updateCompetence:forQuestionnaire:withSuccess:failure:)
                                      withArguments:_stubCompetence, _stubQuestionnaire, [KWAny any], [KWAny any]];
            
            [_competenceViewController updateCompetenceWithCompletion:nil];
        });
        
        it(@"calls the competence service to update with the correct commentary", ^{
            [[_mockCompetenceService should] receive:@selector(updateCompetence:forQuestionnaire:withSuccess:failure:)];
            __block NSString *_stubComment = [NSString stringWithFormat:@"%d", arc4random()];
            
            [_mockCompetenceService stub:@selector(updateCompetence:forQuestionnaire:withSuccess:failure:) withBlock:^id(NSArray *params) {
                TSFCompetence *stubCompetence = (TSFCompetence *)params[0];
                [[stubCompetence.comment should] equal:_stubComment];
                
                return nil;
            }];
            
            _competenceViewController.commentaryTextView = [[UITextView alloc] init];
            _competenceViewController.commentaryTextView.text = _stubComment;
            [_competenceViewController updateCompetenceWithCompletion:nil];
        });
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
            _competenceViewController.competence = _stubCompetence;
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
