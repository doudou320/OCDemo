//
//  AlgorithmDetailViewController.m
//  OCDemo
//
//  Created by songyuliang on 2022/8/10.
//

#import "AlgorithmDetailViewController.h"
#import "MaxSubsequence.h"
#import "RotateDigits.h"

@interface AlgorithmDetailViewController ()

@end

@implementation AlgorithmDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self implementationAlgorithm];
}

- (void)implementationAlgorithm {
    
    if ([self.algorithmID isEqualToString: @"subsequence"]) {
        [self maxSubsequence];
    } else if ([self.algorithmID isEqualToString: @"rotateDigits"]) {
        [self rotateDigits];
    }
}

- (void)maxSubsequence {
    int nums[] ={2, -1, 0, 8, 9, -5, 7};
    int sum = maxSubSequenceSum(nums, 6);
    NSLog(@"maxSubSequenceSum = %d", sum);
}

- (void)rotateDigits {
    int goodDigitCount = rotatedDigits(20);
    NSLog(@"goodDigitCount = %d", goodDigitCount);
}

@end
