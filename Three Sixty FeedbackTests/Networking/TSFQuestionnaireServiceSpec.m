//
//  TSFQuestionnaireServiceSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFQuestionnaireService.h"

SPEC_BEGIN(TSFQuestionnaireServiceSpec)

describe(@"TSFQuestionnaireService", ^{
    __block TSFQuestionnaireService *_questionnaireService;
    __block id _mockAPIClient;
    __block id _mockQuestionnaireMapper;
    
    beforeEach ( ^{
        _questionnaireService = [TSFQuestionnaireService sharedService];
        _mockAPIClient = [KWMock mockForClass:[TSFAPIClient class]];
        _mockQuestionnaireMapper = [KWMock mockForClass:[TSFQuestionnaireMapper class]];
        _questionnaireService.apiClient = _mockAPIClient;
        _questionnaireService.questionnaireMapper = _mockQuestionnaireMapper;
	});
    
    it(@"instantiates correctly", ^{
        [[_questionnaireService should] beKindOfClass:[TSFQuestionnaireService class]];
	});
    
    it(@"has an instance of the APIClient", ^{
        [[_questionnaireService.apiClient should] beKindOfClass:[TSFAPIClient class]];
	});
    
    it(@"has an instance of a questionnaire mapper", ^{
        [[_questionnaireService.questionnaireMapper shouldNot] beNil];
        [[_questionnaireService.questionnaireMapper should] beKindOfClass:[TSFQuestionnaireMapper class]];
	});
    
    it(@"calls the API for a list of questionnaires with a token", ^{
        __block NSString *_fakeToken = [NSString stringWithFormat:@"%d", arc4random()];
        __block NSString *_expectedRequestURL = [NSString stringWithFormat:@"%@%@", TSFAPIBaseURL, TSFAPIEndPointQuestionnaires];
        __block NSArray *_stubResponse = @[@{ @"id" : @(arc4random()) }];
        __block NSArray *_stubMappedResponse = [[[TSFQuestionnaireMapper alloc] init]
                                                questionnairesWithDictionaryArray:_stubResponse];
        
        [_mockAPIClient stub:@selector(assessorToken) andReturn:_fakeToken];
        [_mockAPIClient stub:@selector(GET:parameters:success:failure:) withBlock: ^id (NSArray *params) {
            NSString *URL = params[0];
            NSDictionary *parameters = params[1];
            void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) = params[2];
            
            [[URL should] equal:_expectedRequestURL];
            [[parameters[@"token"] should] equal:_fakeToken];
            successBlock(nil, _stubResponse);
            return nil;
		}];
        
        [[_mockQuestionnaireMapper should] receive:@selector(questionnairesWithDictionaryArray:)
                                         andReturn:_stubMappedResponse
                                     withArguments:_stubResponse];
        
        [_questionnaireService questionnairesWithSuccess: ^(NSArray *response) {
            [[response should] equal:_stubMappedResponse];
		}
         
                                                 failure: ^(NSError *error) {}];
	});
    
    it(@"calls the API for a specific questionnaire", ^{
        NSNumber *questionnaireId = @(arc4random());
        NSString *expectedUrl = [NSString stringWithFormat:@"%@/%@", TSFAPIEndPointQuestionnaires, questionnaireId];
        [[_mockAPIClient should] receive:@selector(GET:parameters:success:failure:)
                           withArguments:expectedUrl, [KWAny any], [KWAny any], [KWAny any]];
        
        [_questionnaireService questionnaireWithId:questionnaireId success:^(id response) {
        } failure:^(NSError *error) {
        }];
    });
    
    it(@"calls the API for a list of questionnaires for the signed in user", ^{
        [[_mockAPIClient should] receive:@selector(GET:parameters:success:failure:)
                           withArguments:TSFAPIEndPointUserQuestionnaires, [KWAny any], [KWAny any], [KWAny any]];
        
        [_questionnaireService userQuestionnairesWithSuccess: ^(NSArray *response) {
        }
                                                     failure: ^(NSError *error) {}];
    });
    
    it(@"maps the specific questionnaire in the response", ^{
        NSNumber *questionnaireId = @(arc4random());
        __block NSDictionary *_stubResponse = @{ @"id": questionnaireId };
        TSFQuestionnaire *stubMappedResponse = [[[TSFQuestionnaireMapper alloc] init]
                                                questionnaireWithDictionary:_stubResponse];
        
        [[_mockQuestionnaireMapper should] receive:@selector(questionnaireWithDictionary:)
                                         andReturn:stubMappedResponse];
        
        [_mockAPIClient stub:@selector(GET:parameters:success:failure:) withBlock:^id(NSArray *params) {
            void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) = params[2];
            successBlock(nil, _stubResponse);
            return nil;
        }];
        
        [_questionnaireService questionnaireWithId:questionnaireId success:^(id response) {
        } failure:^(NSError *error) {
        }];
    });
    
    it(@"maps the list of user's questionnaires", ^{
        __block NSArray *_stubResponse = @[@{ @"id": @(arc4random()) }];
        __block NSArray *_stubMappedResponse = [[[TSFQuestionnaireMapper alloc] init]
                                                questionnairesWithDictionaryArray:_stubResponse];

        [_mockAPIClient stub:@selector(GET:parameters:success:failure:) withBlock:^id(NSArray *params) {
            void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) = params[2];
            successBlock(nil, _stubResponse);
            return nil;
        }];
        
        [[_mockQuestionnaireMapper should] receive:@selector(questionnairesWithDictionaryArray:)
                                         andReturn:_stubMappedResponse
                                     withArguments:_stubResponse];
        
        [_questionnaireService userQuestionnairesWithSuccess: ^(NSArray *response) {
            [[response shouldEventually] equal:_stubMappedResponse];
        }
                                                     failure: ^(NSError *error) {}];
    });
});

SPEC_END