//
//  GCDViewController.m
//  OCDemo
//
//  Created by songyuliang on 2022/10/19.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@property (nonatomic, strong) NSMutableArray *mArray;

@end

@implementation GCDViewController

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (NSMutableArray *)mArray {
    if (!_mArray) {
        _mArray = [NSMutableArray array];
    }
    return _mArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    [self dispatchBarrier];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    // 1.创建队列
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    // 2.创建任务
//    dispatch_block_t task = ^ {
//        NSLog(@"%@",[NSThread currentThread]);
//    };
//    // 3.任务添加到队列里
//    dispatch_async(queue, task);
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"%@", [NSThread currentThread]);
//    });
    
//    [self syncSerialQueue];
    
//    [self asyncSerialQueue];
    
//    [self syncConcurrentQueue];
    
//    [self asyncConcurrentQueue];
  
//    [self syncMainQueue];
    
//    [self asyncMainQueue];
    
//    [self solveDeadLock];
    
//    [self downloadApp];
    
//    NSLog(@"%zd", self.mArray.count);
    
//    [self dispatchOnceToken];
    
    [self dispatchGroup];
}

#pragma mark --- GCD 串行队列，同步执行
// 串行队列，同步执行（不开启新的线程，顺序执行）
- (void)syncSerialQueue {
    dispatch_queue_t queue = dispatch_queue_create("flashexpress", DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i <= 10; i++) {
        dispatch_sync(queue, ^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"%d在线程%@上", i, [NSThread currentThread]);
        });
    }
   
    NSLog(@"主线程结束");
}

#pragma mark --- GCD 串行队列，异步执行
// 串行队列，异步执行（开启1个新的线程，顺序执行）
- (void)asyncSerialQueue {
    dispatch_queue_t queue = dispatch_queue_create("flashexpress", DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i <= 10; i++) {
        dispatch_async(queue, ^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"%d在线程%@上", i, [NSThread currentThread]);
        });
    }
   
    NSLog(@"主线程结束");
}

#pragma mark --- GCD 并行队列，同步执行
// 并行队列，同步执行 = 串行队列，同步执行（不开启新的线程，顺序执行）
// 这种组合情况很少用
- (void)syncConcurrentQueue {
    dispatch_queue_t queue = dispatch_queue_create("flashexpress", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10; i++) {
        dispatch_sync(queue, ^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"%d在线程%@上", i,[NSThread currentThread]);
        });
    }
    NSLog(@"主线程结束");
}

#pragma mark --- 并行队列，异步执行
// 并行队列，异步执行 (开启多个子线程, 无序执行)
- (void)asyncConcurrentQueue {
    dispatch_queue_t queue = dispatch_queue_create("flashexpress", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"%d在线程%@上", i,[NSThread currentThread]);
        });
    }
    NSLog(@"主线程结束");
}

#pragma mark --- 主队列，同步执行
// 主队列，同步执行 (会死锁)
- (void)syncMainQueue {
    NSLog(@"主线程开始");
    for (int i = 0; i < 10; i++) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"%d在线程%@上",i, [NSThread currentThread]);
        });
    }
    NSLog(@"主线程结束");
}

#pragma mark --- 主队列, 异步执行
// 特点: 1.主队列是在主线程，顺序执行
//      2.先执行完主线程的任务，再执行主队列里的任务
- (void)asyncMainQueue {
    NSLog(@"主线程开始");
    for (int i = 0; i < 10; i++) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%d在线程%@上",i, [NSThread currentThread]);
        });
    }
    NSLog(@"主线程结束");
}

#pragma mark --- GCD barrier
// 解决死锁问题
- (void)solveDeadLock {
    NSLog(@"主线程开始");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 10; i++) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSLog(@"%d在线程%@上",i, [NSThread currentThread]);
            });
        }
    });
    NSLog(@"主线程结束");
}

#pragma mark --- GCD barrier
// 全局队列
// 模拟下载应用过程（输入密码-->扣费-->下载应用）
- (void)downloadApp {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"输入密码 %@", [NSThread currentThread]);
        });

        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"扣费 %@", [NSThread currentThread]);
        });

        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:5];
            NSLog(@"下载应用 %@", [NSThread currentThread]);
        });
    });
    
//    dispatch_queue_t queue = dispatch_queue_create("flashexpress", DISPATCH_QUEUE_SERIAL);
//    dispatch_async(queue, ^{
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"输入密码");
//    });
//
//    dispatch_async(queue, ^{
//        [NSThread sleepForTimeInterval:1];
//        NSLog(@"扣费");
//    });
//
//    dispatch_async(queue, ^{
//        [NSThread sleepForTimeInterval:5];
//        NSLog(@"下载应用");
//    });
}

#pragma mark --- GCD barrier
// barrier 会等待队列中任务执行完毕，才会执行barrier block的任务。类似阻塞功能
- (void)dispatchBarrier {
    for (int i = 0; i < 100; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:0.5];
            NSLog(@"%d %@",i, [NSThread currentThread]);
            dispatch_barrier_async(dispatch_get_global_queue(0, 0), ^{
                [self.mArray addObject: [NSNumber numberWithInt:i]];
            });
        });
    }
}

#pragma mark --- CGD 一次性执行 dispatch_once
// 一次性执行原理: 1.判断静态的全局变量 dispatch_once_t 的值，默认是0, 任务执行完成后是-1
//              2.dispatch_once内部会判断全局静态变量的值，如果是0,才会执行block里的代码
- (void)dispatchOnceToken {
    
    for (int i = 0; i < 10; i++) {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            static dispatch_once_t onceToken;
            NSLog(@"dispatch_once_t start = %zd", onceToken);
            dispatch_once(&onceToken, ^{
                NSLog(@"dispatch_once %d : %@", i, [NSThread currentThread]);
            });
            NSLog(@"dispatch_once_t end = %zd", onceToken);
//        });
    }
}
#pragma mark ---dispatch_group
// 原理：group有个全局变量的计数器，调用dispatch_group_enter计数器加1，调用dispatch_group_leave计数器减1
- (void)dispatchGroup {
    // 1. 创建组
    dispatch_group_t group = dispatch_group_create();
    // 2. 创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    // 3. 任务加入组队列
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"下载歌曲1");
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"下载歌曲2");
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"下载歌曲3");
        dispatch_group_leave(group);
    });
    
    // 组中的任务全部执行完成, 再执行dispatch_group_notify的任务
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        NSLog(@"歌曲全部下载完成  %@", [NSThread currentThread]);
//    });
    
    // 组中的任务全部执行完成, 才执行后面任务。类似阻塞
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"其他操作");
}

@end
