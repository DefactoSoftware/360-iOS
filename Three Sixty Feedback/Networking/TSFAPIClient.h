//
//  TSFAPIClient.h
//  Three Sixty Feedback
//
//  Created by Girgis on 28/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "TSFSessionService.h"
#import "TSFNetworkingBlocks.h"

static NSString *const TSFAPIBaseURL = @"https://backend360staging.herokuapp.com/api/v1/";
static NSString *const TSFAPIHeaderFieldFrom = @"From";
static NSString *const TSFAPIHeaderFieldAuthorization = @"Authorization";

@class TSFSessionService;

@interface TSFAPIClient : AFHTTPRequestOperationManager

@property (nonatomic, strong) NSString *assessorToken;
@property (nonatomic, strong) TSFSessionService *sessionService;

+ (TSFAPIClient *)sharedClient;

- (void)setAssessorTokenWithURL:(NSURL *)url;

@end