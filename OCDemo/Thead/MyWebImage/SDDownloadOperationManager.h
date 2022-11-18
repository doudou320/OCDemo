//
//  SDDownloadOperationManager.h
//  OCDemo
//
//  Created by songyuliang on 2022/11/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDDownloadOperationManager : NSObject
// 单例初始化
+ (instancetype)shareManager;

// 管理全局下载操作
- (void)downloadWithURLString:(NSString *)urlString completion:(void(^)(UIImage *))block;

// 取消操作
- (void)cancelOperation:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
