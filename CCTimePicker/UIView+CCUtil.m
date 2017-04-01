//
//  UIView+CCUtil.m
//  CCTimePickerDemo
//
//  Created by eHome on 17/3/31.
//  Copyright © 2017年 Bref. All rights reserved.
//

#import "UIView+CCUtil.h"

@implementation UIView (CCUtil)

+ (instancetype)viewFromXib
{
    Class viewClass = [self class];
    NSString *viewClassName = NSStringFromClass(viewClass);
    NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:viewClassName owner:nil options:nil];
    
    for (id nibItem in nibArray) {
        if ([nibItem isMemberOfClass:viewClass]) {
            return nibItem;
        }
    }
    
    return nil;
}


@end
