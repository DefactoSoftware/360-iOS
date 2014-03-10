//
//  TSFCredentialStore.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 09-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSKeychain.h"

static NSString *const TSFKeychainServiceName = @"TSF";
static NSString *const TSFKeychainEmailKey = @"email";
static NSString *const TSFKeychainTokenKey = @"token";

@interface TSFCredentialStore : NSObject

- (BOOL)storeEmail:(NSString *)email;
- (NSString *)storedEmail;
- (BOOL)storeToken:(NSString *)token;
- (NSString *)storedToken;

@end
