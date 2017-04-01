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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CCTimePickerView *datePicker = [CCTimePickerView viewFromXib];
    datePicker.frame = CGRectMake(50, 50, 260, 380);
    [datePicker setCurrentDate:[NSDate date]];
    [self.view addSubview:datePicker];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
