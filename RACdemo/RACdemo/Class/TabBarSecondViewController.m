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

/** <#注释#> */
@property (nonatomic, strong) UITextField *userTF;
/**  */
@property (nonatomic, strong) UITextField *passWardTF;
/**  */
@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation TabBarSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self styduRAC];  //学习RAC
    
    self.userTF = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
    _userTF.textColor = [UIColor redColor];
    _userTF.borderStyle = UITextBorderStyleRoundedRect;
    _userTF.placeholder = @"账号";
    [self.view addSubview:_userTF];
    
    self.passWardTF = [[UITextField alloc] initWithFrame:CGRectMake(100, 200, 200, 40)];
    _passWardTF.textColor = [UIColor redColor];
    _passWardTF.borderStyle = UITextBorderStyleRoundedRect;
    _passWardTF.placeholder = @"密码";
    [self.view addSubview:_passWardTF];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    _loginBtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_loginBtn];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passWardTF.mas_bottom).offset(100);
        make.width.equalTo(100);
        make.height.equalTo(40);
        make.centerX.mas_equalTo(self.passWardTF.mas_centerX);
    }];
    
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"按钮点击");
    }];
    
    /** 组合信号 */
    RACSignal *enbleSignal = [[RACSignal combineLatest:@[self.userTF.rac_textSignal, self.passWardTF.rac_textSignal]] map:^id _Nullable(RACTuple * _Nullable value) {
        
        // 账号输入框有文字,密码文字大于6
        return @([value[0] length] > 0 && [value[1] length] > 6);
    }];
    
    [enbleSignal subscribeNext:^(id  _Nullable x) {
        
        BOOL isX = [x boolValue];
        if (isX) {
            self.loginBtn.backgroundColor = [UIColor redColor];
        } else {
            self.loginBtn.backgroundColor = [UIColor blackColor];
        }
    }];
    
//    self.loginBtn.rac_command = [[RACCommand alloc] initWithEnabled:enbleSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//        return [RACSignal empty];
//    }];
    

}

- (void)styduRAC {
    // 元祖
    RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[@"aaa", @"bbb", @"ccc"]];
    
    NSString *str = tuple[0];
    
    NSLog(@"%@", str);
    NSLog(@"%@", tuple);
    
    
    // RACSequence 用于代替NSArray, NSDictionary 可以使用快速遍历
    // 数据解析 最常见应用场景:字典转模型
    
    NSArray *array = @[@"111",@"222",@"333",@"444",@"555",@"666"];
    
    /*
     RACSequence *requence = [array rac_sequence];
     
     RACSignal *single1 = [requence signal];
     
     [single1 subscribeNext:^(id  _Nullable x) {
     NSLog(@"---%@---",x);
     }];
     */
    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    
    NSDictionary *dict = @{@"name":@"CC", @"age":@"18"};
    
    // 字典转集合
    // 遍历字典
    //    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
    //        NSLog(@"%@", x);
    //
    ////        NSString *key = x[0];     // 字典的key
    ////        NSString *value = x[1];   // 字典的value
    ////
    ////        NSLog(@"key:%@ -- value:%@", key,value);
    //
    //        // 解析元祖 : RACTuplePack(<#...#>)
    //
    //        RACTuplePack(NSString *key, NSString *value) = x;
    //
    //        NSLog(@"%@:%@", key,value);
    //
    //    }];
    //
    
    
    
    
    
    
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
    
    [[secondVC rac_signalForSelector:@selector(laile:)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"%@", x);
        
    }];
    
    [self.navigationController pushViewController:secondVC animated:YES];
}
@end
