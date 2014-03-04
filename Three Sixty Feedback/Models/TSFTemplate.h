//
//  TSFTemplate.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSFCompetence.h"
#import "TSFKeyBehaviour.h"

@interface TSFTemplate : NSObject

@property (nonatomic, strong) NSNumber *templateId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *templateDescription;
@property (nonatomic, strong) NSArray *questions;
@property (nonatomic, strong) NSArray *competences;

@end
