//
//  TSFTemplateService.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSFTemplateMapper.h"
#import "TSFAPIClient.h"

static NSString *const TSFAPIEndPointTemplates = @"templates";

@interface TSFTemplateService : NSObject

@property (nonatomic, strong) TSFAPIClient *apiClient;
@property (nonatomic, strong) TSFTemplateMapper *templateMapper;

+ (TSFTemplateService *)sharedService;
- (void)templatesWithSuccess:(TSFNetworkingSuccessBlock)success
                     failure:(TSFNetworkingErrorBlock)failure;

@end
