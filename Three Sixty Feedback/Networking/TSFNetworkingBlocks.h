//
//  TSFNetworkingBlocks.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TSFNetworkingBlocks <NSObject>
typedef void (^TSFNetworkingSuccessBlock)(id);
typedef void (^TSFNetworkingErrorBlock)(NSError *);
@end