//
//  SDDownloadOperationManager.m
//  OCDemo
//
//  Created by songyuliang on 2022/11/17.
//

#import "SDDownloadOperationManager.h"
#import "SDDownloadOperation.h"
#import "NSString+SandBox.h"

@interface SDDownloadOperationManager ()
// 操作队列
@property (nonatomic, strong) NSOperationQueue *queue;
// 下载操作的缓冲池
@property (nonatomic, strong) NSMutableDictionary *operationCache;
// 图片缓存池
@property (nonatomic, strong) NSCache *imageCache;

@end

@implementation SDDownloadOperationManager

- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [NSOperationQueue new];
        _queue.maxConcurrentOperationCount = 5;
    }
    return  _queue;
}

- (NSMutableDictionary *)operationCache {
    if (!_operationCache) {
        _operationCache = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _operationCache;
}

- (NSCache *)imageCache {
    if (!_imageCache) {
        _imageCache = [[NSCache alloc] init];
        _imageCache.countLimit = 50;
    }
    return _imageCache;
}


+ (instancetype)shareManager {
    static SDDownloadOperationManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [SDDownloadOperationManager new];
    });
    return instance;
}

- (void)downloadWithURLString:(NSString *)urlString completion:(void (^)(UIImage * _Nonnull))block {
    // 断言
    NSAssert(block != nil, @"block 不能为nil");
    
    // 如果下载操作已经存在，返回
    if (self.operationCache[urlString]) {
        return;
    }
    
    // 判断图片是否有缓存
    if ([self checkImageCache:urlString]) {
        block([self.imageCache objectForKey:urlString]);
        return;
    }
    
    // 下载图片
    SDDownloadOperation *operation = [SDDownloadOperation downloadOperationWithURLString:urlString completion:^(UIImage *image) {
        if (image) {
            // 回调
            block(image);
            // 图片下载完成，缓存图片 （可变的数组和字典，线程是不安全的）
            [self.imageCache setObject:image forKey:urlString];
            // 下载完成后，移除操作，否则会造成循环引用（可以用__weak解决）
            // vc(self) -> queue、operationCache -> op -> block -> vc(self)
            [self.operationCache removeObjectForKey:urlString];
        }
    }];
    
    // 下载操作放在队列里
    [self.queue addOperation:operation];
    // 缓存下载操作
    [self.operationCache setObject:operation forKey:urlString];
}

// 取消操作
- (void)cancelOperation:(NSString *)urlString {
    if (!urlString) {
        return;
    }
    // 取消操作
    [[self.operationCache objectForKey:urlString] cancel];
    // 从缓存池中删除操作
    [self.operationCache removeObjectForKey:urlString];
}

// 检查是否有图片缓存（内存和沙盒）
- (BOOL)checkImageCache:(NSString *)urlString {
    // 1.检查内存是否有图片
    if ([self.imageCache objectForKey:urlString]) {
        NSLog(@"从内存中加载图片...");
        return YES;
    }
    // 2.检查沙盒中是否有图片
    UIImage *image = [UIImage imageWithContentsOfFile:[urlString appendCache]];
    if (image) {
        NSLog(@"从沙盒中加载图片...");
        [self.imageCache setObject:image forKey:urlString];
        return YES;
    }
    return NO;
}

@end
