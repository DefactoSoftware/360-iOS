//
//  TSFGenerics.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 31-01-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#ifndef Three Sixty Feedback_CPMGenerics_h
#define Three Sixty Feedback_CPMGenerics_h

static inline NSString * TSFLocalizedString(NSString *key, NSString *defaultValue) {
    return NSLocalizedStringWithDefaultValue(key, nil, [NSBundle mainBundle], defaultValue, nil);
}

static inline NSString * TSFLocalizedStringWithComment(NSString *key, NSString *defaultValue, NSString *comment) {
    return NSLocalizedStringWithDefaultValue(key, nil, [NSBundle mainBundle], defaultValue, comment);
}

#endif
