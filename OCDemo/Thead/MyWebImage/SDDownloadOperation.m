//
//  SDDownloadOperation.m
//  OCDemo
//
//  Created by songyuliang on 2022/11/17.
//

#import "SDDownloadOperation.h"
#import "NSString+SandBox.h"

@implementation SDDownloadOperation

+ (instancetype)downloadOperationWithURLString:(NSString *)urlString completion:(void(^)(UIImage *))block {
    SDDownloadOperation *operation = [[SDDownloadOperation alloc] init];
    operation.urlString = urlString;
    operation.finishedBlock = block;
    return operation;
}

- (void)main {
    @autoreleasepool {
        // 断言
        NSAssert(self.finishedBlock != nil, @"finishedBlock 不能为nil");
        // 模拟网络延时
        [NSThread sleepForTimeInterval: 1.5];
        // 下载网络图片
        NSURL *url = [NSURL URLWithString:self.urlString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        NSLog(@"从网络下载图片:%@",url);
        // 下载完成，图片缓存到沙盒中
        if (image) {
            [data writeToFile:[self.urlString appendCache] atomically:YES];
        }
        // 判断是否被取消，取消正在执行的操作
        if (self.isCancelled) {
            return;
        }
        
        if (self.finishedBlock) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
               // 在主线程刷新UI
                self.finishedBlock(image);
            }];
        }
    }
}

@end
