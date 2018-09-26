//
//  MVVMViewModel.m
//  RACdemo
//
//  Created by hanbo on 2018/9/25.
//  Copyright © 2018年 hanbo. All rights reserved.
//

#import "MVVMViewModel.h"
#import "MVVMPaper.h"


@interface MVVMViewModel ()

/** <#注释#> */
@property (nonatomic, strong) MVVMPaper *model;

@end

@implementation MVVMViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)setWithModel:(MVVMPaper *)papaer {
    self.model = papaer;
    self.contentStr = papaer.content;
}


- (void)onPrintClick {
    self.model.content = @"line 1";
    self.contentStr = self.model.content;
}

@end
