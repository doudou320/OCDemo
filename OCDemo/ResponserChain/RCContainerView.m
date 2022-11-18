//
//  RCContainerView.m
//  OCDemo
//
//  Created by songyuliang on 2022/9/27.
//

#import "RCContainerView.h"
#import <Masonry.h>

@interface RCContainerView ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation RCContainerView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self setupSubviewLayout];
    }
    return  self;
}


- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor yellowColor];
        [imageView setUserInteractionEnabled:YES];
        _imgView = imageView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [_imgView addGestureRecognizer:tap];
    }
    return  _imgView;
}

- (void)onTap:(UITapGestureRecognizer *)gesture {
    NSLog(@"%s",__func__);
}

- (void)setupUI {
    [self addSubview: self.imgView];
}

- (void)setupSubviewLayout {
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom).offset(-30);
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (![self pointInside:point withEvent:event]) {
        for (UIView *subView in self.subviews) {
//            CGPoint convertedPoint = [self convertPoint:point toView: subView];
            if ([subView isKindOfClass:[UIImageView class]]) {
                if (CGRectContainsPoint(subView.frame, point)) {
                    return subView;
                }
            }
        }
    }
    return [super hitTest:point withEvent:event];
}
@end
