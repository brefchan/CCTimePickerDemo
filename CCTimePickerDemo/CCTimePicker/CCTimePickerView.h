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

@property (weak, nonatomic) IBOutlet UIButton *yearButton;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (weak, nonatomic) IBOutlet UIView *hourAndMiniteView;
@property (weak, nonatomic) IBOutlet UIButton *hourButton;
@property (weak, nonatomic) IBOutlet UIButton *miniteButton;

@property (nonatomic, strong) NSDate *currentSelectDate;;

@property (nonatomic, assign) CCTimePickerState state;

@property (nonatomic, weak) id<CCTimePickerViewDelegage> delegate;

- (void)setCurrentDate:(NSDate *)date;

- (void)popInView:(UIView *)view;

@end
