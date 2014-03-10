//
//  TSFSessionService.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 19-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSFQuestionnaireService.h"
#import "TSFAPIClient.h"
#import "TSFUserMapper.h"
#import "TSFUser.h"
#import "TSFNetworkingBlocks.h"
#import "TSFCredentialStore.h"

static NSString *const TSFAPIEndPointSessions = @"users/sign_in";
static NSString *const TSFAPIEndPointSessionDelete = @"users/sign_out";
static NSString *const TSFAPIEndPointPassword = @"users/password";

@class TSFAPIClient;

@interface TSFSessionService : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) TSFAPIClient *apiClient;
@property (nonatomic, strong) TSFUserMapper *userMapper;
@property (nonatomic, strong) TSFUser *signedInUser;
@property (nonatomic, strong) TSFCredentialStore *credentialStore;

+ (TSFSessionService *)sharedService;
- (void)createNewSessionWithEmail:(NSString *)email
                         password:(NSString *)password
                          success:(TSFNetworkingSuccessBlock)success
                          failure:(TSFNetworkingErrorBlock)failure;
- (void)deleteCurrentSessionWithSuccess:(TSFNetworkingSuccessBlock)success
                                failure:(TSFNetworkingErrorBlock)failure;

@end