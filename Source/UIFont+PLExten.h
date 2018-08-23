//
//  UIFont+PLExten.h
//  PLKit
//
//  Created by qmtv on 2018/8/23.
//  Copyright © 2018年 clOud. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, PLFontName)
{
     Copperplate,
     Heiti_SC,
     AppleSD_Gothic_Neo,
     Thonburi,
     Gill_Sans,
     Marker_Felt,
     HiraginoMaru_Gothic_ProN,
     Courier_New,
     Kohinoor_Telugu,
     Heiti_TC,
     Avenir_Next_Condensed,
     Tamil_Sangam_MN,
     Helvetica_Neue,
     Gurmukhi_MN,
     Georgia,
     Times_New_Roman,
     Sinhala_Sangam_MN,
     Arial_Rounded_MT_Bold,
     Kailasa,
     Kohinoor_Devanagari,
     Kohinoor_Bangla,
     Chalkboard_SE,
     Apple_Color_Emoji,
     PingFang_TC,
     Gujarati_Sangam_MN,
     Geeza_Pro,
     Damascus,
     Noteworthy,
     Avenir,
     Mishafi,
     Academy_Engraved_LET,
     Futura,
     Party_LET,
     Kannada_Sangam_MN,
     Arial_Hebrew,
     Farah,
     Arial,
     Chalkduster,
     Kefa,
     Hoefler_Text,
     Optima,
     Palatino,
     Malayalam_Sangam_MN,
     Al_Nile,
     Lao_Sangam_MN,
     Bradley_Hand,
     Hiragino_Mincho_ProN,
     PingFang_HK,
     Helvetica,
     Courier,
     Cochin,
     Trebuchet_MS,
     Devanagari_Sangam_MN,
     Oriya_Sangam_MN,
     Rockwell,
     Snell_Roundhand,
     Zapf_Dingbats,
     Bodoni_72,
     Verdana,
     American_Typewriter,
     Avenir_Next,
     Baskerville,
     Khmer_Sangam_MN,
     Didot,
     Savoye_LET,
     Bodoni_Ornaments,
     Symbol,
     Charter,
     Menlo,
     Noto_Nastaliq_Urdu,
     Bodoni_72_Smallcaps,
     DIN_Alternate,
     Papyrus,
     Hiragino_Sans,
     PingFang_SC,
     Myanmar_Sangam_MN,
     Zapfino,
     Telugu_Sangam_MN,
     Bodoni_72_Oldstyle,
     Euphemia_UCAS,
     Bangla_Sangam_MN,
     DIN_Condensed
};

typedef NS_ENUM(NSInteger, PingFangStyle)
{
    Medium = 0,
    Semibold,
    Light,
    Ultralight,
    Regular,
    Thin
};

@interface UIFont (PLExten)

+ (UIFont *)fontWithName:(PLFontName)fontName fontSize:(CGFloat)fontSize;
+ (UIFont *)PingFangWithSize:(CGFloat)fontSize style:(PingFangStyle)style;

@end
