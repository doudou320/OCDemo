//
//  NSThreadViewController.m
//  OCDemo
//
//  Created by songyuliang on 2022/10/19.
//

#import "NSThreadViewController.h"

@interface NSThreadViewController ()

@property (nonatomic, assign) int ticketCount;

// 原子操作是线程安全的，自旋锁
@property (atomic, copy) NSString *name;

@property (nonatomic, copy) NSString *address;

@end

@implementation NSThreadViewController
//当同时重写setter和getter方法，不会生成_address的成员变量
@synthesize address = _address;

- (void)setAddress:(NSString *)address {
    //模拟原子操作
    @synchronized (self) {
        _address = address;
    }
}

- (NSString *)address {
    return _address;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    self.ticketCount = 10;
    // 方式-
//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(sellTickets) object:nil];
//    thread.name = @"T0";
//    thread.threadPriority = 0.1;
//    [thread start]; //开启线程，内部调用main方法
    
//    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(sellTickets) object:nil];
//    thread1.name = @"T1";
//    thread.threadPriority = 1.0;
//    [thread1 start]; //开启线程，内部调用main方法
    
    // 方式二（分离新的线程并开启）
//    [NSThread detachNewThreadSelector:@selector(demo) toTarget:self withObject:nil];
    
    // 方式三
//    [self performSelectorInBackground:@selector(demo) withObject:nil];
    
    // 方式四 带参数
//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(demo1:) object:@"abc"];
//    [thread start];
    
    // 模拟消息循环
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(demo2) object:nil];
    [thread start];
    
    // 向子线程添加输入源
    [self performSelector:@selector(demo3) onThread:thread withObject:nil waitUntilDone:YES];
} 

- (void)demo {
    NSLog(@"执行线程的任务%@", [NSThread currentThread]);
    
    for (int i = 0; i < 20; i++) {
        NSLog(@"i = %d (%@)",i, [NSThread currentThread]);
        // 判断线程是否在主线程
        if ([NSThread isMainThread]) {
            int m = 0;
            int n = i / m;
            NSLog(@"n = %d",n);
        }
       
//        if (i == 5) {
//            // 线程阻塞（阻塞状态）
//            [NSThread sleepForTimeInterval:3];
//        }
//
//        if (i == 10) {
//            // 线程退出，线程会销毁（死亡状态）
//            [NSThread exit];
//        }
    }
}

- (void)demo1:(NSString *)string {
    NSLog(@"执行线程的任务%@", string);
}

//模拟售票 (资源共享会造成线程的不安全性,OC中的可变类型都是线程不安全的)
- (void)sellTickets {
    while (YES) {
        // 模拟耗时操作
        [NSThread sleepForTimeInterval:1];
        //每个对象内部都有一把锁，默认是打开的
        NSObject *obj = [[NSObject alloc] init];
        // @synchronized 是互斥锁（一个线程加锁，另一个线程需要等待）
        // 加锁线程是同步执行，会影响性能
        @synchronized (obj) {
            if (self.ticketCount > 0) {
                self.ticketCount--;
                NSLog(@"剩余%d票", self.ticketCount);
            } else {
                NSLog(@"票卖完了");
                break;
            }
        }
    }
}

// 在子线程中执行消息循环
- (void)demo2 {
    NSLog(@"I am running on %@ thread", [NSThread currentThread]);
    // 子线程的runloop默认是不开启的
    // 当消息循环中没有添加输入源，消息循环立即结束
    // [[NSRunLoop currentRunLoop] run] 这个方法消息循环一直执行，不会结束
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]];
    NSLog(@"runloop end");
}

- (void)demo3 {
    NSLog(@"I am running on %@ runloop", [NSThread currentThread]);
}

@end
