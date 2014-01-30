//
//  TSFCompetenceService.h
//  Three Sixty Feedback
//
//  Created by Girgis on 30/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSFQuestionnaireService.h"
#import "TSFQuestionnaire.h"

static NSString *const TSFAPIEndPointCompetences = @"competences";

@interface TSFCompetenceService : NSObject

@property (nonatomic, strong) TSFAPIClient *apiClient;
@property (nonatomic, strong) TSFCompetenceMapper *competenceMapper;

+ (TSFCompetenceService *)sharedService;
- (void)updateCompetence:(TSFCompetence *)competence
        forQuestionnaire:(TSFQuestionnaire *)questionnaire
             withSuccess:(TSFNetworkingSuccessBlock)success
                 failure:(TSFNetworkingErrorBlock)failure;

@end
