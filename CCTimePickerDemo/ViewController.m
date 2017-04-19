//
//  ViewController.m
//  CCTimePickerDemo
//
//  Created by eHome on 17/3/30.
//  Copyright © 2017年 Bref. All rights reserved.
//

#import "ViewController.h"
#import "UIView+CCUtil.h"
#import "CCDatePickerView.h"
#import "CCTimePickerView.h"

@interface ViewController ()
<
    CCTimePickerViewDelegage
>

@property (nonatomic, strong) CCTimePickerView *pickerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.pickerView = [CCTimePickerView viewFromXib];
    self.pickerView.delegate = self;
    [self.pickerView setCurrentDate:[NSDate date]];
    
}

#pragma mark - Event
- (IBAction)popButtonClick:(id)sender {
    [self.pickerView popInView:self.view];
}

#pragma mark - Delegate
#pragma mark CCTimePickerViewDelegate
- (void)pickerView:(CCTimePickerView *)timePickerView didSelectTime:(NSDate *)date
{
    NSLog(@"%@",date);
}

- (void)pickerViewCancelSelect:(CCTimePickerView *)timePickerView
{
    NSLog(@"取消");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
