//
//  ChainViewController.m
//  RACdemo
//
//  Created by hanbo on 2018/9/20.
//  Copyright © 2018年 hanbo. All rights reserved.
//

#import "ChainViewController.h"
#import "NSObject+Sum.h"
#import "SumManager.h"

@interface ChainViewController ()

@end

@implementation ChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /** 链式编程 */
    int result = [NSObject HB_makeSub:^(SumManager *manager) {
        
    manager.add(10).add(20).add(20).addsumValue(20).addsumValue(30);
        
    }];
    
    NSLog(@"%d", result);
    
    /** 函数编程 */
    SumManager *mgr = [[SumManager alloc] init];
    
    int res = [[mgr manager:^int(int result) {
        result += 10;
        result *= 2;
        return result;
    }] result];
    
    
    NSLog(@"%d", res);
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
