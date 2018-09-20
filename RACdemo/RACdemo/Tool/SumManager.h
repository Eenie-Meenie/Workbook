//
//  SumManager.h
//  RACdemo
//
//  Created by hanbo on 2018/9/20.
//  Copyright © 2018年 hanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SumManager;

typedef SumManager *(^sum)(int value);

//typedef SumManager *(^)(int value);

@interface SumManager : NSObject

/** 计算结果 */
@property (nonatomic, assign) int result;

/** 加法运算 */
// 返回值:为sumManager
// value:参数
//- (instancetype)add:(int)value;

- (SumManager *(^)(int value))addsumValue;

- (sum)add;

/** <#注释#> */
@property (nonatomic, copy) sum sumb;


@end
