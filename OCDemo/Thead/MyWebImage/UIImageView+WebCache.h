//
//  UIImageView+WebCache.h
//  OCDemo
//
//  Created by songyuliang on 2022/11/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (WebCache)

// 当前的图片地址
@property (nonatomic, copy) NSString *currentURLString;

- (void)setImageURLString:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage; 

@end

NS_ASSUME_NONNULL_END
