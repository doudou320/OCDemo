//
//  AppInfo.m
//  OCDemo
//
//  Created by songyuliang on 2022/10/26.
//

#import "AppInfo.h"

@implementation AppInfo

+ (instancetype)appInfoWithDic:(NSDictionary *)dic {
    if (!dic) { return nil; }
    AppInfo *appInfo = [[AppInfo alloc] init];
    // kvc属性赋值
    [appInfo setValuesForKeysWithDictionary:dic];
    return appInfo;
}

+ (NSArray *)appInfos {
    // 加载plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    // 字典转模型
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [mArray addObject:[AppInfo appInfoWithDic:obj]];
    }];
    
    return [mArray copy];
}

@end
