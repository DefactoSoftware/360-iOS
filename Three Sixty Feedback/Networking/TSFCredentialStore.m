//
//  TSFCredentialStore.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 09-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFCredentialStore.h"

@implementation TSFCredentialStore

- (BOOL)storeEmail:(NSString *)email {
    return [SSKeychain setPassword:email
                        forService:TSFKeychainServiceName
                           account:TSFKeychainEmailKey];
}

- (NSString *)storedEmail {
    return [SSKeychain passwordForService:TSFKeychainServiceName
                                  account:TSFKeychainEmailKey];
}

- (BOOL)storeToken:(NSString *)token {
    return [SSKeychain setPassword:token
                        forService:TSFKeychainServiceName
                           account:TSFKeychainTokenKey];
}

- (NSString *)storedToken {
    return [SSKeychain passwordForService:TSFKeychainServiceName
                                  account:TSFKeychainTokenKey];
}

- (BOOL)removeStoredEmail {
    return [SSKeychain deletePasswordForService:TSFKeychainServiceName
                                        account:TSFKeychainEmailKey];
}

- (BOOL)removeStoredToken {
    return [SSKeychain deletePasswordForService:TSFKeychainServiceName
                                        account:TSFKeychainTokenKey];
}

- (BOOL)hasStoredCredentials {
    return [self storedEmail] && [self storedToken];
}

@end
