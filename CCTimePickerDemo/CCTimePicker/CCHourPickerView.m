//
//  CCHourPickerView.m
//  CCTimePickerDemo
//
//  Created by eHome on 17/3/31.
//  Copyright © 2017年 Bref. All rights reserved.
//

#import "CCHourPickerView.h"
#import "CCHourCircleSlider.h"
#import "NSDate+CCUtil.h"

@interface CCHourPickerView()

@property (nonatomic, strong) CCHourCircleSlider *hourSlider;

@end

@implementation CCHourPickerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.hourSlider];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.hourSlider];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.bounds.size.width > self.bounds.size.height) {
        _hourSlider.frame = CGRectMake(0, 0, self.bounds.size.height - 20, self.bounds.size.height - 20);
        _hourSlider.center = self.center;
    }else
    {
        _hourSlider.frame = CGRectMake(0, 0, self.bounds.size.width - 20, self.bounds.size.width - 20);
        _hourSlider.center = self.center;
    }

}

#pragma mark - Public
- (void)setHourWithDate:(NSDate *)date{
    NSString *hour = [date stringForDateWithFormat:@"HH"];
    NSInteger hourNumber;
    if (hour.integerValue > 12) {
        self.state = CCHourPickerViewStatePM;
        hourNumber = hour.integerValue - 12;
    }else
    {
        hourNumber = hour.integerValue;
    }
    
    self.hour = hourNumber;
    [self.hourSlider setHour:hourNumber];
}

#pragma mark - Event
- (void)hourSliderEndSelect:(CCHourCircleSlider *)sender
{
    NSString *hourString = [NSString stringWithFormat:@"%02ld",(long)sender.hour];
    if (self.delegate && [self.delegate respondsToSelector:@selector(hourPickerView:hourSelectEnd:)]) {
        [self.delegate hourPickerView:self hourSelectEnd:hourString];
    }
}

- (void)hourSliderDidSelect:(CCHourCircleSlider *)sender
{
    NSString *hourString = [NSString stringWithFormat:@"%02ld",(long)sender.hour];
    if (self.delegate && [self.delegate respondsToSelector:@selector(hourPickerView:didSelectHour:)]) {
        [self.delegate hourPickerView:self didSelectHour:hourString];
    }
}


#pragma mark - Getter && Setter
- (CCHourCircleSlider *)hourSlider
{
    if (!_hourSlider) {
        _hourSlider = [[CCHourCircleSlider alloc] init];
        [_hourSlider addTarget:self action:@selector(hourSliderEndSelect:) forControlEvents:UIControlEventEditingDidEnd];
        [_hourSlider addTarget:self action:@selector(hourSliderDidSelect:) forControlEvents:UIControlEventValueChanged];
    }
    return _hourSlider;
}

@end
