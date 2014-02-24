//
//  TSFUser.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 20-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSFUser : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *authToken;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSArray *groupIds;

@end
