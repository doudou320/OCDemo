//
//  UIImageView+WebCache.m
//  OCDemo
//
//  Created by songyuliang on 2022/11/18.
//

#import "UIImageView+WebCache.h"
#import "SDDownloadOperationManager.h"
#import <objc/runtime.h>

const void *currentURLStringKey = &currentURLStringKey;

@interface UIImageView ()

@end

@implementation UIImageView (WebCache)

// 分类中增加属性，需要手动添加setter和getter方法

- (NSString *)currentURLString {
    return objc_getAssociatedObject(self, currentURLStringKey);
}

- (void)setCurrentURLString:(NSString *)currentURLString {
    // 关联对象
    objc_setAssociatedObject(self, currentURLStringKey, currentURLString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)dealloc {
    objc_removeAssociatedObjects(self);
}


- (void)setImageURLString:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage {
    
    // 设置占位图
    if (placeholderImage) {
        self.image = placeholderImage;
    }
    
    // 判断图片当前地址和上次地址是否一样，若不一样，取消上次操作
    if (![urlString isEqualToString:self.currentURLString]) {
        [[SDDownloadOperationManager shareManager] cancelOperation:self.currentURLString];
    }
    
    // 记录当前地址
    self.currentURLString = urlString;
    
    // 下载图片
    [[SDDownloadOperationManager shareManager] downloadWithURLString:urlString completion:^(UIImage *image) {
        self.image = image;
    }];
}

@end
