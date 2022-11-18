//
//  SDDownloadOperation.h
//  OCDemo
//
//  Created by songyuliang on 2022/11/17.
//

#import <UIKit/UIKit.h>

/* 自定义操作
 *  1.创建一个继承自NSOperation的类
 *  2.重写main方法，创建自动释放池
 *  3.定义属性接收参数，类方法快速初始化操作对象
 *  4.取消操作（取消正在执行的操作）
 *  5.断言NSAssert
 */

NS_ASSUME_NONNULL_BEGIN

@interface SDDownloadOperation : NSOperation

@property (nonatomic, copy) NSString *urlString;

@property (nonatomic, copy) void(^finishedBlock)(UIImage *);

+ (instancetype)downloadOperationWithURLString:(NSString *)urlString completion:(void(^)(UIImage *))block;

@end

NS_ASSUME_NONNULL_END
