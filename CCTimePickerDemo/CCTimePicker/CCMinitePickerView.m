//
//  CCMinitePickerView.m
//  CCTimePickerDemo
//
//  Created by eHome on 17/3/31.
//  Copyright © 2017年 Bref. All rights reserved.
//

#import "CCMinitePickerView.h"
#import "CCMiniteCircleSlider.h"
#import "NSDate+CCUtil.h"

@interface CCMinitePickerView()

@property (nonatomic, strong) CCMiniteCircleSlider *miniteCircleSlider;

@end

@implementation CCMinitePickerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.miniteCircleSlider];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.miniteCircleSlider];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.bounds.size.width != self.bounds.size.height) {
        if (self.bounds.size.width > self.bounds.size.height) {
            self.miniteCircleSlider.frame = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
            self.miniteCircleSlider.center = self.center;
        }else
        {
            self.miniteCircleSlider.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width);
            self.miniteCircleSlider.center = self.center;
        }
    }else
    {
        self.miniteCircleSlider.frame = self.bounds;
    }
}

#pragma mark - Public
- (void)setMiniteWithDate:(NSDate *)date{
    NSString *minite = [date dateToString:@"mm"];
    
    self.minite = minite.integerValue;
    
    [self.miniteCircleSlider setMinite:self.minite];
}

#pragma mark - Event

- (void)miniteSliderEndSelect:(CCMiniteCircleSlider *)sender
{
    NSString *miniteString = @(sender.minite).stringValue;
    if (self.delegate && [self.delegate respondsToSelector:@selector(minitePickerView:miniteSelectEnd:)]) {
        [self.delegate minitePickerView:self miniteSelectEnd:miniteString];
    }
}

- (void)miniteSliderDidSelect:(CCMiniteCircleSlider *)sender
{
    NSString *miniteString = @(sender.minite).stringValue;
    if (self.delegate && [self.delegate respondsToSelector:@selector(minitePickerView:didSelectMinite:)]) {
        [self.delegate minitePickerView:self didSelectMinite:miniteString];
    }
}


#pragma mark - Getter && Setter
- (CCMiniteCircleSlider *)miniteCircleSlider
{
    if (!_miniteCircleSlider) {
        _miniteCircleSlider = [[CCMiniteCircleSlider alloc] init];
        [_miniteCircleSlider addTarget:self action:@selector(miniteSliderEndSelect:) forControlEvents:UIControlEventEditingDidEnd];
        [_miniteCircleSlider addTarget:self action:@selector(miniteSliderDidSelect:) forControlEvents:UIControlEventValueChanged];
    }
    return _miniteCircleSlider;
}

@end
