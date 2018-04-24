//
//  UIButton+PLAttachment.m
//  PLKit
//
//  Created by qmtv on 2018/4/24.
//  Copyright © 2018年 clOud. All rights reserved.
//

#import "UIButton+PLAttachment.h"

static inline bool validText(NSString *text)
{
    return (![text isEqualToString:@""] && text.length > 0 && [text isKindOfClass:[NSString class]]);
}

@implementation UIButton (PLAttachment)

- (void)pl_attachment:(PLButtonAlignment)alignment space:(float)spacing
{
    if (!self.imageView.image) return;
    if (!validText(self.titleLabel.text)) return;
    
    CGFloat imageWidth = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;

    CGFloat estimateWidth = 0;
    CGFloat estimateHeight = 0;

    estimateWidth = self.frame.size.width != 0 ? self.frame.size.width : [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}].width;
    estimateHeight = self.frame.size.height != 0 ? self.frame.size.height : [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}].height;

    CGFloat labelWidth = [self.titleLabel.text boundingRectWithSize:(CGSize){MAXFLOAT, estimateHeight} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.titleLabel.font} context:nil].size.width;
    CGFloat labelHeight = [self.titleLabel.text boundingRectWithSize:(CGSize){estimateWidth, MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.titleLabel.font} context:nil].size.height;
    
    CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;//image中心移动的x距离
    CGFloat imageOffsetY = imageHeight / 2 + spacing / 2;//image中心移动的y距离
    CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;//label中心移动的x距离
    CGFloat labelOffsetY = labelHeight / 2 + spacing / 2;//label中心移动的y距离
    
    CGFloat tempWidth = MAX(labelWidth, imageWidth);
    CGFloat changedWidth = labelWidth + imageWidth - tempWidth;
    CGFloat tempHeight = MAX(labelHeight, imageHeight);
    CGFloat changedHeight = labelHeight + imageHeight + spacing - tempHeight;
    
    
    switch (alignment) {
        case PLButtonAlignmentLeft:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            
            if (self.frame.size.width == 0) {
                CGFloat maxWidth = MAX(imageWidth + labelWidth + spacing * 3, self.frame.size.width);
                self.frame = (CGRect){self.frame.origin.x, self.frame.origin.y, maxWidth, MAX(imageHeight, labelHeight) + spacing * 2};
            }
        }
            break;
            
        case PLButtonAlignmentRight:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + spacing/2), 0, imageWidth + spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            
            if (self.frame.size.width == 0) {
                CGFloat maxWidth = MAX(imageWidth + labelWidth + spacing * 3, self.frame.size.width);
                self.frame = (CGRect){self.frame.origin.x, self.frame.origin.y, maxWidth, MAX(imageHeight, labelHeight) + spacing * 2};
            }
        }
            break;
            
        case PLButtonAlignmentTop:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth/2, changedHeight-imageOffsetY, -changedWidth/2);
            
            if (self.frame.size.height == 0) {
                CGFloat maxHeight = MAX(imageHeight + labelHeight + spacing * 3, self.frame.size.height);
                self.frame = (CGRect){self.frame.origin.x, self.frame.origin.y,  MAX(imageWidth, labelWidth) + spacing * 2, maxHeight};
            }
        }
            break;
        case PLButtonAlignmentBottom:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight-imageOffsetY, -changedWidth/2, imageOffsetY, -changedWidth/2);
            if (self.frame.size.height == 0) {
                CGFloat maxHeight = MAX(imageHeight + labelHeight + spacing * 3, self.frame.size.height);
                self.frame = (CGRect){self.frame.origin.x, self.frame.origin.y,  MAX(imageWidth, labelWidth) + spacing * 2, maxHeight};
            }
        }
            break;
        default:
            break;
    }
}

@end
