//
//  ErnieViewController.m
//  OCDemo
//
//  Created by songyuliang on 2022/10/16.
//

/*
 * 简单摇奖机的demo
 */
#import "ErnieViewController.h"
#import <Masonry.h>
#import "ErnieView.h"

@interface ErnieViewController ()

@property (nonatomic, strong) ErnieView *ernieView;

@end

@implementation ErnieViewController

- (void)dealloc {
    
}

- (ErnieView *)ernieView {
    if (!_ernieView) {
        _ernieView = [[ErnieView alloc] init];
    }
    return _ernieView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.ernieView];
    [self.ernieView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(self.view.bounds.size.width - 50, self.view.bounds.size.width - 50));
    }];
}

@end
