//
//  CCDatePickerView.h
//  CCTimePickerDemo
//
//  Created by eHome on 17/3/31.
//  Copyright © 2017年 Bref. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTCalendar.h"
@class CCDatePickerView;

@protocol CCDatePickerViewDelegate <NSObject>

@optional
- (void)datePickerView:(CCDatePickerView *)pickerView didSelectDate:(NSDate *)date;

@end


@interface CCDatePickerView : UIView
<
    JTCalendarDataSource
>

@property (nonatomic, weak) IBOutlet JTCalendarMenuView *menuView;
@property (nonatomic, weak) IBOutlet JTCalendarContentView *contentView;
@property (nonatomic, strong) JTCalendar *calendar;

@property (nonatomic, weak) id<CCDatePickerViewDelegate> delegate;

- (void)setSelectDate:(NSDate *)date;

@end
