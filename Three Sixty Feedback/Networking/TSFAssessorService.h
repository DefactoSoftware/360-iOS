//
//  TSFAssessorService.h
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSFAPIClient.h"

static NSString *const TSFAPIEndPointCurrentAssessor = @"assessors/current";

@interface TSFAssessorService : NSObject

@property (nonatomic, strong) TSFAPIClient *apiClient;

+ (TSFAssessorService *)sharedService;
- (void)completeCurrentAssessmentWithToken:(NSString *)token
                                   success:(TSFNetworkingSuccessBlock)success
                                   failure:(TSFNetworkingErrorBlock)failure;


@end
