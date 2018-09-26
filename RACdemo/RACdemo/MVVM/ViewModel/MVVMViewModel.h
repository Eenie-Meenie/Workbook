//
//  MVVMViewModel.h
//  RACdemo
//
//  Created by hanbo on 2018/9/25.
//  Copyright © 2018年 hanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MVVMPaper;

@interface MVVMViewModel : NSObject

/** <#注释#> */
@property (nonatomic, copy) NSString *contentStr;


- (void)setWithModel:(MVVMPaper *)papaer;
- (void)onPrintClick;

@end
