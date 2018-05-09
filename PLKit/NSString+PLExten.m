//
//  NSString+PLExten.m
//  PLKit
//
//  Created by qmtv on 2018/5/9.
//  Copyright © 2018年 clOud. All rights reserved.
//

#import "NSString+PLExten.h"

@implementation NSString (PLExten)

+ (NSString *)removeSpaceAndNewline:(NSString *)str
{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"·" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"-" withString:@""];
    temp = [[temp componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    return temp;
}

@end
