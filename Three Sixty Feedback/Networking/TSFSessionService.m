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
    __block typeof (self) _self = self;
    __block TSFNetworkingSuccessBlock _success = success;
    __block TSFNetworkingErrorBlock _failure = failure;
    
    [self.apiClient POST:TSFAPIEndPointSessions parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseUser = (NSDictionary *)responseObject;
        TSFUser *user = [_self.userMapper userWithDictionary:responseUser];
        _self.signedInUser = user;
        _success(user);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _failure(error);
    }];

}

- (void)deleteCurrentSessionWithSuccess:(TSFNetworkingSuccessBlock)success
                                failure:(TSFNetworkingErrorBlock)failure {    
    __weak TSFNetworkingSuccessBlock _success = success;
    __weak TSFNetworkingErrorBlock _failure = failure;
    [self.apiClient DELETE:TSFAPIEndPointSessionDelete
                parameters:nil
                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       _success(@YES);
    }
                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       _failure(error);
    }];
}

@end
