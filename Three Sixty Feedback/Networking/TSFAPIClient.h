//
//  TSFAPIClient.h
//  Three Sixty Feedback
//
//  Created by Girgis on 28/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

static NSString *const TSFAPIBaseURL =
@"http://backend360staging.herokuapp.com/api/v1/";

typedef void (^TSFNetworkingSuccessBlock)(id);
typedef void (^TSFNetworkingErrorBlock)(NSError *);

@interface TSFAPIClient : AFHTTPRequestOperationManager

@property (nonatomic, strong) NSString *assessorToken;

+ (TSFAPIClient *)sharedClient;

- (void)setAssessorTokenWithURL:(NSURL *)url;

@end
