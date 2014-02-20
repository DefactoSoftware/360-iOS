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
    __block id _mockUserMapper;
    
    beforeEach ( ^{
        _sessionService = [TSFSessionService sharedService];
        _mockAPIClient = [KWMock mockForClass:[TSFAPIClient class]];
        _mockUserMapper = [KWMock mockForClass:[TSFUserMapper class]];
        _sessionService.apiClient = _mockAPIClient;
        _sessionService.userMapper = _mockUserMapper;
	});
    
    it(@"instantiates correctly", ^{
        [[_sessionService should] beKindOfClass:[TSFSessionService class]];
	});
    
    it(@"has an instance of the APIClient", ^{
        [[_sessionService.apiClient should] beKindOfClass:[TSFAPIClient class]];
	});
    
    it(@"has an instance of a UserMapper", ^{
        [[_sessionService.userMapper should] beKindOfClass:[TSFUserMapper class]];
    });
    
    context(@"creating a new session", ^{
        __block NSString *_sampleEmail = [NSString stringWithFormat:@"%d", arc4random()];
        __block NSString *_samplePassword = [NSString stringWithFormat:@"%d", arc4random()];
        __block NSDictionary *_sampleResponse = @{ @"first_name": [NSString stringWithFormat:@"%d", arc4random()] };
        __block TSFUser *_stubUser = [[TSFUser alloc] init];
        
        it(@"calls the APIClient to POST the user", ^{
            NSDictionary *expectedParameters = @{ @"email": _sampleEmail, @"password": _samplePassword };
            [[_mockAPIClient should] receive:@selector(POST:parameters:success:failure:)
                               withArguments:TSFAPIEndPointSessions, expectedParameters, [KWAny any], [KWAny any]];
            
            
            [_sessionService createNewSessionWithEmail:_sampleEmail password:_samplePassword success:^(id user) {} failure:^(NSError *error) {}];
        });
        
        it(@"parses the responded user and returns this in the success block", ^{
            [_mockAPIClient stub:@selector(POST:parameters:success:failure:) withBlock:^id(NSArray *params) {
                void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) = params[2];
                successBlock(nil, _sampleResponse);
                return nil;
            }];
            [[_mockUserMapper should] receive:@selector(userWithDictionary:) andReturn:_stubUser withArguments:_sampleResponse];

            [_sessionService createNewSessionWithEmail:_sampleEmail password:_samplePassword success:^(TSFUser *user) {
                [[user should] equal:_stubUser];
            } failure:^(NSError *error) {}];
        });
        
        it(@"assigns the signed in user to itself", ^{
            [_mockAPIClient stub:@selector(POST:parameters:success:failure:) withBlock:^id(NSArray *params) {
                void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) = params[2];
                successBlock(nil, _sampleResponse);
                return nil;
            }];
            [[_mockUserMapper should] receive:@selector(userWithDictionary:) andReturn:_stubUser withArguments:_sampleResponse];
            
            [_sessionService createNewSessionWithEmail:_sampleEmail password:_samplePassword success:^(TSFUser *user) {
                [[_sessionService.signedInUser should] equal:_stubUser];
            } failure:^(NSError *error) {}];
        });
    });
    
    context(@"deleting the current session", ^{
        it(@"calls the APIClient to DELETE the session", ^{
            [[_mockAPIClient should] receive:@selector(DELETE:parameters:success:failure:)
                               withArguments:TSFAPIEndPointSessionDelete, [KWAny any], [KWAny any], [KWAny any]];
            [_sessionService deleteCurrentSessionWithSuccess:^(id response) {
            } failure:^(NSError *error) {
                
            }];
        });
    });
});

SPEC_END