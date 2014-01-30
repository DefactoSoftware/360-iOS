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
@property (nonatomic, strong) TSFQuestionnaireMapper *questionnaireMapper;

+ (TSFQuestionnaireService *)sharedService;
- (void)questionnairesWithSuccess:(TSFNetworkingSuccessBlock)success
                          failure:(TSFNetworkingErrorBlock)failure;

@end
