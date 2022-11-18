//
//  PThreadViewController.m
//  OCDemo
//
//  Created by songyuliang on 2022/10/19.
//

#import "PThreadViewController.h"
#import <pthread/pthread.h>

@interface PThreadViewController ()

@end

@implementation PThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 第一个参数 线程编号的地址
    // 第二个参数 线程的属性
    // 第三个参数 线程要执行的函数 void * (* void) (void *)
    // int * 含义是执行int类型的指针 void * 含义是指指向任何类型的指针 类型OC的id
    // 第四个参数 要执行的函数的参数
    
    pthread_t pthread;
    // 函数返回值 int 0是成功  非0s失败
    
   // char *name = "Jack";// 定义C语言的字符串
    NSString *name = @"Rose";
    // __bridge 桥接：OC指针与C语言 void * 相互转换
    // 把OC对象传递给C语言的函数需要桥接
    int result = pthread_create(&pthread, NULL, demo, (__bridge void *)(name));
    if (!result) {
        NSLog(@"线程创建成功 %@", [NSThread currentThread]);
    } else {
        NSLog(@"线程创建失败  %@", [NSThread currentThread]);
    }
}

void *demo(void *params) {
    NSString *name = (__bridge NSString *)(params);
    NSLog(@"执行线程中的任务%@, 函数参数：%@ ", [NSThread currentThread], name);
    return NULL;
}


@end

