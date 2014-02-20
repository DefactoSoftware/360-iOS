//
//  TSFUserMapper.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 20-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSFUser.h"

@interface TSFUserMapper : NSObject

- (TSFUser *)userWithDictionary:(NSDictionary *)dictionary;

@end
