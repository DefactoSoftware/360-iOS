//
//  TSFAssessorServiceSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFAssessorService.h"

SPEC_BEGIN(TSFAssessorServiceSpec)

describe(@"TSFAssessorService", ^{
    __block TSFAssessorService *_assessorService;
    __block id _mockAPIClient;
    
    beforeEach ( ^{
        _assessorService = [TSFAssessorService sharedService];
        _mockAPIClient = [KWMock mockForClass:[TSFAPIClient class]];
        _assessorService.apiClient = _mockAPIClient;
	});
    
    it(@"instantiates correctly", ^{
        [[_assessorService should] beKindOfClass:[TSFAssessorService class]];
	});
    
    it(@"has an instance of the APIClient", ^{
        [[_assessorService.apiClient should] beKindOfClass:[TSFAPIClient class]];
	});
    
    it(@"calls the API to complete the assessment", ^{
        __block NSString *_fakeToken = [NSString stringWithFormat:@"%d", arc4random()];
        __block NSString *_expectedRequestURL = [NSString stringWithFormat:@"%@%@?token=%@", TSFAPIBaseURL, TSFAPIEndPointCurrentAssessor, _fakeToken];
        __block NSNumber *_stubResponse = @(arc4random());
        
        [_mockAPIClient stub:@selector(assessorToken) andReturn:_fakeToken];
        
        [[_mockAPIClient should] receive:@selector(PUT:parameters:success:failure:)];
        [_mockAPIClient stub:@selector(PUT:parameters:success:failure:) withBlock: ^id (NSArray *params) {
            NSString *URL = params[0];
            NSDictionary *parameters = params[1];
            void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) = params[2];
            
            [[URL should] equal:_expectedRequestURL];
            [[parameters[@"completed"] should] beTrue];
            successBlock(nil, _stubResponse);
            return nil;
		}];
    
        [_assessorService completeCurrentAssessmentWithSuccess: ^(id response) {
            [[response should] beTrue];
		} failure: ^(NSError *error) {
		}];
    });
});

SPEC_END