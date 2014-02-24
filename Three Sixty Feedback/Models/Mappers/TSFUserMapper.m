//
//  TSFUserMapper.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 20-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFUserMapper.h"

@implementation TSFUserMapper

- (TSFUser *)userWithDictionary:(NSDictionary *)dictionary {
    TSFUser *user = [[TSFUser alloc] init];
    
    user.firstName = dictionary[@"first_name"];
    user.lastName = dictionary[@"last_name"];
    user.email = dictionary[@"email"];
    user.role = dictionary[@"role"];
    user.authToken = dictionary[@"auth_token"];
    user.groupIds = dictionary[@"group_ids"];
    
    return user;
}

@end