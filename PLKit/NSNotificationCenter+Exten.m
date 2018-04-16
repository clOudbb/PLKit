//
//  NSNotificationCenter+Exten.m
//  test
//
//  Created by qmtv on 2018/4/16.
//  Copyright © 2018年 clOud. All rights reserved.
//

#import "NSNotificationCenter+Exten.h"
#import <objc/runtime.h>
#import <objc/message.h>

typedef NSString * ObseverName;
@interface _NotificationDispatch :NSObject

@property (nonatomic, copy, nullable) void(^method_block)(NSNotification *notif);
@property (nonatomic, copy, nullable) NSString * name;
@property (nonatomic, strong, nullable) ObseverName obsever;

@end

@implementation _NotificationDispatch

@end

@interface NSNotificationCenter (_Exten)

@property (nonatomic, strong, nullable) NSMutableSet *notificationSet;

@end

@implementation NSNotificationCenter (_Exten)

- (void)setNotificationSet:(NSMutableSet *)notificationSet
{
    objc_setAssociatedObject(self, @selector(notificationSet), notificationSet, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableSet *)notificationSet
{
    return objc_getAssociatedObject(self, _cmd);

}

@end

struct QMContext {
    void *_set;
    void *name;
    void *obsever;
};

@implementation NSNotificationCenter (Exten)

- (void)qm_addObsever:(id)obsever name:(NSNotificationName)name object:(id)obj usingBlock:(void(^)(NSNotification*notif))block
{
    _NotificationDispatch *disp = [_NotificationDispatch new];
    disp.name = name;
    disp.method_block = block;
    disp.obsever = NSStringFromClass([obsever class]);
    if (!self.notificationSet) {
        self.notificationSet = [@[] mutableCopy];
    }
    [self.notificationSet addObject:disp];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(action:) name:name object:obj];
}

void enmuerateRemoveObject(const void *obj, void * context)
{
    _NotificationDispatch *dis = (__bridge id)obj;
    struct QMContext *_context = context;
    NSMutableSet *set = (__bridge NSMutableSet *)(_context->_set);
    NSNotificationName name = (__bridge NSNotificationName)_context->name;
    ObseverName obsever = (__bridge ObseverName)_context->obsever;
    if ([dis.name isEqualToString:name] && [obsever isEqualToString:dis.obsever]) {
        ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)set, @selector(removeObject:), dis);
        ((void (*)(id, SEL, id, id, id))(void *)objc_msgSend)((id)NSNotificationCenter.defaultCenter, @selector(removeObserver:name:object:), obsever, name, nil);
    }
}

- (void)qm_removeObserver:(id)observer name:(NSNotificationName)aName object:(id)anObject
{
    if (self.notificationSet) {
        CFMutableSetRef _set = CFSetCreateMutableCopy(CFAllocatorGetDefault(), 0, (__bridge const void *)self.notificationSet);
        struct QMContext context = {0};
        context.name = (__bridge void *)aName;
        context._set = (__bridge void *)self.notificationSet;
        context.obsever = (__bridge void *)NSStringFromClass([observer class]);
        CFSetApplyFunction(_set, enmuerateRemoveObject, &context);
        CFRelease(_set);
    }
}

void enmuerateRemoveObjectWithTarget(const void *obj, void * context)
{
    _NotificationDispatch *dis = (__bridge id)obj;
    struct QMContext *_context = context;
    NSMutableSet *set = (__bridge NSMutableSet *)(_context->_set);
    ObseverName obsever = (__bridge ObseverName)_context->obsever;
    if ([obsever isEqualToString:dis.obsever]) {
        ((void (*)(id, SEL, id))(void *)objc_msgSend)((id)set, @selector(removeObject:), dis);
        ((void (*)(id, SEL, id, id, id))(void *)objc_msgSend)((id)NSNotificationCenter.defaultCenter, @selector(removeObserver:name:object:), obsever, dis.name, nil);
    }
}

- (void)qm_removeObserver:(id)observer
{
    if (self.notificationSet) {
        CFMutableSetRef _set = CFSetCreateMutableCopy(CFAllocatorGetDefault(), 0, (__bridge const void *)self.notificationSet);
        struct QMContext context = {0};
        context._set = (__bridge void *)self.notificationSet;
        context.obsever = (__bridge void *)NSStringFromClass([observer class]);
        CFSetApplyFunction(_set, enmuerateRemoveObjectWithTarget, &context);
        CFRelease(_set);
    }
}


- (void)action:(NSNotification *)notif
{
    if (notif.object) {
        [self.notificationSet enumerateObjectsUsingBlock:^(_NotificationDispatch *  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([notif.name isEqualToString:obj.name]) {
                if (obj.method_block) {
                    obj.method_block(notif);
                }
            }
        }];
    }
}
@end
