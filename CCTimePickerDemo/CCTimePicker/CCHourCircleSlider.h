//
//  CCHourCircleSlider.h
//  CCTimePickerDemo
//
//  Created by eHome on 17/3/30.
//  Copyright © 2017年 Bref. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCHourCircleSlider : UIControl

@property (nonatomic, assign) CGFloat circleWidth;
@property (nonatomic, strong) UIColor *selectColor;
@property (nonatomic, strong) UIColor *unselectColor;
@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, assign) CGFloat contextPadding;

@property (nonatomic, assign) NSInteger angle;

@property (nonatomic, assign) NSInteger hour;

@end
