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
	});
    
	return _sharedService;
}

@end
