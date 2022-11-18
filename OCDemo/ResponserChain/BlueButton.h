//
//  BlueButton.h
//  OCDemo
//
//  Created by songyuliang on 2022/9/9.
//

#import <UIKit/UIKit.h>
#import "RedButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface BlueButton : UIButton

@property (nonatomic, strong) RedButton *redButton;

@end

NS_ASSUME_NONNULL_END
