//
//  BlueButton.m
//  OCDemo
//
//  Created by songyuliang on 2022/9/9.
//

#import "BlueButton.h"

@implementation BlueButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint redPoint = [self convertPoint:point toView:_redButton];
    if ([_redButton pointInside:redPoint withEvent:event]) {
        return _redButton;
    }
    return [super hitTest:point withEvent:event];
}

@end
