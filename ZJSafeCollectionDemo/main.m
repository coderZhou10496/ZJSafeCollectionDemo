//
//  main.m
//  ZJSafeCollectionDemo
//
//  Created by watchnail on 2018/1/19.
//  Copyright © 2018年 watchnail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "ZJTestClass.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        
        NSArray *array = @[@1,@2,@3];
        NSNumber *number = array[3]; // Not Carsh


        NSMutableArray *mutableArray = array.mutableCopy;
        [mutableArray removeObjectAtIndex:4]; // Not Carsh

        id value = nil;
        NSDictionary *dic = @{@"key":value}; // Not Carsh

        id key = nil;
        NSMutableDictionary *mutableDic = @{@"key":@"value"}.mutableCopy;
        [mutableDic removeObjectForKey:key]; // Not Carsh
        

        [ZJTestClass classTestMethod]; // Not Carsh
        
        [[[ZJTestClass alloc] init] instanceTestMethod]; // Not Carsh
        
        [[NSNull null] performSelector:@selector(nullTest)];
    }
}
