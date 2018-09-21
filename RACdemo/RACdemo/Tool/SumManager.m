//
//  SumManager.m
//  RACdemo
//
//  Created by hanbo on 2018/9/20.
//  Copyright © 2018年 hanbo. All rights reserved.
//

#import "SumManager.h"

@implementation SumManager

//- (instancetype)add:(int)value {
//    _result += value;
//    return self;
//}

//- (SumManager *(^)(int value))add {
//    
//    return ^(int value) {
//        _result += value;
//        
//        return self;
//    };
//}

- (SumManager *(^)(int value))addsumValue {
   return ^(int value) {
        _result += value;
        return self;
   };
}

- (sum)add {
    
    @weakify(self);
    self.sumb = ^SumManager *(int value) {
        @strongify(self);
        _result += value;
        return self;
    };
    
    return self.sumb;

    
//    return ^(int value) {
//        _result += value;
//        return self;
//    };
    
}

/** 计算结果 */
- (instancetype)manager:(int(^)(int result))sumBlcok {
    _newResult = sumBlcok(_newResult);
    return self;
}

@end
