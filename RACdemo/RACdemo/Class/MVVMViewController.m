//
//  MVVMViewController.m
//  RACdemo
//
//  Created by hanbo on 2018/9/19.
//  Copyright © 2018年 hanbo. All rights reserved.
//


#import "MVVMViewController.h"


typedef void(^HHBlock)(id data);
@interface MVVMViewController ()

/** <#注释#> */
@property (nonatomic, copy) HHBlock block;

@end

@implementation MVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:redView];
    
    [redView makeConstraints:^(MASConstraintMaker *make) {
         make.top.left.equalTo(10);
        make.bottom.right.equalTo(-10);
    }];
    
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 4; i ++) {
        UIView *v = [UIView new];
        v.backgroundColor = [UIColor greenColor];
        [redView addSubview:v];
        [array addObject:v];
    }
    
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:10 tailSpacing:10];
    
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(120);
        make.height.mas_equalTo(60);
    }];
    
    [self loadData];
    
   
    // Do any additional setup after loading the view.
    
}

- (void)loadData {
    
    self.block = ^(id data) {
        NSLog(@"%@", data);
    };
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.block(@"aaaaa");
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
