//
//  CCYearPickerView.h
//  CCTimePickerDemo
//
//  Created by eHome on 17/3/31.
//  Copyright © 2017年 Bref. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CCYearPickerView;

@protocol  CCYearPickerViewDelegate <NSObject>

@optional
- (void)yearPikcerView:(CCYearPickerView *)pickerView didSelectYear:(NSString *)year;

@end

@interface CCYearPickerView : UIView
<
    UIPickerViewDelegate,
    UIPickerViewDataSource
>

@property (weak, nonatomic) IBOutlet UIPickerView *yearPickerView;

@property (nonatomic, weak) id<CCYearPickerViewDelegate> delegate;

@end
