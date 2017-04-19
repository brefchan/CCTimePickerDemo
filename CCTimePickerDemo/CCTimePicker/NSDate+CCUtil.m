//
//  NSDate+CCUtil.m
//  CCTimePickerDemo
//
//  Created by eHome on 17/4/1.
//  Copyright © 2017年 Bref. All rights reserved.
//

#import "NSDate+CCUtil.h"
#import <objc/runtime.h>

@implementation NSDate (CCUtil)

static NSString *formatterKey = @"formatterKey";

+ (NSDateFormatter *)formatter
{
    NSDateFormatter *formatter = objc_getAssociatedObject(self, &formatterKey);
    
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        objc_setAssociatedObject(self, &formatterKey,formatter, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    return objc_getAssociatedObject(self, &formatterKey);
}


- (NSString *)stringForDateWithFormat:(NSString *)format
{
    NSDateFormatter *dateFormater = [NSDate formatter];
    [dateFormater setDateFormat:format];
    return [dateFormater stringFromDate:self];
}

+ (NSDate *)dateWithDateString:(NSString *)dateString format:(NSString *)dateFormat
{
    NSDateFormatter *dateFormater = [NSDate formatter];
    [dateFormater setDateFormat:dateFormat];
    return [dateFormater dateFromString:dateString];
}

@end
