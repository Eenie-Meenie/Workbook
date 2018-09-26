//
//  MVVMView.h
//  RACdemo
//
//  Created by hanbo on 2018/9/25.
//  Copyright © 2018年 hanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MVVMViewModel;

@interface MVVMView : UIView

- (void)setWithViewModel:(MVVMViewModel *)vm;

@end
