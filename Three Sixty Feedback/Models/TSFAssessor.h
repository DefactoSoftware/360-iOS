//
//  TSFAssessor.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 24-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSFAssessor : NSObject

@property (nonatomic, strong) NSNumber *assessorId;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, assign) BOOL completed;

@end
