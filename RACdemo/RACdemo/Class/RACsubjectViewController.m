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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"代替代理返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(100, 100, 100, 50);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
