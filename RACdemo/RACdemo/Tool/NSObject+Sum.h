//
//  NSObject+Sum.h
//  RACdemo
//
//  Created by hanbo on 2018/9/20.
//  Copyright © 2018年 hanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SumManager;

//typedef void(^sumBlcok)(SumManager * mgr);

@interface NSObject (Sum)

//+ (int)HB_makeConstrints:(sumBlcok)sumblock;

+ (int)HB_makeSub:(void(^)(SumManager *))sumBlock;

@end
