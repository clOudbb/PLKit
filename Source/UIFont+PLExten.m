//
//  UIFont+PLExten.m
//  PLKit
//
//  Created by qmtv on 2018/8/23.
//  Copyright © 2018年 clOud. All rights reserved.
//

#import "UIFont+PLExten.h"
#import "PLKitDefine.h"
#import <objc/runtime.h>

static NSArray *_nameHash = nil;
@implementation UIFont (PLExten)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _nameHash = @[
                                          @"Copperplate",
                                          @"Heiti SC",
                                          @"Apple SD Gothic Neo",
                                          @"Thonburi",
                                          @"Gill Sans",
                                          @"Marker Felt",
                                          @"Hiragino Maru Gothic ProN",
                                          @"Courier New",
                                          @"Kohinoor Telugu",
                                          @"Heiti TC",
                                          @"Avenir Next Condensed",
                                          @"Tamil Sangam MN",
                                          @"Helvetica Neue",
                                          @"Gurmukhi MN",
                                          @"Georgia",
                                          @"Times New Roman",
                                          @"Sinhala Sangam MN",
                                          @"Arial Rounded MT Bold",
                                          @"Kailasa",
                                          @"Kohinoor Devanagari",
                                          @"Kohinoor Bangla",
                                          @"Chalkboard SE",
                                          @"Apple Color Emoji",
                                          @"PingFang TC",
                                          @"Gujarati Sangam MN",
                                          @"Geeza Pro",
                                          @"Damascus",
                                          @"Noteworthy",
                                          @"Avenir",
                                          @"Mishafi",
                                          @"Academy Engraved LET",
                                          @"Futura",
                                          @"Party LET",
                                          @"Kannada Sangam MN",
                                          @"Arial Hebrew",
                                          @"Farah",
                                          @"Arial",
                                          @"Chalkduster",
                                          @"Kefa",
                                          @"Hoefler Text",
                                          @"Optima",
                                          @"Palatino",
                                          @"Malayalam Sangam MN",
                                          @"Al Nile",
                                          @"Lao Sangam MN",
                                          @"Bradley Hand",
                                          @"Hiragino Mincho ProN",
                                          @"PingFang HK",
                                          @"Helvetica",
                                          @"Courier",
                                          @"Cochin",
                                          @"Trebuchet MS",
                                          @"Devanagari Sangam MN",
                                          @"Oriya Sangam MN",
                                          @"Rockwell",
                                          @"Snell Roundhand",
                                          @"Zapf Dingbats",
                                          @"Bodoni 72",
                                          @"Verdana",
                                          @"American Typewriter",
                                          @"Avenir Next",
                                          @"Baskerville",
                                          @"Khmer Sangam MN",
                                          @"Didot",
                                          @"Savoye LET",
                                          @"Bodoni Ornaments",
                                          @"Symbol",
                                          @"Charter",
                                          @"Menlo",
                                          @"Noto Nastaliq Urdu",
                                          @"Bodoni 72 Smallcaps",
                                          @"DIN Alternate",
                                          @"Papyrus",
                                          @"Hiragino Sans",
                                          @"PingFang SC",
                                          @"Myanmar Sangam MN",
                                          @"Zapfino",
                                          @"Telugu Sangam MN",
                                          @"Bodoni 72 Oldstyle",
                                          @"Euphemia UCAS",
                                          @"Bangla Sangam MN",
                                          @"DIN Condensed"
                                          ];
    });
}

+ (UIFont *)fontWithName:(PLFontName)fontName fontSize:(CGFloat)fontSize
{
    NSString *name = _nameHash[fontName];
    if (![[UIFont familyNames] containsObject:name]) {
        PLLOG(@"sorry. current system version unsupported or font libary unimported");
        return [UIFont systemFontOfSize:fontSize];
    }
    return [UIFont fontWithName:name size:fontSize];
}

+ (UIFont *)PingFangWithSize:(CGFloat)fontSize style:(PingFangStyle)style
{
    NSString *fontString = @"PingFangSC";
    switch (style) {
        case Medium:
            fontString = [fontString stringByAppendingString:@"-Medium"];
            break;
        case Semibold:
            fontString = [fontString stringByAppendingString:@"-Semibold"];
            break;
        case Light:
            fontString = [fontString stringByAppendingString:@"-Light"];
            break;
        case Ultralight:
            fontString = [fontString stringByAppendingString:@"-Ultralight"];
            break;
        case Regular:
            fontString = [fontString stringByAppendingString:@"-Regular"];
            break;
        case Thin:
            fontString = [fontString stringByAppendingString:@"-Thin"];
            break;
        default:
            break;
    }
    
    UIFont *font = nil;
    @try {
         font = [UIFont fontWithName:fontString size:fontSize];
    }
    @catch (NSException *exception) {
        PLLOG(@"%@", exception);
    }
    @finally {
        font = [UIFont systemFontOfSize:fontSize];
    }
    return font;
}

@end
