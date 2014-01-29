//
//  TSFQuestionnaireServiceSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "Nocilla.h"
#import "TSFQuestionnaireService.h"

SPEC_BEGIN(TSFQuestionnaireServiceSpec)

describe(@"TSFQuestionnaireService", ^{
    __block TSFQuestionnaireService *_questionnaireService;
    __block id _mockAPIClient;
    
    beforeAll ( ^{
        [[LSNocilla sharedInstance] start];
	});
    
    afterAll ( ^{
        [[LSNocilla sharedInstance] stop];
	});
    
    afterEach ( ^{
        [[LSNocilla sharedInstance] clearStubs];
	});
    
    beforeEach ( ^{
        _questionnaireService = [TSFQuestionnaireService sharedService];
        _mockAPIClient = [KWMock mockForClass:[TSFAPIClient class]];
        _questionnaireService.apiClient = _mockAPIClient;
	});
    
    it(@"instantiates correctly", ^{
        [[_questionnaireService should] beKindOfClass:[TSFQuestionnaireService class]];
	});
    
    it(@"has an instance of the APIClient", ^{
        [[_questionnaireService.apiClient should] beKindOfClass:[TSFAPIClient class]];
	});
    
    it(@"calls the API for a list of questionnaires with a token", ^{
        __block NSString *fakeToken = [NSString stringWithFormat:@"%d", arc4random()];
        __block NSString *expectedRequestURL = [NSString stringWithFormat:@"%@%@", TSFAPIBaseURL, TSFAPIEndPointQuestionnaires];
        __block NSArray *stubResponse = @[@{ @"id" : @(arc4random()) }];
        __block NSArray *stubMappedResponse = [TSFQuestionnaireMapper questionnairesWithDictionaryArray:stubResponse];
        
        [_mockAPIClient stub:@selector(GET:parameters:success:failure:) withBlock: ^id (NSArray *params) {
            NSString *URL = params[0];
            NSDictionary *parameters = params[1];
            void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) = params[2];
            
            [[URL should] equal:expectedRequestURL];
            [[parameters[@"token"] should] equal:fakeToken];
            successBlock(nil, stubResponse);
            return nil;
		}];
        
        [[TSFQuestionnaireMapper should] receive:@selector(questionnairesWithDictionaryArray:)
                                       andReturn:stubMappedResponse
                                   withArguments:stubResponse];
        
        [_questionnaireService questionnairesWithToken:fakeToken
                                               success: ^(NSArray *response) {
                                                   [[response should] equal:stubMappedResponse];
                                               }
         
                                               failure: ^(NSError *error) {}];
	});
});

SPEC_END
