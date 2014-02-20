//
//  TSFSessionService.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 19-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSFAPIClient.h"
#import "TSFUserMapper.h"
#import "TSFUser.h"

static NSString *const TSFAPIEndPointSessions = @"sessions";

@interface TSFSessionService : NSObject

@property (nonatomic, strong) TSFAPIClient *apiClient;
@property (nonatomic, strong) TSFUserMapper *userMapper;

+ (TSFSessionService *)sharedService;
- (void)createNewSessionWithEmail:(NSString *)email
                         password:(NSString *)password
                          success:(TSFNetworkingSuccessBlock)success
                          failure:(TSFNetworkingErrorBlock)failure;

@end
