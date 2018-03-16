//
//  ZJSafeCollection.m
//  ZJSafeCollection
//
//  Created by watchnail on 2018/1/17.
//  Copyright © 2018年 watchnail. All rights reserved.
//

#import "ZJSafeCollection.h"
#import <objc/runtime.h>

static BOOL ZJSafeCollectionLogEnabled = YES;

void ZJSafeCollectionLog(NSString*fmt,...) {
    if (ZJSafeCollectionLogEnabled)
    {
        va_list ap;
        va_start(ap, fmt);
        NSString *content = [[NSString alloc] initWithFormat:fmt arguments:ap];
        NSLog(@"%@", content);
        va_end(ap);
    }
}

#pragma mark - NSArray
@interface NSArray (ZJSafe)
@end

@implementation NSArray (ZJSafe)
- (instancetype)zj_initWithObjects:(id const [])objects count:(NSUInteger)count {
    id validObjects[count];
    NSUInteger newCount = 0;
    for(NSUInteger i = 0; i < count; i++) {
        
        if(objects[i]) {
            validObjects[newCount] = objects[i];
            newCount++;
        }
        else {
            
            ZJSafeCollectionLog(@"[%@ %@] nil object at index {%zd}",NSStringFromClass([self class]),NSStringFromSelector(_cmd),i);
        }
    }
    return [self zj_initWithObjects:validObjects count:newCount];
}
- (id)zj_objectAtIndex:(NSUInteger)index {
    
    if(index >= self.count) {
        ZJSafeCollectionLog(@"[%@ %@] index {%zd} beyond bounds [0...%zd]",NSStringFromClass([self class]),NSStringFromSelector(_cmd),index,MAX(self.count - 1, 0));
        return nil;
    }
    return [self zj_objectAtIndex:index];
}
- (id)zj_NSArray0objectAtIndex:(NSUInteger)index {
    
    if(index >= self.count) {
        ZJSafeCollectionLog(@"[%@ %@]: index {%zd} beyond bounds [0...%zd]",NSStringFromClass([self class]),NSStringFromSelector(_cmd),index,MAX(self.count - 1, 0));
        return nil;
    }
    return [self zj_NSArray0objectAtIndex:index];
}
- (id)zj_NSSingleObjectArrayIobjectAtIndex:(NSUInteger)index {
    
    if(index >= self.count) {
        ZJSafeCollectionLog(@"[%@ %@]: index {%zd} beyond bounds [0...%zd]",NSStringFromClass([self class]),NSStringFromSelector(_cmd),index,MAX(self.count - 1, 0));
        return nil;
    }
    return [self zj_NSSingleObjectArrayIobjectAtIndex:index];
}
-(id)zj_objectAtIndexedSubscript:(NSUInteger)index {
    if(index >= self.count) {
        ZJSafeCollectionLog(@"[%@ %@] index {%zd} beyond bounds [0...%zd]",NSStringFromClass([self class]),NSStringFromSelector(_cmd),index,MAX(self.count - 1, 0));
        return nil;
    }
    return [self zj_objectAtIndexedSubscript:index];
}
@end
#pragma mark - NSMutableArray
@interface NSMutableArray (ZJSafe)
@end

@implementation NSMutableArray (ZJSafe)
- (id)zj_objectAtIndex:(NSUInteger)index {
    
    if(index >= self.count) {
        ZJSafeCollectionLog(@"[%@ %@]: index {%zd} beyond bounds [0...%zd]",NSStringFromClass([self class]),NSStringFromSelector(_cmd),index,MAX(self.count - 1, 0));
        return nil;
    }
    return [self zj_objectAtIndex:index];
}



- (id)zj_objectAtIndexedSubscript:(NSUInteger)index {
    
    if(index >= self.count) {
        ZJSafeCollectionLog(@"[%@ %@]: index {%zd} beyond bounds [0...%zd]",NSStringFromClass([self class]),NSStringFromSelector(_cmd),index,MAX(self.count - 1, 0));
        return nil;
    }
    return [self zj_objectAtIndexedSubscript:index];
}
- (void)zj_insertObject:(id)object atIndex:(NSUInteger)index {
    
    if(object == nil) {
        ZJSafeCollectionLog(@"[%@ %@]: object cannot be nil",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
        return;
    }
    if(index > self.count) {
        ZJSafeCollectionLog(@"[%@ %@]: index {%zd} beyond bounds [0...%zd]",NSStringFromClass([self class]),NSStringFromSelector(_cmd),index,MAX(self.count - 1, 0));
        return;
    }
    [self zj_insertObject:object atIndex:index];
}
- (void)zj_exchangeObjectAtIndex:(NSUInteger)index1 withObjectAtIndex:(NSUInteger)index2 {
    if(index1 >= self.count || index2 >= self.count) {
        ZJSafeCollectionLog(@"[%@ %@]: index {%zd} beyond bounds [0...%zd]",NSStringFromClass([self class]),NSStringFromSelector(_cmd),index,MAX(self.count - 1, 0));
        return;
    }
    [self zj_exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
}
- (void)zj_replaceObjectAtIndex:(NSUInteger)index withObject:(id)object {
    if(index >= self.count) {
        ZJSafeCollectionLog(@"[%@ %@]: index {%zd} beyond bounds [0...%zd]",NSStringFromClass([self class]),NSStringFromSelector(_cmd),index,MAX(self.count - 1, 0));
        return;
    }
    if(object == nil) {
        ZJSafeCollectionLog(@"[%@ %@]: object cannot be nil",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
        return;
    }
    [self zj_replaceObjectAtIndex:index withObject:object];
}
- (void)zj_removeObjectAtIndex:(NSUInteger)index {
    if (index >= [self count]) {
        ZJSafeCollectionLog(@"[%@ %@]: removeObject at index {%zd} bounds [0...%zd]",NSStringFromClass([self class]),NSStringFromSelector(_cmd),index,MAX(self.count - 1, 0));
        return;
    }
    [self zj_removeObjectAtIndex:index];
}
@end
#pragma mark - NSDictionary
@interface NSDictionary (ZJSafe)
@end

@implementation NSDictionary (ZJSafe)

- (instancetype)zj_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)count
{
    id validObjects[count];
    id<NSCopying> validKeys[count];
    NSUInteger newCount = 0;
    for (NSUInteger i = 0; i < count; i++)
    {
        if (objects[i] && keys[i])
        {
            validObjects[newCount] = objects[i];
            validKeys[newCount] = keys[i];
            newCount ++;
        }
        else
        {
            ZJSafeCollectionLog(@"[%@ %@] nil object or key at index{%zd}.",
                                NSStringFromClass([self class]),NSStringFromSelector(_cmd),i);
        }
    }
    
    return [self zj_initWithObjects:validObjects forKeys:validKeys count:newCount];
}
@end
#pragma mark - NSMutableDictionary

@interface NSMutableDictionary (ZJSafe)
@end

@implementation NSMutableDictionary (ZJSafe)
- (void)zj_setObject:(id)object forKey:(id<NSCopying>)key {
    
    if(object == nil) {
        ZJSafeCollectionLog(@"[%@ %@] object cannot be nil",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
        return;
    }
    if(key == nil) {
        ZJSafeCollectionLog(@"[%@ %@] key cannot be nil",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
        return;
    }
    [self zj_setObject:object forKey:key];
}
- (void)zj_setValue:(id)value forKey:(id<NSCopying>)key {
    
    
    if(key == nil) {
        ZJSafeCollectionLog(@"[%@ %@] key cannot be nil",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
        return;
    }
    [self zj_setValue:value forKey:key];
}
- (void)zj_removeObjectForKey:(id)key {
    if(key == nil) {
        ZJSafeCollectionLog(@"[%@ %@] key cannot be nil",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
        return;
    }
    [self zj_removeObjectForKey:key];
}
@end

@implementation ZJSafeCollection
+ (void)load {
    static dispatch_once_t  once;
    dispatch_once(&once, ^{
        // NSArray
        // __NSSingleObjectArrayI __NSArray0
        ZJSwizzleMethod(NSClassFromString(@"__NSPlaceholderArray"), @selector(initWithObjects:count:), @selector(zj_initWithObjects:count:));
        
        ZJSwizzleMethod(NSClassFromString(@"__NSArray0"), @selector(objectAtIndex:), @selector(zj_NSArray0objectAtIndex:));
        ZJSwizzleMethod(NSClassFromString(@"__NSSingleObjectArrayI"), @selector(objectAtIndex:), @selector(zj_NSSingleObjectArrayIobjectAtIndex:));
        
        
        ZJSwizzleMethod(NSClassFromString(@"__NSArrayI"), @selector(objectAtIndex:), @selector(zj_objectAtIndex:));
        ZJSwizzleMethod(NSClassFromString(@"__NSArrayI"), @selector(objectAtIndexedSubscript:), @selector(zj_objectAtIndexedSubscript:));
        
        // NSMutableArray
        ZJSwizzleMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndex:), @selector(zj_objectAtIndex:));
        ZJSwizzleMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndexedSubscript:), @selector(zj_objectAtIndexedSubscript:));
        ZJSwizzleMethod(NSClassFromString(@"__NSArrayM"), @selector(insertObject:atIndex:), @selector(zj_insertObject:atIndex:));
        ZJSwizzleMethod(NSClassFromString(@"__NSArrayM"), @selector(exchangeObjectAtIndex:withObjectAtIndex:), @selector(zj_exchangeObjectAtIndex:withObjectAtIndex:));
        ZJSwizzleMethod(NSClassFromString(@"__NSArrayM"), @selector(replaceObjectAtIndex:withObject:), @selector(zj_replaceObjectAtIndex:withObject:));
        ZJSwizzleMethod(NSClassFromString(@"__NSArrayM"), @selector(removeObjectAtIndex:), @selector(zj_removeObjectAtIndex:));
        
        // NSDictionary
        ZJSwizzleMethod(NSClassFromString(@"__NSPlaceholderDictionary"), @selector(initWithObjects:forKeys:count:), @selector(zj_initWithObjects:forKeys:count:));
        
        // NSMutableDictionary
        ZJSwizzleMethod(NSClassFromString(@"__NSDictionaryM"), @selector(setObject:forKey:), @selector(zj_setObject:forKey:));
        ZJSwizzleMethod(NSClassFromString(@"__NSDictionaryM"), @selector(setValue:forKey:), @selector(zj_setValue:forKey:));
        ZJSwizzleMethod(NSClassFromString(@"__NSDictionaryM"), @selector(removeObjectForKey:), @selector(zj_removeObjectForKey:));
        
    });
}
+ (void)setLogEnabled:(BOOL)enabled {
    ZJSafeCollectionLogEnabled = enabled;
}
void ZJSwizzleMethod(Class c, SEL origSEL, SEL newSEL) {
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method newMethod = nil;
    if (!origMethod) {
        c = object_getClass(c);
        return ZJSwizzleMethod(c, origSEL, newSEL);
    }else{
        newMethod = class_getInstanceMethod(c, newSEL);
        if (!newMethod) {
            return;
        }
    }
    if(class_addMethod(c, origSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))){
        
        class_replaceMethod(c, newSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }else{
        
        method_exchangeImplementations(origMethod, newMethod);
    }
}
@end


