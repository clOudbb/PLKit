//
//  UINavigationController+HandleRespond.m
//  PLKit
//
//  Created by qmtv on 2018/7/18.
//  Copyright © 2018年 clOud. All rights reserved.
//

#import "UINavigationController+HandleRespond.h"
#import <objc/runtime.h>
#import "PLKitDefine.h"
static NSTimeInterval _lastRespondTime = 0;
@implementation UINavigationController (HandleRespond)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL origin = @selector(pushViewController:animated:);
        SEL replace = @selector(qm_responder_pushViewController:animated:);
        Method oldMethod = class_getInstanceMethod(self, origin);
        Method newMethod = class_getInstanceMethod(self, replace);
        if (class_addMethod(self, origin, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
            class_replaceMethod(self, replace, method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod));
        } else {
            method_exchangeImplementations(oldMethod, newMethod);
        }
    });
}

- (void)qm_responder_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSTimeInterval recordTime = [[NSDate date] timeIntervalSince1970] * 1000;
    PLLog(@"ResponderManager  now = %f  last = %f", recordTime, _lastRespondTime);
    if ((recordTime - _lastRespondTime) > 250) {
        _lastRespondTime = recordTime;
        [self qm_responder_pushViewController:viewController animated:animated];
    }
}

@end
