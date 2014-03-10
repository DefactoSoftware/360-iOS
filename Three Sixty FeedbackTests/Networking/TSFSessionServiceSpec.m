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
    __block id _mockCredentialStore;
    
    beforeEach ( ^{
        _sessionService = [TSFSessionService sharedService];
        _mockAPIClient = [KWMock mockForClass:[TSFAPIClient class]];
        _mockUserMapper = [KWMock mockForClass:[TSFUserMapper class]];
        _mockCredentialStore = [KWMock mockForClass:[TSFCredentialStore class]];
        _sessionService.apiClient = _mockAPIClient;
        _sessionService.userMapper = _mockUserMapper;
        _sessionService.credentialStore = _mockCredentialStore;
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
    
    it(@"has an instance of the credentialstore", ^{
        [[_sessionService.credentialStore should] beKindOfClass:[TSFCredentialStore class]];
    });
    
    context(@"creating a new session", ^{
        __block NSString *_sampleEmail = [NSString stringWithFormat:@"%d", arc4random()];
        __block NSString *_samplePassword = [NSString stringWithFormat:@"%d", arc4random()];
        __block NSString *_sampleToken = [NSString stringWithFormat:@"%d", arc4random()];
        __block NSDictionary *_sampleResponse = @{ @"auth_token": _sampleToken };
        __block TSFUser *_stubUser = [[TSFUser alloc] init];
        
        beforeEach(^{
            _stubUser.authToken = _sampleToken;
            _stubUser.email = _sampleEmail;
        });
        
        it(@"calls the APIClient to POST the user", ^{
            NSDictionary *expectedParameters = @{ @"email": _sampleEmail, @"password": _samplePassword };
            [[_mockAPIClient should] receive:@selector(POST:parameters:success:failure:)
                               withArguments:TSFAPIEndPointSessions, expectedParameters, [KWAny any], [KWAny any]];
            
            
            [_sessionService createNewSessionWithEmail:_sampleEmail
                                              password:_samplePassword
                                               success:^(id user) {}
                                               failure:^(NSError *error) {}];
        });
        
        it(@"parses the responded user and returns this in the success block", ^{
            [_mockAPIClient stub:@selector(POST:parameters:success:failure:)
                       withBlock:^id(NSArray *params) {
                void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) = params[2];
                successBlock(nil, _sampleResponse);
                return nil;
            }];
            [[_mockUserMapper should] receive:@selector(userWithDictionary:)
                                    andReturn:_stubUser
                                withArguments:_sampleResponse];
            [[_mockCredentialStore should] receive:@selector(storeEmail:)];
            [[_mockCredentialStore should] receive:@selector(storeToken:)];
            
            [_sessionService createNewSessionWithEmail:_sampleEmail
                                              password:_samplePassword
                                               success:^(TSFUser *user) {
                [[user should] equal:_stubUser];
            } failure:^(NSError *error) {}];
        });

        it(@"assigns the signed in user to itself", ^{
            [_mockAPIClient stub:@selector(POST:parameters:success:failure:)
                       withBlock:^id(NSArray *params) {
                void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) = params[2];
                successBlock(nil, _sampleResponse);
                return nil;
            }];
            [[_mockUserMapper should] receive:@selector(userWithDictionary:)
                                    andReturn:_stubUser
                                withArguments:_sampleResponse];
            [[_mockCredentialStore should] receive:@selector(storeEmail:)];
            [[_mockCredentialStore should] receive:@selector(storeToken:)];
            
            [_sessionService createNewSessionWithEmail:_sampleEmail
                                              password:_samplePassword
                                               success:^(TSFUser *user) {}
                                               failure:^(NSError *error) {}];
        });
        
        it(@"stores the email address and authorization token in the credentialstore", ^{
            [_mockUserMapper stub:@selector(userWithDictionary:)
                        andReturn:_stubUser];
            [_mockAPIClient stub:@selector(POST:parameters:success:failure:)
                       withBlock:^id(NSArray *params) {
                           void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) = params[2];
                           successBlock(nil, _sampleResponse);
                           return nil;
                       }];
            [[_mockCredentialStore should] receive:@selector(storeEmail:)
                                     ];
            [[_mockCredentialStore should] receive:@selector(storeToken:)
                                     withArguments:_sampleToken];
            
            [_sessionService createNewSessionWithEmail:_sampleEmail
                                              password:_samplePassword
                                               success:^(id response) {}
                                               failure:^(NSError *error) {}];
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
        
        it(@"calls the credentiualstore to remove the stored credentials", ^{
            [_mockAPIClient stub:@selector(DELETE:parameters:success:failure:)
                       withBlock:^id(NSArray *params) {
                       void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) = params[2];
                       successBlock(nil, nil);
                       return nil;
                   }];
            [[_mockCredentialStore should] receive:@selector(removeStoredEmail)];
            [[_mockCredentialStore should] receive:@selector(removeStoredToken)];
            
            [_sessionService deleteCurrentSessionWithSuccess:^(id response) {}
                                                     failure:^(NSError *error) {}];
        });
    });
});

SPEC_END