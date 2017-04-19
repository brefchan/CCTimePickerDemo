//
//  CCDatePickerView.m
//  CCTimePickerDemo
//
//  Created by eHome on 17/3/31.
//  Copyright © 2017年 Bref. All rights reserved.
//

#import "CCDatePickerView.h"
#import "UIView+CCUtil.h"

@implementation CCDatePickerView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    [self.calendar reloadData];
}

- (void)setSelectDate:(NSDate *)date
{
    [self.calendar setCurrentDate:[NSDate date]];
    [self.calendar setCurrentDateSelected:date];
    
    [self.contentView setCurrentDate:date];
    [self.menuView setCurrentDate:date];
    [self.calendar reloadData];
    [self.contentView reloadData];
    [self.contentView reloadAppearance];
    [self.menuView reloadAppearance];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView layoutIfNeeded];
    [self.menuView layoutIfNeeded];
    
    [self.calendar repositionViews];
}

#pragma mark - JTCalendarDataSource

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    return NO;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerView:didSelectDate:)]) {
        [self.delegate datePickerView:self didSelectDate:date];
    }
}

#pragma mark - Getter & Setter
- (JTCalendar *)calendar
{
    if (!_calendar) {
        _calendar = [[JTCalendar alloc] init];
        _calendar.calendarAppearance.calendar.firstWeekday = 2;
        _calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
        _calendar.calendarAppearance.ratioContentMenu = 1.;
        [_calendar setMenuMonthsView:self.menuView];
        [_calendar setContentView:self.contentView];
        [_calendar setDataSource:self];
    }
    return _calendar;
}

@end
