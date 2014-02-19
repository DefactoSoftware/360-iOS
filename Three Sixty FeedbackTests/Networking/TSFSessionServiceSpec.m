//
//  TSFSessionServiceSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 19-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFSessionService.h"

SPEC_BEGIN(TSFSessionServiceSpec)

describe(@"TSFSessionService", ^{
    __block TSFSessionService *_sessionService;
    __block id _mockAPIClient;
    
    beforeEach ( ^{
        _sessionService = [TSFSessionService sharedService];
        _mockAPIClient = [KWMock mockForClass:[TSFAPIClient class]];
        _sessionService.apiClient = _mockAPIClient;
	});
    
    it(@"instantiates correctly", ^{
        [[_sessionService should] beKindOfClass:[TSFSessionService class]];
	});
    
    it(@"has an instance of the APIClient", ^{
        [[_sessionService.apiClient should] beKindOfClass:[TSFAPIClient class]];
	});
});

SPEC_END