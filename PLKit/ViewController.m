//
//  ViewController.m
//  test
//
//  Created by qmtv on 2018/4/16.
//  Copyright © 2018年 clOud. All rights reserved.
//

#import "ViewController.h"
#import "NSNotificationCenter+Exten.h"
#import "UIAlertController+PLExten.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] pl_addObsever:self name:@"kNotification" object:nil usingBlock:^(NSNotification *notif) {
        if (notif.object) {
            NSLog(@"%@", notif.object);
            [[NSNotificationCenter defaultCenter] pl_removeObserver:self];
        }
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor orangeColor];
    button.frame = (CGRect){100, 100, 100, 30};
    [button addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)send:(UIButton *)button
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotification" object:@"test"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
