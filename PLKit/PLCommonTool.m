//
//  PLCommonTool.m
//  PLKit
//
//  Created by qmtv on 2018/7/18.
//  Copyright © 2018年 clOud. All rights reserved.
//

#import "PLCommonTool.h"

@implementation PLCommonTool


#pragma mark - valid
inline bool pl_validString(__kindof NSString *str)
{
    return (str && [str isKindOfClass:[NSString class]] && ![str isEqualToString:@""] && str.length > 0);
}

inline bool pl_validArray(__kindof NSArray *arr)
{
    return (arr && [arr isKindOfClass:[NSArray class]] && arr.count > 0);
}

inline bool pl_validDictionary(__kindof NSDictionary *dic)
{
    return (dic && [dic isKindOfClass:[NSDictionary class]] && dic.allKeys.count > 0);
}

inline bool pl_validSet(__kindof NSSet *set)
{
    return (set && [set isKindOfClass:[NSSet class]] && set.count > 0);
}

#pragma mark - UIInterfaceOrientation
inline UIInterfaceOrientation UIStatusBarOrientation()
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    return orientation;
}

inline bool UIStatusBarOrientationIsLandscape()
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    return (orientation == UIInterfaceOrientationLandscapeLeft)|| (orientation == UIInterfaceOrientationLandscapeRight);
}

inline bool UIStatusBarOrientationIsPortrait()
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    return (orientation == UIInterfaceOrientationPortrait);
}

@end
