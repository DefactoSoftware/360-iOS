//
//  TSFCompetence.h
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSFKeyBehaviourMapper.h"

@interface TSFCompetence : NSObject

@property (nonatomic, strong) NSNumber *competenceId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSArray *keyBehaviours;

@end
