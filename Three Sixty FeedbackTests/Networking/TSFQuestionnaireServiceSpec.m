//
//  TSFQuestionnaireServiceSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFQuestionnaireService.h"

SPEC_BEGIN(TSFQuestionnaireServiceSpec)

describe(@"TSFQuestionnaireService", ^{
  __block TSFQuestionnaireService *_questionnaireService;
  __block id _mockAPIClient;

  beforeEach (^{
    _questionnaireService = [TSFQuestionnaireService sharedService];
    _mockAPIClient = [KWMock mockForClass:[TSFAPIClient class]];
    _questionnaireService.apiClient = _mockAPIClient;
  });

  it(@"instantiates correctly", ^{
    [[_questionnaireService should]
        beKindOfClass:[TSFQuestionnaireService class]];
  });

  it(@"has an instance of the APIClient", ^{
    [[_questionnaireService.apiClient should]
        beKindOfClass:[TSFAPIClient class]];
  });
});

SPEC_END