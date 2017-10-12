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
#import "NSDate+CCUtil.h"
#import "UIView+CCUtil.h"
#import "Masonry.h"

@interface CCTimePickerView()
<
    CCYearPickerViewDelegate,
    CCDatePickerViewDelegate,
    CCHourPickerViewDelegate,
    CCMinitePickerViewDelegate
>


@property (weak, nonatomic) IBOutlet UIButton *backgourdButton;

@property (nonatomic, assign) IBOutlet UIView *clipView;
@property (weak, nonatomic) IBOutlet UIView *selectCotentView;
@property (nonatomic, strong) CCDatePickerView *datePickerView;

@property (weak, nonatomic) IBOutlet UIButton *yearButton;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (weak, nonatomic) IBOutlet UIView *hourAndMiniteView;
@property (weak, nonatomic) IBOutlet UIButton *hourButton;
@property (weak, nonatomic) IBOutlet UIButton *miniteButton;

@property (nonatomic, strong) CCYearPickerView *yearPickerView;
@property (nonatomic, strong) CCHourPickerView *hourPickerView;
@property (nonatomic, strong) CCMinitePickerView *minitePickerView;

@property (nonatomic, strong) NSString *yearString;
@property (nonatomic, strong) NSString *monthString;
@property (nonatomic, strong) NSString *dayString;
@property (nonatomic, strong) NSString *hourString;
@property (nonatomic, strong) NSString *miniteString;


@end

@implementation CCTimePickerView

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.clipView.layer.cornerRadius = 4.f;
    self.clipView.clipsToBounds = YES;
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = .6f;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    
    [self.selectCotentView addSubview:self.datePickerView];
    [self.selectCotentView addSubview:self.yearPickerView];
    [self.selectCotentView addSubview:self.hourPickerView];
    [self.selectCotentView addSubview:self.minitePickerView];
    
    [self timeButtonClick:self.timeButton];
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    __weak CCTimePickerView *weakSelf = self;
    [self.datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.and.right.mas_equalTo(weakSelf.selectCotentView);
    }];
    
    [self.yearPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.and.left.and.bottom.and.right.mas_equalTo(weakSelf.selectCotentView);
    }];
    
    [self.hourPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.and.right.mas_equalTo(weakSelf.selectCotentView);
    }];
    
    [self.minitePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.and.right.mas_equalTo(weakSelf.selectCotentView);
    }];
}




- (void)setupButton
{
    self.yearButton.transform = CGAffineTransformMakeScale(0.7, 0.7);
    self.timeButton.transform = CGAffineTransformMakeScale(0.7, 0.7);
    self.hourButton.transform = CGAffineTransformMakeScale(0.7, 0.7);
    self.miniteButton.transform = CGAffineTransformMakeScale(0.7, 0.7);
}

#pragma mark - Public Method
- (void)popInView:(UIView *)view
{
    self.frame = view.bounds;
    [view addSubview:self];
    
    self.clipView.alpha = 0;
    self.clipView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
    
    [UIView animateWithDuration:.3f animations:^{
        self.backgourdButton.alpha = .5f;
        self.clipView.alpha = 1;
        self.clipView.transform = CGAffineTransformIdentity;
    }];
}

- (void)hide
{
    self.clipView.transform = CGAffineTransformIdentity;
    self.clipView.alpha = 1;
    
    [UIView animateWithDuration:.3f animations:^{
        self.backgourdButton.alpha = 0;
        self.clipView.alpha = 0;
        self.clipView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}



#pragma mark - Delegate

#pragma mark CCYearPickerViewDelegate
- (void)yearPikcerView:(CCYearPickerView *)pickerView didSelectYear:(NSString *)year
{
    self.yearString = year;
    [self.yearButton setTitle:self.yearString forState:UIControlStateNormal];
    
    if (self.isAutoNext) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self timeButtonClick:self.timeButton];
        });
    }
}

#pragma mark CCDatePickerViewDelegate
- (void)datePickerView:(CCDatePickerView *)pickerView didSelectDate:(NSDate *)date
{
    NSString *yearString = [date stringForDateWithFormat:@"yyyy"];
    self.monthString = [date stringForDateWithFormat:@"MM"];
    self.dayString = [date stringForDateWithFormat:@"dd"];

    self.yearString = yearString;
    
    [self.timeButton setTitle:[NSString stringWithFormat:@"%@月%@日",self.monthString,self.dayString] forState:UIControlStateNormal];
    [self.yearButton setTitle:self.yearString forState:UIControlStateNormal];
    
    if (self.isAutoNext) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hourButtonClick:self.hourButton];
        });
    }
}

#pragma mark CCHourPickerViewDelegate
- (void)hourPickerView:(CCHourPickerView *)pickerView didSelectHour:(NSString *)hour
{
    self.hourString = hour;
    
    [self.hourButton setTitle:self.hourString forState:UIControlStateNormal];

}

- (void)hourPickerView:(CCHourPickerView *)pickerView hourSelectEnd:(NSString *)hour
{
    self.hourString = hour;
    
    [self.hourButton setTitle:self.hourString forState:UIControlStateNormal];
    
    if (self.isAutoNext) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self miniteButtonClick:self.miniteButton];
        });
    }
}

#pragma mark CCMinitePickerViewDelegate
- (void)minitePickerView:(CCMinitePickerView *)pickerView didSelectMinite:(NSString *)minite
{
    self.miniteString = minite;

    [self.miniteButton setTitle:self.miniteString forState:UIControlStateNormal];
}


- (void)minitePickerView:(CCMinitePickerView *)pickerView miniteSelectEnd:(NSString *)minite
{
    self.miniteString = minite;
    [self.miniteButton setTitle:self.miniteString forState:UIControlStateNormal];

}

#pragma mark - Public
- (void)setCurrentDate:(NSDate *)date
{
    [self.hourPickerView setHourWithDate:date];
    [self.minitePickerView setMiniteWithDate:date];
    [self.datePickerView setSelectDate:date];
    
    self.yearString = [date stringForDateWithFormat:@"yyyy"];
    self.monthString = [date stringForDateWithFormat:@"MM"];
    self.dayString = [date stringForDateWithFormat:@"dd"];
    self.hourString = [date stringForDateWithFormat:@"HH"];
    self.miniteString = [date stringForDateWithFormat:@"mm"];
    
    [self.yearButton setTitle:self.yearString forState:UIControlStateNormal];
    [self.hourButton setTitle:self.hourString forState:UIControlStateNormal];
    [self.miniteButton setTitle:self.miniteString forState:UIControlStateNormal];
    [self.timeButton setTitle:[NSString stringWithFormat:@"%@月%@日",self.monthString,self.dayString] forState:UIControlStateNormal];
}

#pragma mark - Event

- (IBAction)comfirmButtonClick:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:didSelectTime:)]) {
        
        NSDateComponents *compt = [[NSDateComponents alloc] init];
        [compt setYear:self.yearString.integerValue];
        [compt setMonth:self.monthString.integerValue];
        [compt setDay:self.dayString.integerValue];
        [compt setHour:self.hourString.integerValue];
        [compt setMinute:self.miniteString.integerValue];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        NSDate *date = [calendar dateFromComponents:compt];
        
        [self.delegate pickerView:self didSelectTime:date];
    }
    
    [self hide];
}

- (IBAction)cancelButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerViewCancelSelect:)]) {
        [self.delegate pickerViewCancelSelect:self];
    }
    
    [self hide];
}

- (IBAction)backgroundButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerViewCancelSelect:)]) {
        [self.delegate pickerViewCancelSelect:self];
    }
    [self hide];
}

- (IBAction)yearButtonClick:(id)sender {
    
    [self setupButton];
    
    [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:.3f initialSpringVelocity:8 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.yearButton.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    
    [self yearViewShow];
}

- (IBAction)timeButtonClick:(id)sender {
    [self setupButton];
    
    [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:.3f initialSpringVelocity:8 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.timeButton.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    
    [self timeViewShow];
}

- (IBAction)hourButtonClick:(id)sender {
    [self setupButton];
    
    [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:.3f initialSpringVelocity:8 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.hourButton.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    
    [self hourViewShow];
}

- (IBAction)miniteButtonClick:(id)sender {
    [self setupButton];
    
    [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:.3f initialSpringVelocity:8 options:UIViewAnimationOptionCurveEaseOut animations:^{
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
