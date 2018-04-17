//
//  UIAlertController+PLExten.m
//  PLKit
//
//  Created by qmtv on 2018/4/17.
//  Copyright © 2018年 clOud. All rights reserved.
//

#import "UIAlertController+PLExten.h"

@interface _UIAlertController :NSObject


@end
@implementation _UIAlertController

@end


@implementation UIAlertController (PLExten)

+ (UIAlertController *)qm_alertControllerWithTitle:(NSString *)title message:(NSString *)message confirm:(NSString *)confirm cancel:(NSString *)cancel confirmHandler:(void(^)(UIAlertAction *))confirmHandler cancelHandler:(void(^)(UIAlertAction *))cancelHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *_confirm = [UIAlertAction actionWithTitle:confirm style:UIAlertActionStyleDefault handler:confirmHandler];
    UIAlertAction *_cancel = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleDefault handler:cancelHandler];
    [alert addAction:_confirm];
    [alert addAction:_cancel];
    return alert;
}


@end
