//
//  TSFAssessorMapperSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 24-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFAssessorMapper.h"

SPEC_BEGIN(TSFAssessorMapperSpec)

describe(@"TSFAssessorMapper", ^{
    __block NSArray *_sampleDictionaryArray = @[
                                                @{
                                                    @"id" : @(arc4random()),
                                                    @"token" : [NSString stringWithFormat:@"%d", arc4random()],
                                                    @"email" : [NSString stringWithFormat:@"%d", arc4random()],
                                                    @"completed" : @YES
                                                    },
                                                @{
                                                    @"id" : @(arc4random()),
                                                    @"token" : [NSString stringWithFormat:@"%d", arc4random()],
                                                    @"email" : [NSString stringWithFormat:@"%d", arc4random()],
                                                    @"completed" : @YES
                                                    },
                                                ];
    __block TSFAssessorMapper *_assessorMapper;
    
    beforeEach ( ^{
        _assessorMapper = [[TSFAssessorMapper alloc] init];
	});
    
    it(@"maps an assessor correctly", ^{
        NSDictionary *assessorDictionary = [_sampleDictionaryArray firstObject];
        
        TSFAssessor *assessor = [_assessorMapper assessorWithDictionary:[_sampleDictionaryArray firstObject]];
        
        [[assessor.assessorId should] equal:assessorDictionary[@"id"]];
        [[assessor.token should] equal:assessorDictionary[@"token"]];
        [[assessor.email should] equal:assessorDictionary[@"email"]];
        [[theValue(assessor.completed) should] equal:theValue([assessorDictionary[@"completed"] boolValue])];
	});
    
    it(@"maps an array of assessors correctly", ^{
        NSArray *assessors = [_assessorMapper assessorsWithDictionaryArray:_sampleDictionaryArray];
        
        [[[assessors should] have:[_sampleDictionaryArray count]] items];
        [[[assessors firstObject] should] beKindOfClass:[TSFAssessor class]];
	});
});

SPEC_END
