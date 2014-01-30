//
//  TSFCompetenceServiceSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis on 30/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFCompetenceService.h"

SPEC_BEGIN(TSFCompetenceServiceSpec)

describe(@"TSFCompetenceService", ^{
    __block TSFCompetenceService *_competenceService;
    __block id _mockAPIClient;
    __block id _mockCompetenceMapper;
    
    beforeEach ( ^{
        _competenceService = [TSFCompetenceService sharedService];
        _mockAPIClient = [KWMock mockForClass:[TSFAPIClient class]];
        _mockCompetenceMapper = [KWMock mockForClass:[TSFCompetenceMapper class]];
        _competenceService.apiClient = _mockAPIClient;
        _competenceService.competenceMapper = _mockCompetenceMapper;
	});
    
    it(@"instantiates correctly", ^{
        [[_competenceService should] beKindOfClass:[TSFCompetenceService class]];
	});
    
    it(@"has an instance of the APIClient", ^{
        [[_competenceService.apiClient should] beKindOfClass:[TSFAPIClient class]];
	});
    
    it(@"calls the API to update a competence", ^{
        TSFQuestionnaire *questionnaire = [[TSFQuestionnaire alloc] init];
        questionnaire.questionnaireId = @(arc4random());
        TSFCompetence *competence = [[TSFCompetence alloc] init];
        competence.competenceId = @(arc4random());
        
        __block NSString *_fakeToken = [NSString stringWithFormat:@"%d", arc4random()];
        __block NSString *_expectedRequestURL = [NSString stringWithFormat:@"%@%@/%@/%@/%@?token=%@",
                                                 TSFAPIBaseURL,
                                                 TSFAPIEndPointQuestionnaires,
                                                 questionnaire.questionnaireId,
                                                 TSFAPIEndPointCompetences,
                                                 competence.competenceId,
                                                 _fakeToken];
        __block NSDictionary *_stubResponseDictionary = @{};
        __block TSFCompetence *_stubResponseCompetence = [[TSFCompetence alloc] init];
        
        [[_mockCompetenceMapper should] receive:@selector(dictionaryWithCompetence:)
                                      andReturn:_stubResponseDictionary
                                  withArguments:competence];
        
        [[_mockCompetenceMapper should] receive:@selector(competenceWithDictionary:)
                                      andReturn:_stubResponseCompetence
                                  withArguments:_stubResponseDictionary];
        
        [_mockAPIClient stub:@selector(assessorToken) andReturn:_fakeToken];
        
        [_mockAPIClient stub:@selector(PUT:parameters:success:failure:) withBlock: ^id (NSArray *params) {
            NSString *URL = params[0];
            NSDictionary *parameters = params[1];
            void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) = params[2];
            
            [[URL should] equal:_expectedRequestURL];
            [[parameters should] equal:_stubResponseDictionary];
            successBlock(nil, _stubResponseDictionary);
            return nil;
		}];
        
        [_competenceService updateCompetence:competence
                            forQuestionnaire:questionnaire
                                 withSuccess: ^(TSFCompetence *updatedCompetence) {
                                     [[updatedCompetence should] equal:_stubResponseCompetence];
                                 } failure: ^(NSError *error) {
                                 }];
	});
});

SPEC_END
