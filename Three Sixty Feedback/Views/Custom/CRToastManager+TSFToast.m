//
//  CRToastManager+TSFToast.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 06-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "CRToastManager+TSFToast.h"
#import "UIColor+TSFColor.h"

@implementation CRToastManager (TSFToast)

+ (void)showErrorNotificationWithMessage:(NSString *)message
                         completionBlock:(void (^)(void))completion {
    NSDictionary *options = @{kCRToastTextKey : message,
                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                              kCRToastBackgroundColorKey : [UIColor redColor]};
    [CRToastManager showNotificationWithOptions:options completionBlock:completion];
}

+ (void)showErrorNotificationWithMessage:(NSString *)message
                                   error:(NSError *)error
                         completionBlock:(void (^)(void))completion {
    [CRToastManager showErrorNotificationWithMessage:message completionBlock:completion];
    NSLog(@"%@ - Error: %@.", message, error);
}

@end
