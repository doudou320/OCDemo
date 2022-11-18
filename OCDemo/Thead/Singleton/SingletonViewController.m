//
//  SingletonViewController.m
//  OCDemo
//
//  Created by songyuliang on 2022/10/21.
//

#import "SingletonViewController.h"
#import "NetworkTools.h"

@interface SingletonViewController ()

@end

@implementation SingletonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NetworkTools *tool1 = [NetworkTools shareInstance];
    NetworkTools *tool2 = [NetworkTools shareInstanceOnce];
    NSLog(@"%@",tool1);
    NSLog(@"%@",tool2);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self demo1];
    [self demo2];
}

// 获取加锁创建对象消耗的时间
- (void)demo1 {
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < 100000; i++) {
        [NetworkTools shareInstance];
    }
    CFAbsoluteTime endTime = CFAbsoluteTimeGetCurrent();
    NSLog(@"互斥锁消耗的时间：%f", endTime - startTime);
}
// 获取dispatch_once创建对象消耗的时间
- (void)demo2 {
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < 100000; i++) {
        [NetworkTools shareInstanceOnce];
    }
    CFAbsoluteTime endTime = CFAbsoluteTimeGetCurrent();
    NSLog(@"dispatch_once消耗的时间：%f", endTime - startTime);
}


@end
