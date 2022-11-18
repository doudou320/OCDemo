//
//  NSString+SandBox.h
//  OCDemo
//
//  Created by songyuliang on 2022/11/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SandBox)

- (instancetype)appendCache;
- (instancetype)appendTemp;
- (instancetype)appendDocument;

@end

NS_ASSUME_NONNULL_END
