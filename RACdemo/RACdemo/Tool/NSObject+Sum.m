//
//  NSObject+Sum.m
//  RACdemo
//
//  Created by hanbo on 2018/9/20.
//  Copyright © 2018年 hanbo. All rights reserved.
//

#import "NSObject+Sum.h"
#import "SumManager.h"

@implementation NSObject (Sum)

+ (int)HB_makeSub:(void(^)(SumManager *))sumBlock {
  
    SumManager *mgr= [[SumManager alloc] init];
    
    sumBlock(mgr);
    
    return mgr.result;
    
}

@end
