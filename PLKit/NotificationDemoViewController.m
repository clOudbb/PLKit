//
//  NotificationDemoViewController.m
//  PLKit
//
//  Created by qmtv on 2018/8/23.
//  Copyright © 2018年 clOud. All rights reserved.
//

#import "NotificationDemoViewController.h"
#import "PLKit.h"
@interface NotificationDemoViewController ()

@end

@implementation NotificationDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    [[NSNotificationCenter defaultCenter] pl_addObsever:self name:@"kNotification" object:nil usingBlock:^(NSNotification *notif) {
    //        if (notif.object) {
    //            NSLog(@"%@", notif.object);
    //            [[NSNotificationCenter defaultCenter] pl_removeObserver:self];
    //        }
    //    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor orangeColor];
    button.frame = (CGRect){100, 100, 100, 30};
    [button setImage:[UIImage imageNamed:@"exit"] forState:UIControlStateNormal];
    [button setTitle:@"绝地求生：刺激战场" forState:UIControlStateNormal];
    //    [button pl_attachment:PLButtonAlignmentTop space:5];
    [button addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //    [button setTitle:@"绝地求生" forState:UIControlStateNormal];
    //    [button setImage:[UIImage imageNamed:@"teleportName"] forState:UIControlStateNormal];
    //
    //    [button setTitle:@"绝地求生wee1e21ewqfqf...." forState:UIControlStateNormal];
    //    [button pl_attachment:PLButtonAlignmentRight space:5];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test:) name:@"kNotification" object:nil];
}

- (void)send:(UIButton *)button
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotification" object:@"test"];
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
