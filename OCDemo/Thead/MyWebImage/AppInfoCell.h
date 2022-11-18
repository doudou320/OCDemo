//
//  ImageCell.h
//  OCDemo
//
//  Created by songyuliang on 2022/10/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AppInfo;

@interface AppInfoCell : UITableViewCell

@property (nonatomic, strong) AppInfo *appInfo;

+ (AppInfoCell *)createCellWithTableView:(UITableView *)tableView;


@end

NS_ASSUME_NONNULL_END
