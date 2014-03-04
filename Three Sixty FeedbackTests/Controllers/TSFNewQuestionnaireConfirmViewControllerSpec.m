//
//  TSFNewQuestionnaireConfirmViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 04-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFNewQuestionnaireConfirmViewController.h"

SPEC_BEGIN(TSFNewQuestionnaireConfirmViewControllerSpec)

describe(@"TSFNewQuestionnaireConfirmViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFNewQuestionnaireConfirmViewController *_newQuestionnaireConfirmViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _newQuestionnaireConfirmViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFNewQuestionnaireConfirmViewController"];
        [[[_newQuestionnaireConfirmViewController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"instantiates correctly from the storyboard", ^{
            [[_newQuestionnaireConfirmViewController shouldNot] beNil];
        });
        
        it(@"has an outlet for the subject title label", ^{
            [[_newQuestionnaireConfirmViewController.subjectLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the subject label", ^{
            [[_newQuestionnaireConfirmViewController.templateLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the assessors label", ^{
            [[_newQuestionnaireConfirmViewController.assessorsLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the create button", ^{
            [[_newQuestionnaireConfirmViewController.createButton shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFNewQuestionnaireConfirmViewController *_newQuestionnaireConfirmViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _newQuestionnaireConfirmViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFNewQuestionnaireConfirmViewController"];
            [[[_newQuestionnaireConfirmViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_newQuestionnaireConfirmViewController shouldNot] beNil];
        });
        
        it(@"has an outlet for the subject title label", ^{
            [[_newQuestionnaireConfirmViewController.subjectLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the subject label", ^{
            [[_newQuestionnaireConfirmViewController.templateLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the assessors label", ^{
            [[_newQuestionnaireConfirmViewController.assessorsLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the create button", ^{
            [[_newQuestionnaireConfirmViewController.createButton shouldNot] beNil];
        });
    });
    
    it(@"has a reference to the questionnaireservice", ^{
        [[_newQuestionnaireConfirmViewController.questionnaireService should] beKindOfClass:[TSFQuestionnaireService class]];
    });
    
    it(@"has a reference to the assessorsservice", ^{
        [[_newQuestionnaireConfirmViewController.assessorService should] beKindOfClass:[TSFAssessorService class]];
    });
    
    context(@"creating the questionnaire", ^{
        __block id _mockQuestionnaireService;
        __block id _mockAssessorService;
        __block NSString *_subject;
        __block TSFTemplate *_questionnaireTemplate;
        __block NSArray *_assessors;
        __block TSFQuestionnaire *_newQuestionnaire;
        
        beforeEach(^{
            _mockQuestionnaireService = [KWMock mockForClass:[TSFQuestionnaireService class]];
            _mockAssessorService = [KWMock mockForClass:[TSFAssessorService class]];
            
            _newQuestionnaireConfirmViewController.questionnaireService = _mockQuestionnaireService;
            _newQuestionnaireConfirmViewController.assessorService = _mockAssessorService;
            
            _subject = [NSString stringWithFormat:@"%d", arc4random()];
            _questionnaireTemplate = [[TSFTemplate alloc] init];
            _questionnaireTemplate.templateId = @(arc4random());
            
            _newQuestionnaireConfirmViewController.subject = _subject;
            _newQuestionnaireConfirmViewController.questionnaireTemplate = _questionnaireTemplate;
            
            _assessors = @[
                           [NSString stringWithFormat:@"%d", arc4random()],
                           [NSString stringWithFormat:@"%d", arc4random()]
                           ];
            
            _newQuestionnaire = [[TSFQuestionnaire alloc] init];
            _newQuestionnaire.questionnaireId = @(arc4random());
            _newQuestionnaireConfirmViewController.assessors = _assessors;
        });
        
        it(@"calls the questionnaireservice to create a new questionnaire", ^{
            [[_mockQuestionnaireService should] receive:@selector(createQuestionnaireWithSubject:templateId:success:failure:)
                                          withArguments:_subject, _questionnaireTemplate.templateId, [KWAny any], [KWAny any]];
            
            [_newQuestionnaireConfirmViewController createQuestionnaire];
        });
        
        it(@"calls the assessor service to create new assessors", ^{
            [[_mockAssessorService should] receive:@selector(createAssessorWithEmail:forQuestionnaireId:withSuccess:failure:)
                         withArguments:_assessors[0], _newQuestionnaire.questionnaireId, [KWAny any], [KWAny any]];
            [[_mockAssessorService should] receive:@selector(createAssessorWithEmail:forQuestionnaireId:withSuccess:failure:)
                         withArguments:_assessors[1], _newQuestionnaire.questionnaireId, [KWAny any], [KWAny any]];
            
            [_mockQuestionnaireService stub:@selector(createQuestionnaireWithSubject:templateId:success:failure:)
                                  withBlock:^id(NSArray *params) {
                                      void (^successBlock)(id responseObject) = params[2];
                                      successBlock(_newQuestionnaire);
                                      return nil;
            }];
            
            [_newQuestionnaireConfirmViewController createQuestionnaire];
        });
    });
});

SPEC_END