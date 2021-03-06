//
//  TSFAPIClientSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis on 28/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFAPIClient.h"

SPEC_BEGIN(TSFAPIClientSpec)

describe(@"TSFAPIClient", ^{
    __block TSFAPIClient *APIClient;
    
    beforeEach ( ^{
        APIClient = [TSFAPIClient sharedClient];
	});
    
    it(@"instantiates correctly", ^{
        [[APIClient should] beKindOfClass:[TSFAPIClient class]];
	});
    
    it(@"has the correct base URL", ^{
        [[[APIClient.baseURL absoluteString] should] equal:TSFAPIBaseURL];
	});
    
    context(@"#setAssessorTokenWithURL", ^{
        it(@"sets the token correctly", ^{
            NSURL *url = [NSURL URLWithString:@"feedback://assessor?token=12345&something_else=foo"];
            [APIClient setAssessorTokenWithURL:url];
            [[APIClient.assessorToken should] equal:@"12345"];
		});
	});
    
    context(@"when signed in", ^{
        __block id _mockSessionService;
        __block TSFUser *_stubUser;
        __block NSString *_stubEmail;
        __block NSString *_stubAuthToken;
        
        beforeEach(^{
            _mockSessionService = [KWMock mockForClass:[TSFSessionService class]];
            _stubEmail = [NSString stringWithFormat:@"%d", arc4random()];
            _stubAuthToken = [NSString stringWithFormat:@"%d", arc4random()];
            _stubUser = [[TSFUser alloc] init];
            _stubUser.email = _stubEmail;
            _stubUser.authToken = _stubAuthToken;
            
            APIClient.sessionService = _mockSessionService;
            [[_mockSessionService should] receive:@selector(signedInUser)
                                        andReturn:_stubUser];
        });
        
        it(@"adds the corresponding headers to the request", ^{
            id mockUrlRequest = [KWMock mockForClass:[NSURLRequest class]];
            [mockUrlRequest stub:@selector(mutableCopy) andReturn:mockUrlRequest];
            [[mockUrlRequest should] receive:@selector(addValue:forHTTPHeaderField:) withCount:2
                                   arguments:_stubEmail, @"From"];
            [[mockUrlRequest should] receive:@selector(addValue:forHTTPHeaderField:) withCount:2
                                   arguments:_stubAuthToken, @"Authorization"];
            
            [APIClient HTTPRequestOperationWithRequest:mockUrlRequest
                                               success:^(AFHTTPRequestOperation *operation, id responseObject) {}
                                               failure:^(AFHTTPRequestOperation *operation, NSError *error) {}];
        });
    });
});

SPEC_END