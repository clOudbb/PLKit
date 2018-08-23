//
//  NSString+PLExten.h
//  PLKit
//
//  Created by qmtv on 2018/5/9.
//  Copyright © 2018年 clOud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PLExten)
/**
 * 完美移除空格 . 等符号
 * 场景例如通讯录
 */
+ (NSString *)removeSpaceAndNewline:(NSString *)str;

@end
