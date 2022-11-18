//
//  ResponseChainViewController.m
//  OCDemo
//
//  Created by songyuliang on 2022/9/8.
//

#import "ResponseChainViewController.h"
#import "RCView.h"
#import <Masonry.h>

@interface ResponseChainViewController ()

@end

@implementation ResponseChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    RCView *rcView = [[RCView alloc] initWithFrame: self.view.bounds];
    [self.view addSubview:rcView];
}

@end
