//
//  CCHourPickerView.h
//  CCTimePickerDemo
//
//  Created by eHome on 17/3/31.
//  Copyright © 2017年 Bref. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CCHourPickerView;

typedef NS_ENUM(NSInteger,CCHourPickerViewState) {
    CCHourPickerViewStateAM, //上午
    CCHourPickerViewStatePM  //下午
};

@protocol CCHourPickerViewDelegate <NSObject>

@optional
- (void)hourPickerView:(CCHourPickerView *)pickerView didSelectHour:(NSString *)hour;

- (void)hourPickerView:(CCHourPickerView *)pickerView hourSelectEnd:(NSString *)hour;

@end

@interface CCHourPickerView : UIView

@property (nonatomic, weak) id<CCHourPickerViewDelegate> delegate;

@property (nonatomic, assign) CCHourPickerViewState state;
@property (nonatomic, assign) NSInteger hour;

- (void)setHourWithDate:(NSDate *)date;

@end
