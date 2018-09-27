//
//  SecondViewController.h
//  RACdemo
//
//  Created by hanbo on 2018/9/7.
//  Copyright © 2018年 hanbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController



/** 代替代理信号类 */
@property (nonatomic, strong) RACSubject *delegateSignal;


@end
