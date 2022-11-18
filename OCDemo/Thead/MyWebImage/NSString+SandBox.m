//
//  NSString+SandBox.m
//  OCDemo
//
//  Created by songyuliang on 2022/11/16.
//

#import "NSString+SandBox.h"

@implementation NSString (SandBox)

- (instancetype)appendCache {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingString:[self lastPathComponent]];
}

- (instancetype)appendTemp {
    return [NSTemporaryDirectory() stringByAppendingString:[self lastPathComponent]];
}
- (instancetype)appendDocument {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingString:[self lastPathComponent]];

}

@end
