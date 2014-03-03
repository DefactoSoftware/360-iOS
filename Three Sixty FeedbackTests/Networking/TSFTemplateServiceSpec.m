//
//  TSFTemplateService.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFTemplateService.h"

SPEC_BEGIN(TSFTemplateServiceSpec)

describe(@"TSFTemplateService", ^{
    __block TSFTemplateService *_templateService;
    __block id _mockAPIClient;
    __block id _mockTemplateMapper;
    
    beforeEach ( ^{
        _templateService = [TSFTemplateService sharedService];
        _mockAPIClient = [KWMock mockForClass:[TSFAPIClient class]];
        _mockTemplateMapper = [KWMock mockForClass:[TSFTemplateMapper class]];
        _templateService.apiClient = _mockAPIClient;
        _templateService.templateMapper = _mockTemplateMapper;
	});
    
    it(@"instantiates correctly", ^{
        [[_templateService should] beKindOfClass:[TSFTemplateService class]];
	});
    
    it(@"has an instance of the APIClient", ^{
        [[_templateService.apiClient should] beKindOfClass:[TSFAPIClient class]];
	});
    
    it(@"has an instance of a UserMapper", ^{
        [[_templateService.templateMapper should] beKindOfClass:[TSFTemplateMapper class]];
    });
    
    context(@"getting the users templates", ^{
        __block NSArray *_sampleResponse = @[ @{ @"id": @(arc4random()) }, @{ @"id": @(arc4random()) } ];
        __block TSFTemplate *_stubTemplate = [[TSFTemplate alloc] init];
        
        it(@"calls the APIClient to GET the templates", ^{
            [[_mockAPIClient should] receive:@selector(GET:parameters:success:failure:)
                               withArguments:TSFAPIEndPointTemplates, [KWAny any], [KWAny any], [KWAny any]];
            
            [_templateService templatesWithSuccess:^(id response) {
            }
                                          failure:^(NSError *error) {
                                          }];
        });
        
        it(@"parses the responded user and returns this in the success block", ^{
            [_mockAPIClient stub:@selector(GET:parameters:success:failure:)
                       withBlock:^id(NSArray *params) {
                void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) = params[2];
                successBlock(nil, _sampleResponse);
                return nil;
            }];
            
            [[_mockTemplateMapper should] receive:@selector(templatesWithDictionaryArray:)
                                        andReturn:@[_stubTemplate]
                                    withArguments:_sampleResponse];
            
            [_templateService templatesWithSuccess:^(NSArray *templatesArray) {
                [[theValue([templatesArray count]) should] equal:theValue(1)];
                [[[templatesArray firstObject] should] equal:_stubTemplate];
            } failure:^(NSError *error) {
                
            }];
        });
    });
});

SPEC_END