//
//  TSFAPIClient.m
//  Three Sixty Feedback
//
//  Created by Girgis on 28/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFAPIClient.h"

@implementation TSFAPIClient

+ (instancetype)sharedClient {
  static TSFAPIClient *_sharedClient = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedClient =
        [[self alloc] initWithBaseURL:[NSURL URLWithString:TSFAPIBaseURL]];
  });

  return _sharedClient;
}

@end
