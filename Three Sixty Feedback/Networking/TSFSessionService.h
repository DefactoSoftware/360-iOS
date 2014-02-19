//
//  TSFSessionService.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 19-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSFAPIClient.h"

@interface TSFSessionService : NSObject
@property (nonatomic, strong) TSFAPIClient *apiClient;

+ (TSFSessionService *)sharedService;
@end
