//
//  CRToastManager+TSFToast.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 06-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "CRToast.h"

@interface CRToastManager (TSFToast)

+ (void)showErrorNotificationWithMessage:(NSString *)message
                         completionBlock:(void (^)(void))completion;
+ (void)showErrorNotificationWithMessage:(NSString *)message
                                   error:(NSError *)error
                         completionBlock:(void (^)(void))completion;

@end
