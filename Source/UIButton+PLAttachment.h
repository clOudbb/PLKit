//
//  UIButton+PLAttachment.h
//  PLKit
//
//  Created by qmtv on 2018/4/24.
//  Copyright © 2018年 clOud. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PLButtonAlignment)
{
    PLButtonAlignmentLeft = 0,
    PLButtonAlignmentRight,
    PLButtonAlignmentTop,
    PLButtonAlignmentBottom
};

@interface UIButton (PLAttachment)


- (void)pl_attachment:(PLButtonAlignment)alignment space:(float)space;


@end
