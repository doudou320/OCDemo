//
//  NetworkTools.h
//  OCDemo
//
//  Created by songyuliang on 2022/10/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkTools : NSObject

+ (instancetype)shareInstance;

+ (instancetype)shareInstanceOnce;

@end

NS_ASSUME_NONNULL_END
