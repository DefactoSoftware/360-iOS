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
});

SPEC_END
