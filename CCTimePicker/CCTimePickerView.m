//
//  CCTimePickerView.m
//  CCTimePickerDemo
//
//  Created by eHome on 17/3/31.
//  Copyright © 2017年 Bref. All rights reserved.
//

#import "CCTimePickerView.h"
#import "CCDatePickerView.h"
#import "CCYearPickerView.h"
#import "CCHourPickerView.h"
#import "CCMinitePickerView.h"
#import "UIView+CCUtil.h"

@interface CCTimePickerView()
<
    CCYearPickerViewDelegate,
    CCDatePickerViewDelegate,
    CCHourPickerViewDelegate,
    CCMinitePickerViewDelegate
>


@property (weak, nonatomic) IBOutlet UIView *selectCotentView;
@property (nonatomic, strong) CCDatePickerView *datePickerView;

@property (nonatomic, strong) CCYearPickerView *yearPickerView;
@property (nonatomic, strong) CCHourPickerView *hourPickerView;
@property (nonatomic, strong) CCMinitePickerView *minitePickerView;

@end

@implementation CCTimePickerView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.selectCotentView addSubview:self.datePickerView];
    [self.selectCotentView addSubview:self.yearPickerView];
    [self.selectCotentView addSubview:self.hourPickerView];
    [self.selectCotentView addSubview:self.minitePickerView];
    
    [self timeButtonClick:self.timeButton];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.datePickerView.frame = self.selectCotentView.bounds;
    self.yearPickerView.frame = self.selectCotentView.bounds;
    self.hourPickerView.frame = self.selectCotentView.bounds;
    self.minitePickerView.frame = self.selectCotentView.bounds;
}

- (void)setupButton
{
    self.yearButton.transform = CGAffineTransformMakeScale(0.7, 0.7);
    self.timeButton.transform = CGAffineTransformMakeScale(0.7, 0.7);
    self.hourButton.transform = CGAffineTransformMakeScale(0.7, 0.7);
    self.miniteButton.transform = CGAffineTransformMakeScale(0.7, 0.7);
}

#pragma mark - Delegate

#pragma mark CCYearPickerViewDelegate
- (void)yearPikcerView:(CCYearPickerView *)pickerView didSelectYear:(NSString *)year
{
    NSLog(@"year->%@",year);
}

#pragma mark CCDatePickerViewDelegate
- (void)datePickerView:(CCDatePickerView *)pickerView didSelectDate:(NSDate *)date
{
    NSLog(@"date->%@",date);
}

#pragma mark CCHourPickerViewDelegate
- (void)hourPickerView:(CCHourPickerView *)pickerView didSelectHour:(NSString *)hour
{
    NSLog(@"hour->%@",hour);
    [self.hourButton setTitle:hour forState:UIControlStateNormal];

}

- (void)hourPickerView:(CCHourPickerView *)pickerView hourSelectEnd:(NSString *)hour
{
    [self.hourButton setTitle:hour forState:UIControlStateNormal];
}

#pragma mark CCMinitePickerViewDelegate
- (void)minitePickerView:(CCMinitePickerView *)pickerView didSelectMinite:(NSString *)minite
{
    NSLog(@"minite->%@",minite);
    [self.miniteButton setTitle:minite forState:UIControlStateNormal];

}


- (void)minitePickerView:(CCMinitePickerView *)pickerView miniteSelectEnd:(NSString *)minite
{
    [self.miniteButton setTitle:minite forState:UIControlStateNormal];
}

#pragma mark - Public
- (void)setCurrentDate:(NSDate *)date
{
    [self.hourPickerView setHourWithDate:date];
    [self.minitePickerView setMiniteWithDate:date];
}

#pragma mark - Event

- (IBAction)yearButtonClick:(id)sender {
    
    [self setupButton];
    
    [UIView animateWithDuration:0.3f delay:0 usingSpringWithDamping:.5f initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.yearButton.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    
    [self yearViewShow];
}

- (IBAction)timeButtonClick:(id)sender {
    [self setupButton];
    
    [UIView animateWithDuration:0.3f delay:0 usingSpringWithDamping:.5f initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.timeButton.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    
    [self timeViewShow];
}

- (IBAction)hourButtonClick:(id)sender {
    [self setupButton];
    
    [UIView animateWithDuration:0.3f delay:0 usingSpringWithDamping:.5f initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.hourButton.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    
    [self hourViewShow];
}

- (IBAction)miniteButtonClick:(id)sender {
    [self setupButton];
    
    [UIView animateWithDuration:0.3f delay:0 usingSpringWithDamping:.5f initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.miniteButton.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    
    [self miniteViewShow];
}


#pragma mark - Animation
- (void)yearViewShow
{
    UIView *currentView;
    if (self.state == CCTimePickerStateYear) {
        return;
    }else if (self.state == CCTimePickerStateTime)
    {
        currentView = self.datePickerView;
    }else if (self.state == CCTimePickerStateHour)
    {
        currentView = self.hourPickerView;
    }else if (self.state == CCTimePickerStateMinite)
    {
        currentView = self.minitePickerView;
    }
    
    self.yearPickerView.alpha = 0;
    [self bringSubviewToFront:self.yearPickerView];
    
    self.yearPickerView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:.3f animations:^{
        self.yearPickerView.transform = CGAffineTransformIdentity;
        self.yearPickerView.alpha = 1;
        currentView.alpha = 0;
    }];
    
    self.state = CCTimePickerStateYear;
}

- (void)timeViewShow
{
    UIView *currentView;
    if (self.state == CCTimePickerStateYear) {
        currentView = self.yearPickerView;
    }else if (self.state == CCTimePickerStateTime)
    {
        return;
    }else if (self.state == CCTimePickerStateHour)
    {
        currentView = self.hourPickerView;
    }else if (self.state == CCTimePickerStateMinite)
    {
        currentView = self.minitePickerView;
    }
    
    self.datePickerView.alpha = 0;
    [self bringSubviewToFront:self.datePickerView];
    
    self.datePickerView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:.3f animations:^{
        self.datePickerView.transform = CGAffineTransformIdentity;
        self.datePickerView.alpha = 1;
        currentView.alpha = 0;
    }];
    
    self.state = CCTimePickerStateTime;
}

- (void)hourViewShow
{
    UIView *currentView;
    if (self.state == CCTimePickerStateYear) {
        currentView = self.yearPickerView;
    }else if (self.state == CCTimePickerStateTime)
    {
        currentView = self.datePickerView;
    }else if (self.state == CCTimePickerStateHour)
    {
        return;
    }else if (self.state == CCTimePickerStateMinite)
    {
        currentView = self.minitePickerView;
    }
    
    self.hourPickerView.alpha = 0;
    [self bringSubviewToFront:self.hourPickerView];
    
    self.hourPickerView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:.3f animations:^{
        self.hourPickerView.transform = CGAffineTransformIdentity;
        self.hourPickerView.alpha = 1;
        currentView.alpha = 0;
    }];
    
    self.state = CCTimePickerStateHour;
}

- (void)miniteViewShow
{
    UIView *currentView;
    if (self.state == CCTimePickerStateYear) {
        currentView = self.yearPickerView;
    }else if (self.state == CCTimePickerStateTime)
    {
        currentView = self.datePickerView;
    }else if (self.state == CCTimePickerStateHour)
    {
        currentView = self.hourPickerView;
    }else if (self.state == CCTimePickerStateMinite)
    {
        return;
    }
    
    self.minitePickerView.alpha = 0;
    [self bringSubviewToFront:self.minitePickerView];
    
    self.minitePickerView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:.3f animations:^{
        self.minitePickerView.transform = CGAffineTransformIdentity;
        self.minitePickerView.alpha = 1;
        currentView.alpha = 0;
    }];
    
    self.state = CCTimePickerStateMinite;
}

#pragma mark - Getter & Setter
- (CCDatePickerView *)datePickerView
{
    if (!_datePickerView) {
        _datePickerView = [CCDatePickerView viewFromXib];
        _datePickerView.delegate = self;
        _datePickerView.alpha = 0;
    }
    return _datePickerView;
}

- (CCYearPickerView *)yearPickerView
{
    if (!_yearPickerView) {
        _yearPickerView = [CCYearPickerView viewFromXib];
        _yearPickerView.delegate = self;
        _yearPickerView.alpha = 0;
    }
    return _yearPickerView;
}

- (CCHourPickerView *)hourPickerView
{
    if (!_hourPickerView) {
        _hourPickerView = [[CCHourPickerView alloc] init];
        _hourPickerView.delegate = self;
        _hourPickerView.alpha = 0;
    }
    return _hourPickerView;
}

- (CCMinitePickerView *)minitePickerView
{
    if (!_minitePickerView) {
        _minitePickerView = [[CCMinitePickerView alloc] init];
        _minitePickerView.delegate = self;
        _minitePickerView.alpha = 0;
    }
    return _minitePickerView;
}

@end
