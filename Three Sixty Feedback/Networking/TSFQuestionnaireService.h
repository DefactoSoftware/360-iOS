//
//  TSFQuestionnaireService.h
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSFAPIClient.h"
#import "TSFQuestionnaireMapper.h"

static NSString *const TSFAPIEndPointQuestionnaires = @"questionnaires";

@interface TSFQuestionnaireService : NSObject

@property (nonatomic, strong) TSFAPIClient *apiClient;

+ (TSFQuestionnaireService *)sharedService;
- (void)questionnairesWithToken:(NSString *)token
                        success:(TSFNetworkingSuccessBlock)success
                        failure:(TSFNetworkingErrorBlock)failure;

@end
