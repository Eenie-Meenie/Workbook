//
//  RACDisposableViewController.m
//  RACdemo
//
//  Created by hanbo on 2018/9/18.
//  Copyright © 2018年 hanbo. All rights reserved.
//

#import "RACDisposableViewController.h"

@interface RACDisposableViewController ()

/**  */
@property (nonatomic, strong) id<RACSubscriber> subscriber;

@end

@implementation RACDisposableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     RACDispoable:帮助我们取消订阅用的
     什么时候需要取消订阅?
     1.信号发送完毕;
     2.信号发送失败; 
    */
    
    
    // 测试测试测试
    
//    @weakify(self);
    RACSignal *single = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
//        @strongify(self);
        NSLog(@"block被执行");
        //        // 3.发送信号
                [subscriber sendNext:@"hello CC"];
        
        _subscriber = subscriber;
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"订阅被取消");
        }];
    }];
    
   
    
    //2.订阅信号
    RACDisposable *disposable = [single subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    // 默认一个信号发送数据完毕之后,就会主动取消订阅;
    // 只要订阅者在,就不会自动取消订阅
    // 手动取消订阅?
    
    [disposable dispose];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
