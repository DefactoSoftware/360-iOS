//
//  TSFAppDelegateSpec.m
//  Three Sixty Feedback
//
//  Created by Jurre Stender on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "kiwi.h"
#import "TSFAPIClient.h"

SPEC_BEGIN(TSFAppDelegateSpec)

describe(@"TSFAppDelegate", ^{
    it(@"parses assessor tokens", ^{
        NSURL *assessorURL =
            [NSURL URLWithString:@"feedback://assessor?token=12345"];
        [[[UIApplication sharedApplication] delegate] application:[KWMock mock]
                                                    handleOpenURL:assessorURL];
        [[[TSFAPIClient sharedClient].assessorToken should] equal:@"12345"];
	});
});

SPEC_END
