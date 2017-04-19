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

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    
    frame.origin = origin;
    
    self.frame = frame;
}

- (CGFloat)originX {
    return self.frame.origin.x;
}

- (void)setOriginX:(CGFloat)originX {
    CGRect frame = self.frame;
    
    frame.origin.x = originX;
    
    self.frame = frame;
}

- (CGFloat)originY {
    return self.frame.origin.y;
}

- (void)setOriginY:(CGFloat)originY {
    CGRect frame = self.frame;
    
    frame.origin.y = originY;
    
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    
    frame.size = size;
    
    self.frame = frame;
}

- (CGFloat)sizeW {
    return self.frame.size.width;
}

- (void)setSizeW:(CGFloat)sizeW {
    CGRect frame = self.frame;
    
    frame.size.width = sizeW;
    
    self.frame = frame;
}

- (CGFloat)sizeH {
    return self.frame.size.height;
}

- (void)setSizeH:(CGFloat)sizeH {
    CGRect frame = self.frame;
    
    frame.size.height = sizeH;
    
    self.frame = frame;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX{
    self.center = CGPointMake(centerX, self.centerY);
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY{
    self.center = CGPointMake(self.centerX, centerY);
}


@end
