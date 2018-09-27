//
//  MVVMView.m
//  RACdemo
//
//  Created by hanbo on 2018/9/25.
//  Copyright © 2018年 hanbo. All rights reserved.
//

#import "MVVMView.h"
#import "MVVMViewModel.h"

@interface MVVMView ()

/**  */
@property (nonatomic, strong) UILabel *lbContent;
/** <#注释#> */
@property (nonatomic, strong) UIButton *btn;

/** viewModel */
@property (nonatomic, strong) MVVMViewModel *viewModel;

@end

@implementation MVVMView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.lbContent = [UILabel new];
        [self addSubview:_lbContent];
        _lbContent.frame = CGRectMake(100, 100, 100, 30);
        _lbContent.font = [UIFont systemFontOfSize:20];
        _lbContent.textColor = [UIColor redColor];
        
        [self createrSubviews];
    }
    return self;
}

- (void)createrSubviews {
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.btn];
    
    _btn.frame = CGRectMake(100, 200, 100, 50);
    [_btn setTitle:@"print" forState:UIControlStateNormal];
    
    // 点击事件
    
    [[_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        [_viewModel onPrintClick];
        
    }];
}


// 绑定数据
- (void)setWithViewModel:(MVVMViewModel *)vm {
    
    self.viewModel = vm;
    
    // 绑定
    // 
//    RAC(_lbContent,text) = RACObserve(self.viewModel, contentStr);
    
    
   //  RAC代替KVO
    [[self.viewModel rac_valuesForKeyPath:@"contentStr" observer:self] subscribeNext:^(id  _Nullable x) {
        NSLog(@"==%@", x);
           _lbContent.text = x;
    }];
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//
//    NSString *newContent = change[NSKeyValueChangeNewKey];
//    _lbContent.text = newContent;
//
//}
//
//- (void)dealloc {
//    [self removeObserver:self forKeyPath:@"contentStr"];
//}
@end
