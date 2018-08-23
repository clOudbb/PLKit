//
//  UIAlertController+PLExten.m
//  PLKit
//
//  Created by qmtv on 2018/4/17.
//  Copyright © 2018年 clOud. All rights reserved.
//

#import "UIAlertController+PLExten.h"

@implementation UIAlertController (PLExten)

+ (UIAlertController *)pl_alertControllerWithTitle:(NSString *)title message:(NSString *)message confirm:(NSString *)confirm cancel:(NSString *)cancel confirmHandler:(void(^)(UIAlertAction *))confirmHandler cancelHandler:(void(^)(UIAlertAction *))cancelHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *_confirm = [UIAlertAction actionWithTitle:confirm style:UIAlertActionStyleDefault handler:confirmHandler];
    UIAlertAction *_cancel = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleDefault handler:cancelHandler];
    [alert addAction:_cancel];
    [alert addAction:_confirm];
    return alert;
}


@end
