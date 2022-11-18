//
//  MaxSubsequence.m
//  OCDemo
//
//  Created by songyuliang on 2022/8/10.
//

#import "MaxSubsequence.h"
/*
 *给你一个整数数组 nums ，请你找出一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。子数组 是数组中的一个连续部分.
 * 示例：
 输入：nums = [-2,1,-3,4,-1,2,1,-5,4]
 输出：6
 解释：连续子数组 [4,-1,2,1] 的和最大，为 6 。
*/
@implementation MaxSubsequence

int maxSubSequenceSum(int nums[], int length) {
    int i, j, thisSum, maxSum = 0;
    for (i = 0; i < length; i++) { // i是子序列最左端
        // 从i到j的最大子序列和
        thisSum = 0;
        for (j = i; j < length; j++) { // j是子序列最右端
            thisSum += nums[j];
            if (thisSum > maxSum) {
                maxSum = thisSum;
            }
        }
    }
    return  maxSum;
}

@end
