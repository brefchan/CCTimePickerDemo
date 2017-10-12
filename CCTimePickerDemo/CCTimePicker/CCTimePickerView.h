//
//  CCTimePickerView.h
//  CCTimePickerDemo
//
//  Created by eHome on 17/3/31.
//  Copyright © 2017年 Bref. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,CCTimePickerState) {
    CCTimePickerStateNone,
    CCTimePickerStateYear,
    CCTimePickerStateTime,
    CCTimePickerStateHour,
    CCTimePickerStateMinite
};

@class CCTimePickerView;

@protocol CCTimePickerViewDelegage<NSObject>

@optional
- (void)pickerView:(CCTimePickerView *)timePickerView didSelectTime:(NSDate *)date;

- (void)pickerViewCancelSelect:(CCTimePickerView *)timePickerView;

@end


@interface CCTimePickerView : UIView

@property (nonatomic, assign) CCTimePickerState state;

//是否自动跳转下一步
@property (nonatomic, assign) BOOL isAutoNext;

@property (nonatomic, weak) id<CCTimePickerViewDelegage> delegate;

- (void)setCurrentDate:(NSDate *)date;

- (void)popInView:(UIView *)view;

@end
