//
//  MainViewController.m
//  RACdemo
//
//  Created by hanbo on 2018/9/7.
//  Copyright © 2018年 hanbo. All rights reserved.
//

#import "MainViewController.h"
#import "SecondViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"RAC";
    
   
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(100, 100, 100, 50);
    
//    RACSignal *siganl = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//
//        // blcok 调用
//
//        [subscriber sendNext:@1];
//
//        [subscriber sendCompleted];
//
//        return [RACDisposable disposableWithBlock:^{
//            NSLog(@"信号被销毁");
//        }];
//    }];
//
//    [siganl subscribeNext:^(id  _Nullable x) {
//
//        NSLog(@"接收到信号数据:%@",x);
//
//    }];
    
    // 1.创建信号
    RACSubject *subject = [RACSubject subject];
    // 2.订阅信号
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收信号 : %@", x);
    }];
    
    // 3.发送数据
    [subject sendNext:@"Hello world!"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - handle action
- (void)handleAction:(UIButton *)sedner {
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    
    secondVC.delegateSignal = [RACSubject subject];
    
//    @weakify(self);
    
    [secondVC.delegateSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"代替了代理 %@", x);
        
        
    }];
    
    [self.navigationController pushViewController:secondVC animated:YES];
}

@end
