//
//  TSFSessionService.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 19-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFSessionService.h"

@implementation TSFSessionService

+ (instancetype)sharedService {
    static TSFSessionService *_sharedService = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    _sharedService = [[self alloc] init];
	    _sharedService.apiClient = [TSFAPIClient sharedClient];
        _sharedService.userMapper = [[TSFUserMapper alloc] init];
	});
    
	return _sharedService;
}

- (void)createNewSessionWithEmail:(NSString *)email
                         password:(NSString *)password
                          success:(TSFNetworkingSuccessBlock)success
                          failure:(TSFNetworkingErrorBlock)failure {
    NSDictionary *parameters = @{ @"email": email, @"password": password };
    
    __weak TSFNetworkingSuccessBlock _success = success;
    __weak typeof(self) _self = self;
    [self.apiClient POST:TSFAPIEndPointSessions
              parameters:parameters
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     TSFUser *user = [_self.userMapper userWithDictionary:(NSDictionary *)responseObject];
                     _success(user);
                     
    }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     
    }];
}

@end
