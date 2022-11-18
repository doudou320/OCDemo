//
//  ErnieView.m
//  OCDemo
//
//  Created by songyuliang on 2022/10/16.
//

#import "ErnieView.h"

@interface ErnieView ()

@property (nonatomic, strong) UILabel *firstLabel;

@property (nonatomic, strong) UILabel *secondLabel;

@property (nonatomic, strong) UILabel *thirdLabel;

@property (nonatomic, strong) UIButton *startButton;

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ErnieView

- (UILabel *)firstLabel {
    if (!_firstLabel) {
        _firstLabel = [[UILabel alloc] init];
        _firstLabel.text = @"0";
        _firstLabel.font = [UIFont boldSystemFontOfSize: 30];
        _firstLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _firstLabel;
}

- (UILabel *)secondLabel {
    if (!_secondLabel) {
        _secondLabel = [[UILabel alloc] init];
        _secondLabel.text = @"0";
        _secondLabel.font = [UIFont boldSystemFontOfSize: 30];
        _secondLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _secondLabel;
}


- (UILabel *)thirdLabel {
    if (!_thirdLabel) {
        _thirdLabel = [[UILabel alloc] init];
        _thirdLabel.text = @"0";
        _thirdLabel.font = [UIFont boldSystemFontOfSize: 30];
        _thirdLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _thirdLabel;
}

- (UIButton *)startButton {
    if (!_startButton) {
        _startButton = [UIButton buttonWithType: UIButtonTypeCustom];
        [_startButton setTitle:@"开始" forState: UIControlStateNormal];
        [_startButton addTarget:self action:@selector(start:) forControlEvents: UIControlEventTouchUpInside];
    }
    return  _startButton;
}

- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [NSOperationQueue new];
    }
    return _queue;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
        [self setupSubViewsLayout];
    }
    return self;
}

- (void)setupSubviews {
    self.backgroundColor = [UIColor systemRedColor];
    [self addSubview:self.firstLabel];
    [self addSubview:self.secondLabel];
    [self addSubview:self.thirdLabel];
    [self addSubview:self.startButton];
}

- (void)setupSubViewsLayout {

    [_secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(50);
        make.centerX.equalTo(self);
    }];
    
    
    [_firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_secondLabel.mas_left).offset(-20);
        make.top.equalTo(_secondLabel);
    }];
    
    
    [_thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_secondLabel.mas_right).offset(20);
        make.top.equalTo(_secondLabel);
    }];
    
    [_startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_secondLabel.mas_bottom).offset(20);
    }];
}

- (void)start:(UIButton *)sender {
    // 当队列中有操作，就不添加新的操作，否则添加多个操作，多次点击按钮，界面会多次更新，造成越来越快的现象
    if (self.queue.operations.count == 0) {
        // 异步执行，添加操作
        [self.queue addOperationWithBlock:^{
            [self random];
        }];
        self.queue.suspended = NO;
        [self.startButton setTitle:@"暂停" forState:UIControlStateNormal];
    } else if (!self.queue.isSuspended) {
        /*
         * 注意：1.暂停是指暂停队列，暂停的那一刻，如果队列的任务是正在执行状态，那么执行完毕这个任务，暂停后面的任务
         *      2.暂停是队列的操作数为零
         */
        self.queue.suspended = YES;
        [self.startButton setTitle:@"继续" forState:UIControlStateNormal];
    }
  
}

// 生产随机数，显示在UI上
- (void)random {
    while (!self.queue.isSuspended) {
        [NSThread sleepForTimeInterval:0.1];
        // 生产随机数 10 [0,10)区间
        int number1 = arc4random_uniform(10);
        int number2 = arc4random_uniform(10);
        int number3 = arc4random_uniform(10);
        // 生成随机数是在子线程上，更新UI需要在主线程上
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        self->_firstLabel.text = [NSString stringWithFormat:@"%d",number1];
                        self->_secondLabel.text = [NSString stringWithFormat:@"%d",number2];
                        self->_thirdLabel.text = [NSString stringWithFormat:@"%d",number3];
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"self.queue操作数: %lu", (unsigned long)self.queue.operations.count);
}

@end
