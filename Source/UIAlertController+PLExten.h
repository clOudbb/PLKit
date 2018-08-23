//
//  UIAlertController+PLExten.h
//  PLKit
//
//  Created by qmtv on 2018/4/17.
//  Copyright © 2018年 clOud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (PLExten)
/**
 * show a default alert controller
 */
+ (UIAlertController *)pl_alertControllerWithTitle:(NSString *)title message:(NSString *)message confirm:(NSString *)confirm cancel:(NSString *)cancel confirmHandler:(void(^)(UIAlertAction *confirmAction))confirmHandler cancelHandler:(void(^)(UIAlertAction *cancelAction))cancelHandler;

@end
