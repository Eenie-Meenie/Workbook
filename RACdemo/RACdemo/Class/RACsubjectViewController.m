//
//  RACsubjectViewController.m
//  RACdemo
//
//  Created by hanbo on 2018/9/20.
//  Copyright © 2018年 hanbo. All rights reserved.
//

#import "RACsubjectViewController.h"

@interface RACsubjectViewController ()

@end

@implementation RACsubjectViewController

- (RACSubject *)btnClickSignle {
    if (!_btnClickSignle) {
        _btnClickSignle = [RACSubject subject];
    }
    return _btnClickSignle;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"RAC网络请求";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self racDelegate];
    
    /** 一个界面多个网络请求 */
   
    
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        //     AFN  请求数据
        NSLog(@"网络请求数据1");
        
        [subscriber sendNext:@"热销模块数据"];
        
        return nil;
    }];
    
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // AFN 请求数据
        NSLog(@"网络请求数据2");
        [subscriber sendNext:@"最新模块数据"];
        
        return nil;
    }];
    
    
    // 相当于KVO监听
    // 只要对象的属性一改变就会产生信号
//    [RACObserve(self.navigationItem, title) subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];
    
    // RAC宏的使用
//     RAC(self.navigationItem,title) = signal1;
//
    // 相当于
//    [signal1 subscribeNext:^(id  _Nullable x) {
//        self.navigationItem.title = x;
//    }];
    

    // 当数组中所有信号都发送数据的时候,才会执行selector
    // 方法的参数:必须跟数组的信号 ----- 一一对应
    // 方法的参数:就是每一个信号发送的数据
    [self rac_liftSelector:@selector(upDateUIhotaData:newdata:) withSignalsFromArray:@[signal1,signal2]];
    
    
    // 请求完一个请求之后,继续请求
//    [self rac_liftSelector:@selector(rquestData:) withSignals:signal1, nil];
    
    
    // RACCommand:处理事件 网络请求等
    // RACCommand:不能返回一个空的信号
    // 当前命令内部发送数据完成,一定要主动发送完成
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        // input:执行命令传入的参数
        // block调用:执行命令时会调用
        NSLog(@"--%@--", input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            // 发送数据
            [subscriber sendNext:@"执行命令产生的数据!"];
            [subscriber sendCompleted]; // 主动发送完成
            return nil;
        }];
    }];
    
    // 如何拿到执行命令中产生的数据
    // 订阅命令内部的信号
    // 方式一: 直接订阅执行命令返回的信号
    
//    // 2.执行命令
//   RACSignal *sig1 = [command execute:@1];
//
//    // 3.订阅信号
//    [sig1 subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];
    
    // 订阅信号
    // 注意:必须要在执行命令之前订阅
    // executionSignals:信号源 信号中的信号,signalOFsignals:信号:发送数据就是信号
//    [command.executionSignals subscribeNext:^(id  _Nullable x) {
//        [x subscribeNext:^(id  _Nullable x) {
//            NSLog(@"%@", x);
//        }];
//    }];
    
    // switchToLatest:获取最新发送的信号,只能用于信号中的信号
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"---%@---",x);
    }];
    
    
    // 监听事件有没有完成
    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
        
        BOOL isFinish = [x boolValue];
        if (isFinish) {
            NSLog(@"当前正在执行");
        } else {
            NSLog(@"没有执行,执行完成");
        }
    }];
    
    // 2.执行命令
    [command execute:@1];
}

- (void)rquestData:(NSString *)data {
    NSLog(@"请求到数据,继续请求 %@", data);
    
 
    
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // AFN 请求数据
        NSLog(@"网络请求数据2");
        [subscriber sendNext:@"最新模块数据"];
        
        return nil;
    }];
    
    [signal2 subscribeNext:^(id  _Nullable x) {
        NSLog(@"=====%@",x);
    }];
    
}

- (void)upDateUIhotaData:(NSString *)data newdata:(NSString *)newData {
    NSLog(@"更新UI %@, %@", data, newData);
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)racDelegate {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"代替代理返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(100, 100, 100, 50);
}

- (void)handleAction:(UIButton *)sender {
    
    [self.btnClickSignle sendNext:[UIColor orangeColor]];
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
