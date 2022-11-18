//
//  RCView.m
//  OCDemo
//
//  Created by songyuliang on 2022/9/8.
//

#import "RCView.h"
#import "RedButton.h"
#import "BlueButton.h"
#import <Masonry.h>
#import "RCContainerView.h"

@interface RCView ()

@property (nonatomic, strong) RedButton *redButton;

@property (nonatomic, strong) BlueButton *blueButton;

@property (nonatomic, strong) RCContainerView *containerView;

@end

@implementation RCView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self setupSubviewLayout];
    }
    
    return  self;
}

- (RedButton *)redButton {
    if (!_redButton) {
        RedButton *button = [RedButton buttonWithType: UIButtonTypeCustom];
        button.backgroundColor = [UIColor redColor];
        [button addTarget:self action:@selector(didClickButtionA) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _redButton = button;
    }
    return _redButton;
}

- (BlueButton *)blueButton {
    if (!_blueButton) {
        BlueButton *button = [BlueButton buttonWithType: UIButtonTypeCustom];
        button.backgroundColor = [UIColor blueColor];
        [button addTarget:self action:@selector(didClickButtionB) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _blueButton = button;
    }
    return _blueButton;
}

- (RCContainerView *)containerView {
    if (!_containerView) {
        RCContainerView *view = [[RCContainerView alloc] init];
        view.backgroundColor = [UIColor cyanColor];
        _containerView = view;
    }
    return  _containerView;
}

- (void)setupUI {
    [self addSubview: self.redButton];
    [self addSubview: self.blueButton];
    self.blueButton.redButton = self.redButton;
    [self addSubview: self.containerView];
}

- (void)setupSubviewLayout {
    [_redButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.width.mas_equalTo(UIScreen.mainScreen.bounds.size.width/2);
        make.height.mas_equalTo(100);
    }];
    
    [_blueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(UIScreen.mainScreen.bounds.size.width/2 - 50);
        make.width.mas_equalTo(UIScreen.mainScreen.bounds.size.width/2);
        make.height.mas_equalTo(150);
    }];
    
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.blueButton.mas_bottom).offset(100);
        make.left.equalTo(self.mas_left).offset(50);
        make.right.equalTo(self.mas_right).offset(-50);
        make.height.equalTo(@200);
    }];
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    NSLog(@"%s",__func__);
//    CGPoint redButtonPoint = [self convertPoint:point toView:_redButton];
//    if ([_redButton pointInside:redButtonPoint withEvent:event]) {
//        return _redButton;
//    }
//
//    CGPoint blueButtonPoint = [self convertPoint:point toView:_blueButton];
//    if ([_blueButton pointInside:blueButtonPoint withEvent:event]) {
//        return _blueButton;
//    }
//    return self;
//}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    NSLog(@"%s",__func__);
//    return false;
//}

#pragma mark - Button Action
- (void)didClickButtionA {
    NSLog(@"Click red button!");
}

- (void)didClickButtionB {

    NSLog(@"Click blue button!");
}

@end
