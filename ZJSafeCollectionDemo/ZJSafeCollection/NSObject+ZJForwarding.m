//
//  NSObject+ZJForwarding.m
//  ZJSafeCollection
//
//  Created by watchnail on 2018/1/18.
//  Copyright © 2018年 watchnail. All rights reserved.
//

#import "NSObject+ZJForwarding.h"
#import <objc/runtime.h>
#warning 'ZJTestClass' only test class
#import "ZJTestClass.h"
@implementation NSObject (ZJForwarding)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

static bool ZJForwardingLogEnabled = YES;

void remedyMethod (id self,SEL _cmd)
{
    if(ZJForwardingLogEnabled) {
        Class cs = object_getClass(self);
        NSLog(@"[%@ %@] unrecognized selector",NSStringFromClass(cs),NSStringFromSelector(_cmd));
    }
    return;
}
+ (BOOL)resolveClassMethod:(SEL)sel {
#warning 'ZJTestClass' only test class
    Class metaClass = object_getClass([ZJTestClass class]);
    if([self isKindOfClass:[metaClass class]]) {
        class_addMethod(metaClass, sel, (IMP)remedyMethod, "v@:");
    }
    return YES;
}
- (id)forwardingTargetForSelector:(SEL)aSelector {
#warning 'ZJTestClass' only test class
    if([self isKindOfClass:[UIResponder class]]|| [self isKindOfClass:[ZJTestClass class]] || [self isKindOfClass:[NSNull class]]) {
        Class ZJProtectorCls = NSClassFromString(@"ZJProtector");
        if(!ZJProtectorCls) {
            ZJProtectorCls = objc_allocateClassPair([NSObject class], "ZJProtector", 0);
            objc_registerClassPair(ZJProtectorCls);
        }
        class_addMethod(ZJProtectorCls, aSelector, (IMP)remedyMethod, "v@:");

        Class ZJProtector = [ZJProtectorCls class];
        id instance = [[ZJProtector alloc] init];
        return instance;
    
    }
    else {
        return nil;
    }

}
+ (void)setLogEnabled:(BOOL)enabled {
    ZJForwardingLogEnabled = enabled;
}
#pragma clang diagnostic pop
@end
