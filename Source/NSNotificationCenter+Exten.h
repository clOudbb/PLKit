//
//  NSNotificationCenter+Exten.h
//  test
//
//  Created by qmtv on 2018/4/16.
//  Copyright © 2018年 clOud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (Exten)

- (void)pl_addObsever:(id)obsever name:(NSNotificationName)name object:(id)obj usingBlock:(void(^)(NSNotification*notif))block;
- (void)pl_removeObserver:(id)observer name:(NSNotificationName)aName object:(id)anObject;
- (void)pl_removeObserver:(id)observer;

@end
