//
//  TSFQuestionnaire.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFQuestionnaire.h"

@implementation TSFQuestionnaire

- (NSInteger)completedAssessors {
    NSInteger countCompletedAssessors = 0;
    for (TSFAssessor *assessor in self.assessors) {
        if (assessor.completed) {
            countCompletedAssessors++;
        }
    }
    return countCompletedAssessors;
}

@end
