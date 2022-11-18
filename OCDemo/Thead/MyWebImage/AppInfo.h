//
//  AppInfo.h
//  OCDemo
//
//  Created by songyuliang on 2022/10/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppInfo : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *download;

@property (nonatomic, strong) UIImage *image;

+ (instancetype)appInfoWithDic:(NSDictionary *)dic;

+ (NSArray *)appInfos;

@end

NS_ASSUME_NONNULL_END
