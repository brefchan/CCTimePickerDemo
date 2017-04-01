//
//  CCMinitePickerView.h
//  CCTimePickerDemo
//
//  Created by eHome on 17/3/31.
//  Copyright © 2017年 Bref. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CCMinitePickerView;

@protocol CCMinitePickerViewDelegate <NSObject>

@optional

- (void)minitePickerView:(CCMinitePickerView *)pickerView miniteSelectEnd:(NSString *)minite;

- (void)minitePickerView:(CCMinitePickerView *)pickerView didSelectMinite:(NSString *)minite;

@end

@interface CCMinitePickerView : UIView

@property (nonatomic, weak) id<CCMinitePickerViewDelegate> delegate;

@property (nonatomic, assign) NSInteger minite;

- (void)setMiniteWithDate:(NSDate *)date;

@end
