//
//  TSFAssessorService.h
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSFAPIClient.h"
#import "TSFQuestionnaireService.h"
#import "TSFAssessorMapper.h"

static NSString *const TSFAPIEndPointCurrentAssessor = @"assessors/current";
static NSString *const TSFAPIEndPointAssessors = @"assessors";

@interface TSFAssessorService : NSObject

@property (nonatomic, strong) TSFAPIClient *apiClient;
@property (nonatomic, strong) TSFAssessorMapper *assessorMapper;

+ (TSFAssessorService *)sharedService;
- (void)completeCurrentAssessmentWithSuccess:(TSFNetworkingSuccessBlock)success
                                     failure:(TSFNetworkingErrorBlock)failure;
- (void)assessorsForQuestionnaireId:(NSNumber *)questionnaireId
                        withSuccess:(TSFNetworkingSuccessBlock)success
                            failure:(TSFNetworkingErrorBlock)failure;
@end
