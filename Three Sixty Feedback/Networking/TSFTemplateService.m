//
//  TSFTemplateService.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFTemplateService.h"

@implementation TSFTemplateService

+ (instancetype)sharedService {
    static TSFTemplateService *_sharedService = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    _sharedService = [[self alloc] init];
	    _sharedService.apiClient = [TSFAPIClient sharedClient];
        _sharedService.templateMapper = [[TSFTemplateMapper alloc] init];
	});
    
	return _sharedService;
}

- (void)templatesWithSuccess:(TSFNetworkingSuccessBlock)success
                     failure:(TSFNetworkingErrorBlock)failure {
    __block TSFNetworkingSuccessBlock _successBlock = success;
    __block TSFNetworkingErrorBlock _failureBlock = failure;
    
    __weak typeof (self) _self = self;
    [self.apiClient GET:TSFAPIEndPointTemplates
             parameters:nil
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSArray *templates = [_self.templateMapper templatesWithDictionaryArray:(NSArray *)responseObject];
                    _successBlock(templates);
    }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    _failureBlock(error);
    }];
}

@end
