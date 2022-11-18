//
//  Person.m
//  OCDemo
//
//  Created by songyuliang on 2022/9/7.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

/*
+ (void)load {
    NSLog(@"%s",__func__);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(walk);
        SEL swizzledSelector = @selector(SwizllingWalk);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(swizzledMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
        NSLog(@"method_exchangeImplementations");
    });
}*/


+ (void)initialize {
    NSLog(@"%s",__func__);

//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//
//        SEL originalSelector = @selector(walk);
//        SEL swizzledSelector = @selector(SwizllingWalk);
//
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//
//        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
//
//        if (didAddMethod) {
//            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(swizzledMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//
//        NSLog(@"method_exchangeImplementations");
//    });
}

- (void)walk {
    NSLog(@"Person walk!");
}

- (void)SwizllingWalk {
    NSLog(@"Person SwizllingWalk!");
}

@end
