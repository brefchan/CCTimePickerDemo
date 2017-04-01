//
//  JTCircleView.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCircleView.h"

// http://stackoverflow.com/questions/17038017/ios-draw-filled-circles

@implementation JTCircleView

- (instancetype)init
{
    self = [super init];
    if(!self){
        return nil;
    }
    
    self.backgroundColor = [UIColor clearColor];
    self.color = [UIColor whiteColor];
    
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, [self.backgroundColor CGColor]);
    CGContextFillRect(ctx, rect);

    rect = CGRectInset(rect, .5, .5);
    
    CGContextSetStrokeColorWithColor(ctx, [self.color CGColor]);
    CGContextSetFillColorWithColor(ctx, [self.color CGColor]);
    
    CGContextAddEllipseInRect(ctx, rect);
    CGContextFillEllipseInRect(ctx, rect);
    
    CGContextFillPath(ctx);
}

- (void)setColor:(UIColor *)color
{
    self->_color = color;
    
    [self setNeedsDisplay];
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
