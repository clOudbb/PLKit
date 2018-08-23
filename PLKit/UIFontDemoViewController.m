//
//  UIFontDemoViewController.m
//  PLKit
//
//  Created by qmtv on 2018/8/23.
//  Copyright © 2018年 clOud. All rights reserved.
//

#import "UIFontDemoViewController.h"
#import "PLKit.h"

@interface UIFontDemoViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, copy) NSArray *fontNames;
@property (nonatomic, copy) NSArray *pingFangSC;

@end

@implementation UIFontDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _label = [UILabel new];
    _label.text = @"this is test. 这是测试文案. 1234567890";
    _label.frame = CGRectMake(0, 0, 375, 50);
    _label.center = self.view.center;
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 300, [UIScreen mainScreen].bounds.size.width, 300)];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:_pickerView];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.fontNames.count;
    } else {
        return self.pingFangSC.count;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 1) {
        _label.font = [UIFont PingFangWithSize:17 style:row];
        return;
    }
    
    PLFontName name = row;
    _label.font = [UIFont fontWithName:name fontSize:17];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) return _fontNames[row];
    else return _pingFangSC[row];
}

- (NSArray *)fontNames
{
    if (!_fontNames) {
        _fontNames  = @[
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
    }
    return _fontNames;
}

- (NSArray *)pingFangSC
{
    if (!_pingFangSC) {
        _pingFangSC = @[
                           @"PingFangSC-Medium",
                           @"PingFangSC-Semibold",
                           @"PingFangSC-Light",
                           @"PingFangSC-Ultralight",
                           @"PingFangSC-Regular",
                           @"PingFangSC-Thin"];
    }
    return _pingFangSC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
