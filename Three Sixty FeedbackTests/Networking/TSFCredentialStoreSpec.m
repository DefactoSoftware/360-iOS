//
//  TSFCredentialStoreSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 09-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFCredentialStore.h"

SPEC_BEGIN(TSFCredentialStoreSpec)

describe(@"TSFCredentialStore", ^{
    __block TSFCredentialStore *_credentialStore;
    __block id _mockKeychain;
    
    beforeEach ( ^{
        _credentialStore = [[TSFCredentialStore alloc] init];
        _mockKeychain = [SSKeychain mock];
	});
    
    it(@"stores the email address", ^{
        NSString *randomEmail = [NSString stringWithFormat:@"%d", arc4random()];
        [[SSKeychain should] receive:@selector(setPassword:forService:account:)
                       withArguments:randomEmail, TSFKeychainServiceName, TSFKeychainEmailKey];
        [_credentialStore storeEmail:randomEmail];
	});
    
    it(@"returns the stored email address", ^{
        NSString *randomEmail = [NSString stringWithFormat:@"%d", arc4random()];
        [SSKeychain stub:@selector(passwordForService:account:)
               andReturn:randomEmail
           withArguments:TSFKeychainServiceName, TSFKeychainEmailKey];
        [[[_credentialStore storedEmail] should] equal:randomEmail];
    });
    
    it(@"stores the authorization token", ^{
        NSString *randomAuthToken = [NSString stringWithFormat:@"%d", arc4random()];
        [[SSKeychain should] receive:@selector(setPassword:forService:account:)
                       withArguments:randomAuthToken, TSFKeychainServiceName, TSFKeychainTokenKey];
        [_credentialStore storeToken:randomAuthToken];
    });
    
    it(@"returns the stored authorization token", ^{
        NSString *randomAuthToken = [NSString stringWithFormat:@"%d", arc4random()];
        [SSKeychain stub:@selector(passwordForService:account:)
                andReturn:randomAuthToken
            withArguments:TSFKeychainServiceName, TSFKeychainTokenKey];
        [[[_credentialStore storedToken] should] equal:randomAuthToken];
    });
    
    it(@"removes the stored email address", ^{
        [[SSKeychain should] receive:@selector(deletePasswordForService:account:)
                       withArguments:TSFKeychainServiceName, TSFKeychainEmailKey];
        [_credentialStore removeStoredEmail];
    });
    
    it(@"removes the stored authorization token", ^{
        [[SSKeychain should] receive:@selector(deletePasswordForService:account:)
                       withArguments:TSFKeychainServiceName, TSFKeychainTokenKey];
        [_credentialStore removeStoredToken];
    });
});

SPEC_END