//
//  NSNotificationCenter+Exten.h
//  test
//
//  Created by qmtv on 2018/4/16.
//  Copyright © 2018年 clOud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (Exten)

- (void)qm_addObsever:(id)obsever name:(NSNotificationName)name object:(id)obj usingBlock:(void(^)(NSNotification*notif))block;
- (void)qm_removeObserver:(id)observer name:(NSNotificationName)aName object:(id)anObject;
- (void)qm_removeObserver:(id)observer;

@end
