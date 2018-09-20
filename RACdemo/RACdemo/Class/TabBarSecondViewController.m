//
//  TabBarSecondViewController.m
//  RACdemo
//
//  Created by hanbo on 2018/9/18.
//  Copyright © 2018年 hanbo. All rights reserved.
//

#import "TabBarSecondViewController.h"
#import "RACDisposableViewController.h"

@interface TabBarSecondViewController ()

@end

@implementation TabBarSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(100, 100, 100, 50);
    
   
    /** RAC最常见的类 */
    /*
       1.通过RACSingnal (创建信号,冷信号)
       2.通过订阅者,订阅信号(完成:热信号)
       3.发送信号
     */
    
    /*
     didSubScrber调用 : 只要一个信号被调用就调用
     didSubScrber作用 : 利用subScrber发送数据
     didSubScrber的blcok能否执行,取决于信号是否被订阅
     */
    RACSignal *single = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"block被执行");
//        // 3.发送信号
//        [subscriber sendNext:@"hello CC"];
        return nil;
    }];
    
    // 2.订阅信号 (热信号)
    /*
     nextBlock调用: 只要订阅者发送数据,信号就会被调用
     nextBlock作用: 处理数据,展示UI
     nextBlock是否被调用,取决于订阅者是否发送了信号
     */
    [single subscribeNext:^(id  _Nullable x) {
       NSLog(@"%@", x);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - handle action
- (void)handleAction:(UIButton *)sedner {
    RACDisposableViewController *secondVC = [[RACDisposableViewController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
}
@end
