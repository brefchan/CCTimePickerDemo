//
//  CCYearPickerView.m
//  CCTimePickerDemo
//
//  Created by eHome on 17/3/31.
//  Copyright © 2017年 Bref. All rights reserved.
//

#import "CCYearPickerView.h"

@interface CCYearPickerView()

@property (nonatomic, strong) NSMutableArray<NSString *> *yearArray;

@end

@implementation CCYearPickerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
}

- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 1970; i < 2050; i ++) {
        [self.yearArray addObject:@(i).stringValue];
    }
    
    self.yearPickerView.delegate = self;
    self.yearPickerView.dataSource = self;
    [self.yearPickerView reloadAllComponents];
    
    [self.yearPickerView selectRow:(2017 - 1970) inComponent:0 animated:NO];
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 36;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.yearArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *selectYear = [self.yearArray objectAtIndex:row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(yearPikcerView:didSelectYear:)]) {
        [self.delegate yearPikcerView:self didSelectYear:selectYear];
    }
}


#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.yearArray.count;
}

#pragma mark - Getter && Setter
- (NSMutableArray<NSString *> *)yearArray
{
    if (!_yearArray) {
        _yearArray = [NSMutableArray arrayWithCapacity:80];
    }
    return _yearArray;
}


@end
