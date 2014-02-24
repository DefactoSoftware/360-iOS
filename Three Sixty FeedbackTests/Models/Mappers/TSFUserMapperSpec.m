//
//  TSFUserMapperSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 20-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFUserMapper.h"

SPEC_BEGIN(TSFUserMapperSpec)

describe(@"TSFUserMapper", ^{
    __block NSDictionary *_sampleDictionary = @{
                                                @"first_name": [NSString stringWithFormat:@"%d", arc4random()],
                                                @"last_name": [NSString stringWithFormat:@"%d", arc4random()],
                                                @"email": [NSString stringWithFormat:@"%d", arc4random()],
                                                @"role": [NSString stringWithFormat:@"%d", arc4random()],
                                                @"auth_token": [NSString stringWithFormat:@"%d", arc4random()],
                                                @"user_role": [NSString stringWithFormat:@"%d", arc4random()],
                                                @"group_ids": @[ @(arc4random()), @(arc4random()) ]
                                                };
    __block TSFUserMapper *_userMapper;
    
    beforeEach ( ^{
        _userMapper = [[TSFUserMapper alloc] init];
	});
    
    it(@"maps a user correctly", ^{
        TSFUser *user = [_userMapper userWithDictionary:_sampleDictionary];
        
        [[user.firstName should] equal:_sampleDictionary[@"first_name"]];
        [[user.lastName should] equal:_sampleDictionary[@"last_name"]];
        [[user.email should] equal:_sampleDictionary[@"email"]];
        [[user.authToken should] equal:_sampleDictionary[@"auth_token"]];
        [[user.role should] equal:_sampleDictionary[@"role"]];
        [[theValue([user.groupIds count]) should] equal:theValue([_sampleDictionary[@"group_ids"] count])];
        [[[user.groupIds firstObject] should] equal:[_sampleDictionary[@"group_ids"] firstObject]];
	});
});

SPEC_END
