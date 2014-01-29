//
//  TSFAPIClient.h
//  Three Sixty Feedback
//
//  Created by Girgis on 28/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

static NSString *const TSFAPIBaseURL = @"http://backend360staging.herokuapp.com/api/v1/";

@interface TSFAPIClient : AFHTTPRequestOperationManager

+ (TSFAPIClient *)sharedClient;
    
@end
