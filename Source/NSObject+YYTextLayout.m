//
//  NSObject+YYTextLayout.m
//  PLKit
//
//  Created by qmtv on 2018/5/31.
//  Copyright © 2018年 clOud. All rights reserved.
//

#import "NSObject+YYTextLayout.h"
#import <objc/message.h>
#import <UIKit/UIKit.h>
typedef struct {
    CGFloat head;
    CGFloat foot;
} YYRowEdge;

@implementation NSObject (YYTextLayout)

/**
 * YYText iOS10 如果有emoji表情，coreText的计算高度会不准确，并且中间会拦截掉方法，导致layout没有成功生成。
 * 这个方法可以暂时从外部解决问题，后续考虑提交pr给YYText，从内部解决问题
 */
//- (YYTextLayout *)yy_layoutWithContainer:(YYTextContainer *)container text:(NSAttributedString *)text range:(NSRange)range
//{
//    YYTextLayout *layout = NULL;
//    CGPathRef cgPath = nil;
//    CGRect cgPathBox = {0};
//    BOOL isVerticalForm = NO;
//    BOOL rowMaySeparated = NO;
//    NSMutableDictionary *frameAttrs = nil;
//    CTFramesetterRef ctSetter = NULL;
//    CTFrameRef ctFrame = NULL;
//    CFArrayRef ctLines = nil;
//    CGPoint *lineOrigins = NULL;
//    NSUInteger lineCount = 0;
//    NSMutableArray *lines = nil;
//    NSMutableArray *attachments = nil;
//    NSMutableArray *attachmentRanges = nil;
//    NSMutableArray *attachmentRects = nil;
//    NSMutableSet *attachmentContentsSet = nil;
//    BOOL needTruncation = NO;
//    NSAttributedString *truncationToken = nil;
//    YYTextLine *truncatedLine = nil;
//    YYRowEdge *lineRowsEdge = NULL;
//    NSUInteger *lineRowsIndex = NULL;
//    NSRange visibleRange;
//    NSUInteger maximumNumberOfRows = 0;
//    BOOL constraintSizeIsExtended = NO;
//    CGRect constraintRectBeforeExtended = {0};
//
//    text = text.mutableCopy;
//    container = container.copy;
//    if (!text || !container) return nil;
//    if (range.location + range.length > text.length) return nil;
//    //    container->_readonly = YES;
//    [container setValue:@1 forKey:@"readonly"];
//    maximumNumberOfRows = container.maximumNumberOfRows;
//
//    // CoreText bug when draw joined emoji since iOS 8.3.
//    // See -[NSMutableAttributedString setClearColorToJoinedEmoji] for more information.
//    static BOOL needFixJoinedEmojiBug = NO;
//    // It may use larger constraint size when create CTFrame with
//    // CTFramesetterCreateFrame in iOS 10.
//    static BOOL needFixLayoutSizeBug = NO;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        CGFloat systemVersionFloat = [UIDevice currentDevice].systemVersion.floatValue;
//        if (8.3 <= systemVersionFloat && systemVersionFloat < 9) {
//            needFixJoinedEmojiBug = YES;
//        }
//        if (systemVersionFloat >= 10) {
//            needFixLayoutSizeBug = YES;
//        }
//    });
//    if (needFixJoinedEmojiBug) {
//        [((NSMutableAttributedString *)text) setClearColorToJoinedEmoji];
//    }
//
//    //    layout = [[YYTextLayout alloc] _init];
//    id temp = ((id (*)(id, SEL))(void *)objc_msgSend)((id)[YYTextLayout class], @selector(alloc));
//    layout = ((YYTextLayout *(*)(id, SEL))(void *)objc_msgSend)(temp, NSSelectorFromString(@"_init"));
//    [layout setValue:text forKey:@"text"];
//    [layout setValue:container forKey:@"container"];
//    [layout setValue:[NSValue valueWithRange:range] forKey:@"range"];
//    isVerticalForm = container.verticalForm;
//
//    // set cgPath and cgPathBox
//    if (container.path == nil && container.exclusionPaths.count == 0) {
//        if (container.size.width <= 0 || container.size.height <= 0) goto fail;
//        CGRect rect = (CGRect) {CGPointZero, container.size };
//        if (needFixLayoutSizeBug) {
//            constraintSizeIsExtended = YES;
//            constraintRectBeforeExtended = UIEdgeInsetsInsetRect(rect, container.insets);
//            constraintRectBeforeExtended = CGRectStandardize(constraintRectBeforeExtended);
//            if (container.isVerticalForm) {
//                rect.size.width = YYTextContainerMaxSize.width;
//            } else {
//                rect.size.height = YYTextContainerMaxSize.height;
//            }
//        }
//        rect = UIEdgeInsetsInsetRect(rect, container.insets);
//        rect = CGRectStandardize(rect);
//        cgPathBox = rect;
//        rect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeScale(1, -1));
//        cgPath = CGPathCreateWithRect(rect, NULL); // let CGPathIsRect() returns true
//    } else if (container.path && CGPathIsRect(container.path.CGPath, &cgPathBox) && container.exclusionPaths.count == 0) {
//        CGRect rect = CGRectApplyAffineTransform(cgPathBox, CGAffineTransformMakeScale(1, -1));
//        cgPath = CGPathCreateWithRect(rect, NULL); // let CGPathIsRect() returns true
//    } else {
//        rowMaySeparated = YES;
//        CGMutablePathRef path = NULL;
//        if (container.path) {
//            path = CGPathCreateMutableCopy(container.path.CGPath);
//        } else {
//            CGRect rect = (CGRect) {CGPointZero, container.size };
//            rect = UIEdgeInsetsInsetRect(rect, container.insets);
//            CGPathRef rectPath = CGPathCreateWithRect(rect, NULL);
//            if (rectPath) {
//                path = CGPathCreateMutableCopy(rectPath);
//                CGPathRelease(rectPath);
//            }
//        }
//        if (path) {
//            [layout.container.exclusionPaths enumerateObjectsUsingBlock: ^(UIBezierPath *onePath, NSUInteger idx, BOOL *stop) {
//                CGPathAddPath(path, NULL, onePath.CGPath);
//            }];
//
//            cgPathBox = CGPathGetPathBoundingBox(path);
//            CGAffineTransform trans = CGAffineTransformMakeScale(1, -1);
//            CGMutablePathRef transPath = CGPathCreateMutableCopyByTransformingPath(path, &trans);
//            CGPathRelease(path);
//            path = transPath;
//        }
//        cgPath = path;
//    }
//    if (!cgPath) goto fail;
//
//    // frame setter config
//    frameAttrs = [NSMutableDictionary dictionary];
//    if (container.isPathFillEvenOdd == NO) {
//        frameAttrs[(id)kCTFramePathFillRuleAttributeName] = @(kCTFramePathFillWindingNumber);
//    }
//    if (container.pathLineWidth > 0) {
//        frameAttrs[(id)kCTFramePathWidthAttributeName] = @(container.pathLineWidth);
//    }
//    if (container.isVerticalForm == YES) {
//        frameAttrs[(id)kCTFrameProgressionAttributeName] = @(kCTFrameProgressionRightToLeft);
//    }
//
//    // create CoreText objects
//    ctSetter = CTFramesetterCreateWithAttributedString((CFTypeRef)text);
//    if (!ctSetter) goto fail;
//    ctFrame = CTFramesetterCreateFrame(ctSetter, YYCFRangeFromNSRange(range), cgPath, (CFTypeRef)frameAttrs);
//    if (!ctFrame) goto fail;
//    lines = [NSMutableArray new];
//    ctLines = CTFrameGetLines(ctFrame);
//    lineCount = CFArrayGetCount(ctLines);
//    if (lineCount > 0) {
//        lineOrigins = malloc(lineCount * sizeof(CGPoint));
//        if (lineOrigins == NULL) goto fail;
//        CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, lineCount), lineOrigins);
//    }
//
//    CGRect textBoundingRect = CGRectZero;
//    CGSize textBoundingSize = CGSizeZero;
//    NSInteger rowIdx = -1;
//    NSUInteger rowCount = 0;
//    CGRect lastRect = CGRectMake(0, -FLT_MAX, 0, 0);
//    CGPoint lastPosition = CGPointMake(0, -FLT_MAX);
//    if (isVerticalForm) {
//        lastRect = CGRectMake(FLT_MAX, 0, 0, 0);
//        lastPosition = CGPointMake(FLT_MAX, 0);
//    }
//
//    // calculate line frame
//    NSUInteger lineCurrentIdx = 0;
//    for (NSUInteger i = 0; i < lineCount; i++) {
//        CTLineRef ctLine = CFArrayGetValueAtIndex(ctLines, i);
//        CFArrayRef ctRuns = CTLineGetGlyphRuns(ctLine);
//        if (!ctRuns || CFArrayGetCount(ctRuns) == 0) continue;
//
//        // CoreText coordinate system
//        CGPoint ctLineOrigin = lineOrigins[i];
//
//        // UIKit coordinate system
//        CGPoint position;
//        position.x = cgPathBox.origin.x + ctLineOrigin.x;
//        position.y = cgPathBox.size.height + cgPathBox.origin.y - ctLineOrigin.y;
//
//        YYTextLine *line = [YYTextLine lineWithCTLine:ctLine position:position vertical:isVerticalForm];
//        CGRect rect = line.bounds;
//
//        if (constraintSizeIsExtended) {
//            if (isVerticalForm) {
//                if (rect.origin.x + rect.size.width >
//                    constraintRectBeforeExtended.origin.x +
//                    constraintRectBeforeExtended.size.width) break;
//            } else {
//                这里由于上边的rect计算不准确，会break掉，导致后边计算都没有执行
//                if (rect.origin.y + rect.size.height >
//                    constraintRectBeforeExtended.origin.y +
//                    constraintRectBeforeExtended.size.height) {
//                    if ([UIDevice currentDevice].systemVersion.integerValue == 10) {
//                        CGRect bounds = [layout.text boundingRectWithSize:constraintRectBeforeExtended.size options:NSStringDrawingUsesLineFragmentOrigin context:nil];
//                        //                        ((void(*)(id, SEL, CGRect))(void *)objc_msgSend)((id)line, NSSelectorFromString(@"setBounds:"), bounds);
//                        [line setValue:[NSValue valueWithCGRect:bounds] forKey:@"bounds"];
//                    } else {
//                        break;
//                    }
//                }
//            }
//        }
//
//        BOOL newRow = YES;
//        if (rowMaySeparated && position.x != lastPosition.x) {
//            if (isVerticalForm) {
//                if (rect.size.width > lastRect.size.width) {
//                    if (rect.origin.x > lastPosition.x && lastPosition.x > rect.origin.x - rect.size.width) newRow = NO;
//                } else {
//                    if (lastRect.origin.x > position.x && position.x > lastRect.origin.x - lastRect.size.width) newRow = NO;
//                }
//            } else {
//                if (rect.size.height > lastRect.size.height) {
//                    if (rect.origin.y < lastPosition.y && lastPosition.y < rect.origin.y + rect.size.height) newRow = NO;
//                } else {
//                    if (lastRect.origin.y < position.y && position.y < lastRect.origin.y + lastRect.size.height) newRow = NO;
//                }
//            }
//        }
//
//        if (newRow) rowIdx++;
//        lastRect = rect;
//        lastPosition = position;
//
//        line.index = lineCurrentIdx;
//        line.row = rowIdx;
//        [lines addObject:line];
//        rowCount = rowIdx + 1;
//        lineCurrentIdx ++;
//
//        if (i == 0) textBoundingRect = rect;
//        else {
//            if (maximumNumberOfRows == 0 || rowIdx < maximumNumberOfRows) {
//                textBoundingRect = CGRectUnion(textBoundingRect, rect);
//            }
//        }
//    }
//
//    if (rowCount > 0) {
//        if (maximumNumberOfRows > 0) {
//            if (rowCount > maximumNumberOfRows) {
//                needTruncation = YES;
//                rowCount = maximumNumberOfRows;
//                do {
//                    YYTextLine *line = lines.lastObject;
//                    if (!line) break;
//                    if (line.row < rowCount) break;
//                    [lines removeLastObject];
//                } while (1);
//            }
//        }
//        YYTextLine *lastLine = lines.lastObject;
//        if (!needTruncation && lastLine.range.location + lastLine.range.length < text.length) {
//            needTruncation = YES;
//        }
//
//        // Give user a chance to modify the line's position.
//        if (container.linePositionModifier) {
//            [container.linePositionModifier modifyLines:lines fromText:text inContainer:container];
//            textBoundingRect = CGRectZero;
//            for (NSUInteger i = 0, max = lines.count; i < max; i++) {
//                YYTextLine *line = lines[i];
//                if (i == 0) textBoundingRect = line.bounds;
//                else textBoundingRect = CGRectUnion(textBoundingRect, line.bounds);
//            }
//        }
//
//        lineRowsEdge = calloc(rowCount, sizeof(YYRowEdge));
//        if (lineRowsEdge == NULL) goto fail;
//        lineRowsIndex = calloc(rowCount, sizeof(NSUInteger));
//        if (lineRowsIndex == NULL) goto fail;
//        NSInteger lastRowIdx = -1;
//        CGFloat lastHead = 0;
//        CGFloat lastFoot = 0;
//        for (NSUInteger i = 0, max = lines.count; i < max; i++) {
//            YYTextLine *line = lines[i];
//            CGRect rect = line.bounds;
//            if ((NSInteger)line.row != lastRowIdx) {
//                if (lastRowIdx >= 0) {
//                    lineRowsEdge[lastRowIdx] = (YYRowEdge) {.head = lastHead, .foot = lastFoot };
//                }
//                lastRowIdx = line.row;
//                lineRowsIndex[lastRowIdx] = i;
//                if (isVerticalForm) {
//                    lastHead = rect.origin.x + rect.size.width;
//                    lastFoot = lastHead - rect.size.width;
//                } else {
//                    lastHead = rect.origin.y;
//                    lastFoot = lastHead + rect.size.height;
//                }
//            } else {
//                if (isVerticalForm) {
//                    lastHead = MAX(lastHead, rect.origin.x + rect.size.width);
//                    lastFoot = MIN(lastFoot, rect.origin.x);
//                } else {
//                    lastHead = MIN(lastHead, rect.origin.y);
//                    lastFoot = MAX(lastFoot, rect.origin.y + rect.size.height);
//                }
//            }
//        }
//        lineRowsEdge[lastRowIdx] = (YYRowEdge) {.head = lastHead, .foot = lastFoot };
//
//        for (NSUInteger i = 1; i < rowCount; i++) {
//            YYRowEdge v0 = lineRowsEdge[i - 1];
//            YYRowEdge v1 = lineRowsEdge[i];
//            lineRowsEdge[i - 1].foot = lineRowsEdge[i].head = (v0.foot + v1.head) * 0.5;
//        }
//    }
//
//    { // calculate bounding size
//        CGRect rect = textBoundingRect;
//        if (container.path) {
//            if (container.pathLineWidth > 0) {
//                CGFloat inset = container.pathLineWidth / 2;
//                rect = CGRectInset(rect, -inset, -inset);
//            }
//        } else {
//            rect = UIEdgeInsetsInsetRect(rect, UIEdgeInsetsInvert(container.insets));
//        }
//        rect = CGRectStandardize(rect);
//        CGSize size = rect.size;
//        if (container.verticalForm) {
//            size.width += container.size.width - (rect.origin.x + rect.size.width);
//        } else {
//            size.width += rect.origin.x;
//        }
//        size.height += rect.origin.y;
//        if (size.width < 0) size.width = 0;
//        if (size.height < 0) size.height = 0;
//        size.width = ceil(size.width);
//        size.height = ceil(size.height);
//        textBoundingSize = size;
//    }
//
//    visibleRange = YYNSRangeFromCFRange(CTFrameGetVisibleStringRange(ctFrame));
//    if (needTruncation) {
//        YYTextLine *lastLine = lines.lastObject;
//        NSRange lastRange = lastLine.range;
//        visibleRange.length = lastRange.location + lastRange.length - visibleRange.location;
//
//        // create truncated line
//        if (container.truncationType != YYTextTruncationTypeNone) {
//            CTLineRef truncationTokenLine = NULL;
//            if (container.truncationToken) {
//                truncationToken = container.truncationToken;
//                truncationTokenLine = CTLineCreateWithAttributedString((CFAttributedStringRef)truncationToken);
//            } else {
//                CFArrayRef runs = CTLineGetGlyphRuns(lastLine.CTLine);
//                NSUInteger runCount = CFArrayGetCount(runs);
//                NSMutableDictionary *attrs = nil;
//                if (runCount > 0) {
//                    CTRunRef run = CFArrayGetValueAtIndex(runs, runCount - 1);
//                    attrs = (id)CTRunGetAttributes(run);
//                    attrs = attrs ? attrs.mutableCopy : [NSMutableArray new];
//                    [attrs removeObjectsForKeys:[NSMutableAttributedString allDiscontinuousAttributeKeys]];
//                    CTFontRef font = (__bridge CFTypeRef)attrs[(id)kCTFontAttributeName];
//                    CGFloat fontSize = font ? CTFontGetSize(font) : 12.0;
//                    UIFont *uiFont = [UIFont systemFontOfSize:fontSize * 0.9];
//                    font = [uiFont CTFontRef];
//                    if (font) {
//                        attrs[(id)kCTFontAttributeName] = (__bridge id)(font);
//                        uiFont = nil;
//                        CFRelease(font);
//                    }
//                    CGColorRef color = (__bridge CGColorRef)(attrs[(id)kCTForegroundColorAttributeName]);
//                    if (color && CFGetTypeID(color) == CGColorGetTypeID() && CGColorGetAlpha(color) == 0) {
//                        // ignore clear color
//                        [attrs removeObjectForKey:(id)kCTForegroundColorAttributeName];
//                    }
//                    if (!attrs) attrs = [NSMutableDictionary new];
//                }
//                truncationToken = [[NSAttributedString alloc] initWithString:YYTextTruncationToken attributes:attrs];
//                truncationTokenLine = CTLineCreateWithAttributedString((CFAttributedStringRef)truncationToken);
//            }
//            if (truncationTokenLine) {
//                CTLineTruncationType type = kCTLineTruncationEnd;
//                if (container.truncationType == YYTextTruncationTypeStart) {
//                    type = kCTLineTruncationStart;
//                } else if (container.truncationType == YYTextTruncationTypeMiddle) {
//                    type = kCTLineTruncationMiddle;
//                }
//                NSMutableAttributedString *lastLineText = [text attributedSubstringFromRange:lastLine.range].mutableCopy;
//                [lastLineText appendAttributedString:truncationToken];
//                CTLineRef ctLastLineExtend = CTLineCreateWithAttributedString((CFAttributedStringRef)lastLineText);
//                if (ctLastLineExtend) {
//                    CGFloat truncatedWidth = lastLine.width;
//                    CGRect cgPathRect = CGRectZero;
//                    if (CGPathIsRect(cgPath, &cgPathRect)) {
//                        if (isVerticalForm) {
//                            truncatedWidth = cgPathRect.size.height;
//                        } else {
//                            truncatedWidth = cgPathRect.size.width;
//                        }
//                    }
//                    CTLineRef ctTruncatedLine = CTLineCreateTruncatedLine(ctLastLineExtend, truncatedWidth, type, truncationTokenLine);
//                    CFRelease(ctLastLineExtend);
//                    if (ctTruncatedLine) {
//                        truncatedLine = [YYTextLine lineWithCTLine:ctTruncatedLine position:lastLine.position vertical:isVerticalForm];
//                        truncatedLine.index = lastLine.index;
//                        truncatedLine.row = lastLine.row;
//                        CFRelease(ctTruncatedLine);
//                    }
//                }
//                CFRelease(truncationTokenLine);
//            }
//        }
//    }
//
//    if (isVerticalForm) {
//        NSCharacterSet *rotateCharset = YYTextVerticalFormRotateCharacterSet();
//        NSCharacterSet *rotateMoveCharset = YYTextVerticalFormRotateAndMoveCharacterSet();
//
//        void (^lineBlock)(YYTextLine *) = ^(YYTextLine *line){
//            CFArrayRef runs = CTLineGetGlyphRuns(line.CTLine);
//            if (!runs) return;
//            NSUInteger runCount = CFArrayGetCount(runs);
//            if (runCount == 0) return;
//            NSMutableArray *lineRunRanges = [NSMutableArray new];
//            line.verticalRotateRange = lineRunRanges;
//            for (NSUInteger r = 0; r < runCount; r++) {
//                CTRunRef run = CFArrayGetValueAtIndex(runs, r);
//                NSMutableArray *runRanges = [NSMutableArray new];
//                [lineRunRanges addObject:runRanges];
//                NSUInteger glyphCount = CTRunGetGlyphCount(run);
//                if (glyphCount == 0) continue;
//
//                CFIndex runStrIdx[glyphCount + 1];
//                CTRunGetStringIndices(run, CFRangeMake(0, 0), runStrIdx);
//                CFRange runStrRange = CTRunGetStringRange(run);
//                runStrIdx[glyphCount] = runStrRange.location + runStrRange.length;
//                CFDictionaryRef runAttrs = CTRunGetAttributes(run);
//                CTFontRef font = CFDictionaryGetValue(runAttrs, kCTFontAttributeName);
//                BOOL isColorGlyph = CTFontContainsColorBitmapGlyphs(font);
//
//                NSUInteger prevIdx = 0;
//                YYTextRunGlyphDrawMode prevMode = YYTextRunGlyphDrawModeHorizontal;
//                NSString *layoutStr = layout.text.string;
//                for (NSUInteger g = 0; g < glyphCount; g++) {
//                    BOOL glyphRotate = 0, glyphRotateMove = NO;
//                    CFIndex runStrLen = runStrIdx[g + 1] - runStrIdx[g];
//                    if (isColorGlyph) {
//                        glyphRotate = YES;
//                    } else if (runStrLen == 1) {
//                        unichar c = [layoutStr characterAtIndex:runStrIdx[g]];
//                        glyphRotate = [rotateCharset characterIsMember:c];
//                        if (glyphRotate) glyphRotateMove = [rotateMoveCharset characterIsMember:c];
//                    } else if (runStrLen > 1){
//                        NSString *glyphStr = [layoutStr substringWithRange:NSMakeRange(runStrIdx[g], runStrLen)];
//                        BOOL glyphRotate = [glyphStr rangeOfCharacterFromSet:rotateCharset].location != NSNotFound;
//                        if (glyphRotate) glyphRotateMove = [glyphStr rangeOfCharacterFromSet:rotateMoveCharset].location != NSNotFound;
//                    }
//
//                    YYTextRunGlyphDrawMode mode = glyphRotateMove ? YYTextRunGlyphDrawModeVerticalRotateMove : (glyphRotate ? YYTextRunGlyphDrawModeVerticalRotate : YYTextRunGlyphDrawModeHorizontal);
//                    if (g == 0) {
//                        prevMode = mode;
//                    } else if (mode != prevMode) {
//                        YYTextRunGlyphRange *aRange = [YYTextRunGlyphRange rangeWithRange:NSMakeRange(prevIdx, g - prevIdx) drawMode:prevMode];
//                        [runRanges addObject:aRange];
//                        prevIdx = g;
//                        prevMode = mode;
//                    }
//                }
//                if (prevIdx < glyphCount) {
//                    YYTextRunGlyphRange *aRange = [YYTextRunGlyphRange rangeWithRange:NSMakeRange(prevIdx, glyphCount - prevIdx) drawMode:prevMode];
//                    [runRanges addObject:aRange];
//                }
//
//            }
//        };
//        for (YYTextLine *line in lines) {
//            lineBlock(line);
//        }
//        if (truncatedLine) lineBlock(truncatedLine);
//    }
//
//    if (visibleRange.length > 0) {
//        [layout setValue:@1 forKey:@"needDrawText"];
//        void (^block)(NSDictionary *attrs, NSRange range, BOOL *stop) = ^(NSDictionary *attrs, NSRange range, BOOL *stop) {
//            if (attrs[YYTextHighlightAttributeName])    [layout setValue:@1 forKey:@"containsHighlight"];
//
//            if (attrs[YYTextBlockBorderAttributeName]) [layout setValue:@1 forKey:@"needDrawBlockBorder"];
//            if (attrs[YYTextBackgroundBorderAttributeName])  [layout setValue:@1 forKey:@"needDrawBackgroundBorder"];
//            if (attrs[YYTextShadowAttributeName] || attrs[NSShadowAttributeName]) [layout setValue:@1 forKey:@"needDrawShadow"];
//            if (attrs[YYTextUnderlineAttributeName]) [layout setValue:@1 forKey:@"needDrawUnderline"];
//            if (attrs[YYTextAttachmentAttributeName])  [layout setValue:@1 forKey:@"needDrawAttachment"];
//            if (attrs[YYTextInnerShadowAttributeName])  [layout setValue:@1 forKey:@"needDrawInnerShadow"];
//            if (attrs[YYTextStrikethroughAttributeName])  [layout setValue:@1 forKey:@"needDrawStrikethrough"];
//            if (attrs[YYTextBorderAttributeName])  [layout setValue:@1 forKey:@"needDrawBorder"];
//        };
//
//        [layout.text enumerateAttributesInRange:visibleRange options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:block];
//        if (truncatedLine) {
//            [truncationToken enumerateAttributesInRange:NSMakeRange(0, truncationToken.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:block];
//        }
//    }
//
//    attachments = [NSMutableArray new];
//    attachmentRanges = [NSMutableArray new];
//    attachmentRects = [NSMutableArray new];
//    attachmentContentsSet = [NSMutableSet new];
//    for (NSUInteger i = 0, max = lines.count; i < max; i++) {
//        YYTextLine *line = lines[i];
//        if (truncatedLine && line.index == truncatedLine.index) line = truncatedLine;
//        if (line.attachments.count > 0) {
//            [attachments addObjectsFromArray:line.attachments];
//            [attachmentRanges addObjectsFromArray:line.attachmentRanges];
//            [attachmentRects addObjectsFromArray:line.attachmentRects];
//            for (YYTextAttachment *attachment in line.attachments) {
//                if (attachment.content) {
//                    [attachmentContentsSet addObject:attachment.content];
//                }
//            }
//        }
//    }
//    if (attachments.count == 0) {
//        attachments = attachmentRanges = attachmentRects = nil;
//    }
//
//    ((void (*)(id, SEL, CTFramesetterRef))(void *)objc_msgSend)((id)layout, NSSelectorFromString(@"setFrameSetter:"), ctSetter);
//    ((void (*)(id, SEL, CTFrameRef))(void *)objc_msgSend)((id)layout, NSSelectorFromString(@"setFrame:"), ctFrame);
//    ((void (*)(id, SEL, NSArray *))(void *)objc_msgSend)((id)layout, NSSelectorFromString(@"setLines:"), lines);
//    ((void (*)(id, SEL, YYTextLine *))(void *)objc_msgSend)((id)layout, NSSelectorFromString(@"setTruncatedLine:"), truncatedLine);
//    ((void (*)(id, SEL, NSArray *))(void *)objc_msgSend)((id)layout, NSSelectorFromString(@"setAttachments:"), attachments);
//    ((void (*)(id, SEL, NSUInteger))(void *)objc_msgSend)((id)layout, NSSelectorFromString(@"setRowCount:"), rowCount);
//    ((void (*)(id, SEL, NSRange))(void *)objc_msgSend)((id)layout, NSSelectorFromString(@"setVisibleRange:"), visibleRange);
//    ((void (*)(id, SEL, CGRect))(void *)objc_msgSend)((id)layout, NSSelectorFromString(@"setTextBoundingRect:"), textBoundingRect);
//    ((void (*)(id, SEL, CGSize))(void *)objc_msgSend)((id)layout, NSSelectorFromString(@"setTextBoundingSize:"), textBoundingSize);
//    ((void (*)(id, SEL, YYRowEdge *))(void *)objc_msgSend)((id)layout, NSSelectorFromString(@"setLineRowsEdge:"), lineRowsEdge);
//    ((void (*)(id, SEL, NSUInteger *))(void *)objc_msgSend)((id)layout, NSSelectorFromString(@"setLineRowsEdge:"), lineRowsIndex);
//
//    [layout setValue:attachmentRanges forKey:@"attachmentRanges"];
//    [layout setValue:attachmentRects forKey:@"attachmentRects"];
//    [layout setValue:attachmentContentsSet forKey:@"attachmentContentsSet"];
//
//    //    layout.frameSetter = ctSetter;
//    //    layout.frame = ctFrame;
//    //    layout.lines = lines;
//    //    layout.truncatedLine = truncatedLine;
//    //    layout.attachments = attachments;
//    //    layout.attachmentRanges = attachmentRanges;
//    //    layout.attachmentRects = attachmentRects;
//    //    layout.attachmentContentsSet = attachmentContentsSet;
//    //    layout.rowCount = rowCount;
//    //    layout.visibleRange = visibleRange;
//    //    layout.textBoundingRect = textBoundingRect;
//    //    layout.textBoundingSize = textBoundingSize;
//    //    layout.lineRowsEdge = lineRowsEdge;
//    //    layout.lineRowsIndex = lineRowsIndex;
//
//    CFRelease(cgPath);
//    CFRelease(ctSetter);
//    CFRelease(ctFrame);
//    if (lineOrigins) free(lineOrigins);
//    return layout;
//
//fail:
//    if (cgPath) CFRelease(cgPath);
//    if (ctSetter) CFRelease(ctSetter);
//    if (ctFrame) CFRelease(ctFrame);
//    if (lineOrigins) free(lineOrigins);
//    if (lineRowsEdge) free(lineRowsEdge);
//    if (lineRowsIndex) free(lineRowsIndex);
//    return nil;
//}

@end
