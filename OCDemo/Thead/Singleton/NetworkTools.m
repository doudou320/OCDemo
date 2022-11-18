//
//  NetworkTools.m
//  OCDemo
//
//  Created by songyuliang on 2022/10/21.
//

#import "NetworkTools.h"

@interface NetworkTools ()

@end

@implementation NetworkTools

+ (instancetype)shareInstance {
    static NetworkTools *instance = nil;
    // 互斥锁，保证线程安全
    @synchronized (self) {
        if (!instance) {
            instance = [[NetworkTools alloc] init];
        }
    }
    return instance;
}

+ (instancetype)shareInstanceOnce {
    static NetworkTools *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NetworkTools alloc] init];
    });
    return instance;
}

@end
