//
//  PLCommonTool.h
//  PLKit
//
//  Created by qmtv on 2018/7/18.
//  Copyright © 2018年 clOud. All rights reserved.
//

@import UIKit;

@interface PLCommonTool : NSObject

bool pl_validString(__kindof NSString *str);
bool pl_validArray(__kindof NSArray *arr);
bool pl_validDictionary(__kindof NSDictionary *dic);
bool pl_validSet(__kindof NSSet *set);

/**
 * 获取屏幕status bar方向
 */
UIInterfaceOrientation UIStatusBarOrientation(void);
/**
 * 是否横屏
 */
bool UIStatusBarOrientationIsLandscape(void);
/**
 * 是否竖屏
 */
bool UIStatusBarOrientationIsPortrait(void);
@end
