//
//  MainViewController.m
//  RACdemo
//
//  Created by hanbo on 2018/9/7.
//  Copyright © 2018年 hanbo. All rights reserved.
//

#import "MainViewController.h"
#import "SecondViewController.h"
#import "RACsubjectViewController.h"

#import <ReactiveObjC/NSObject+RACKVOWrapper.h>

@interface MainViewController ()

/**  UILabel *label */
@property (nonatomic, strong)  UILabel *label;

/** 全局的time */
@property (nonatomic, strong) dispatch_source_t timer;

/** <#注释#> */
@property (nonatomic, strong) UIButton *sendButton;

/** <#注释#> */
@property (nonatomic, assign) NSInteger time;

/** 取消订阅 */
@property (nonatomic, strong) RACDisposable *disposable;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"RAC";
    
//    NSDictionary *dic = @{@"adb":@"和斯科拉里"};
//
//    NSString *str = [dic mj_JSONString];
//
//    // 写入文件到电脑上
//    [dic writeToFile:@"/Users/hanbo/Desktop/项目切图/ceshi.plist"atomically:YES];
//
//    [str writeToFile:@"/Users/hanbo/Desktop/项目切图/c123.json" atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    // RAC代替KVO
    [self.view rac_observeKeyPath:@"frame" options:NSKeyValueObservingOptionNew observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        NSLog(@"======%@", change);
    }];
    
    // RAC代替KVO
    [[self.view rac_valuesForKeyPath:@"frame" observer:self] subscribeNext:^(id  _Nullable x) {
        NSLog(@"==%@", x);
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"键盘调取");
    }];
    
   
//    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 200, 100, 40)];
//    tf.placeholder = @"sjljf";
//    [self.view addSubview:tf];
    
//    /** 键盘监听事件 */
//    [tf.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"%@", x);
//    }];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    
    
    // 点击事件
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        NSLog(@"xxxxx");
        
    }];
    
//    [button addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(100, 100, 200, 50);
    
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sendButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    
    // 点击事件
    [[self.sendButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        // 改变按钮状态
        self.sendButton.enabled = NO;
        
        // 倒计时时间
        self.time = 10;
        
     self.disposable = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
            
            // 减去时间
            self.time --;
            // 设置文字
            NSString *text = _time > 0 ? [NSString stringWithFormat:@"请等待%ld秒", _time] : @"重新发送";
//
//            [self.sendButton setTitle:text forState:UIControlStateNormal];
         
         [self.sendButton setTitle:text forState:_time >= 0 ? (UIControlStateDisabled) : (UIControlStateNormal)];
         
            if (_time >= 0) {
                self.sendButton.enabled = NO;
            } else {
                self.sendButton.enabled = YES;
                // 取消订阅
                [_disposable dispose];
            }
        }];
        
    }];
    
    //    [button addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sendButton];
    self.sendButton.backgroundColor = [UIColor redColor];
    self.sendButton.frame = CGRectMake(100, 200, 200, 50);
    
    
    UIButton *racButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [racButton setTitle:@"RAC" forState:UIControlStateNormal];
    [racButton addTarget:self action:@selector(racDelegate:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:racButton];
    racButton.backgroundColor = [UIColor redColor];
    racButton.frame = CGRectMake(100, 300, 100, 50);
    
    self.label = [[UILabel alloc] init];
    self.label.text = @"wnlfjfj";
    _label.textColor = [UIColor redColor];
    [self.view addSubview:_label];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(racButton.bottom).offset(40);
        make.centerX.equalTo(self.view);
    }];
    
    
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
    
//    [self GCDTimer]; // GCD定时器
    
}

- (void)demo1 {
    // 定时器
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeMethod) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)RACtimer {
    [[RACSignal interval:1.0 onScheduler:[RACScheduler scheduler]] subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"RAC定时器");
    }];
}

- (void)GCDTimer {
    
    // GCD设置timer
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    
    // GCD时间事件 间隔一秒
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
        [self timeMethod];
        
    });
    dispatch_resume(timer);
    _timer = timer;
}

- (void)timeMethod {
    NSLog(@"定时器执行");
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

/** 第二个按钮点击 */
- (void)racDelegate:(UIButton *)sender {
    RACsubjectViewController *vc = [[RACsubjectViewController alloc] init];
    
    [vc.btnClickSignle subscribeNext:^(id  _Nullable x) {
//        self.label.text = [NSString stringWithFormat:@"%@",x];
        self.view.backgroundColor = x;
        NSLog(@"%@", x);
    }];
    
    [self.navigationController pushViewController:vc animated:YES];
}

// 定时器暂停
-(void)pauseTimer{
    if(_timer){
        dispatch_suspend(_timer);
    }
}
// 定时器继续
-(void)resumeTimer{
    if(_timer){
        dispatch_resume(_timer);
    }
}
// 定时器停止
-(void)stopTimer{
    if(_timer){
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

@end
