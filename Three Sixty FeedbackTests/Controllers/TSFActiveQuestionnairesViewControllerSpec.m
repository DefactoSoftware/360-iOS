//
//  TSFActiveQuestionnairesViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFActiveQuestionnairesViewController.h"

SPEC_BEGIN(TSFActiveQuestionnairesViewControllerSpec)

describe(@"TSFActiveQuestionnairesViewcontroller", ^{
    __block UIStoryboard *_storyboard;
    __block TSFActiveQuestionnairesViewController *_activeQuestionnairesViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _activeQuestionnairesViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFActiveQuestionnairesViewController"];
        [[[_activeQuestionnairesViewController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"instantiates correctly from the storyboard", ^{
            [[_activeQuestionnairesViewController shouldNot] beNil];
        });
        
        it(@"has a questionnaire tableview", ^{
            [[_activeQuestionnairesViewController.questionnairesTableView shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFActiveQuestionnairesViewController *_activeQuestionnairesViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _activeQuestionnairesViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFActiveQuestionnairesViewController"];
            [[[_activeQuestionnairesViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_activeQuestionnairesViewController shouldNot] beNil];
        });
        
        it(@"has a questionnaire tableview", ^{
            [[_activeQuestionnairesViewController.questionnairesTableView shouldNot] beNil];
        });
    });
    
    it(@"sets the active questionnaires and reloads the tableview", ^{
        id mockTableView = [KWMock mockForClass:[UITableView class]];
        _activeQuestionnairesViewController.questionnairesTableView = mockTableView;
        
        TSFQuestionnaire *questionnaire = [[TSFQuestionnaire alloc] init];
        TSFQuestionnaire *questionnaireTwo = [[TSFQuestionnaire alloc] init];
        
        NSArray *activeQuestionnaires = @[ questionnaire, questionnaireTwo ];
        
        [[mockTableView should] receive:@selector(reloadData)];
        [_activeQuestionnairesViewController displayQuestionnaires:activeQuestionnaires];
        [[_activeQuestionnairesViewController.questionnaires should] equal:activeQuestionnaires];
    });
});

SPEC_END