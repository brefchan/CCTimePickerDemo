//
//  NSDate+CCUtil.m
//  CCTimePickerDemo
//
//  Created by eHome on 17/4/1.
//  Copyright © 2017年 Bref. All rights reserved.
//

#import "NSDate+CCUtil.h"

@implementation NSDate (CCUtil)
- (NSString *)dateToString:(NSString *)format
{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:format];
    return [dateFormater stringFromDate:self];
}
@end
