//
//  CCHourCircleSlider.m
//  CCTimePickerDemo
//
//  Created by eHome on 17/3/30.
//  Copyright © 2017年 Bref. All rights reserved.
//

#import "CCHourCircleSlider.h"

#define numberPadding 10

@interface CCHourCircleSlider()

@property (nonatomic, assign) CGFloat rotation;
@property (nonatomic) CGAffineTransform currentTransform;

@property (nonatomic, assign) CGFloat AMLength;
@property (nonatomic, assign) BOOL isSelectAM;


@end

@implementation CCHourCircleSlider

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
    self.opaque = NO;
    
    self.currentTransform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
    self.unselectColor = [UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1];
    self.selectColor = self.unselectColor;
    self.indicatorColor = [UIColor colorWithRed:30/255.f green:140/255.f blue:220/255.f alpha:1];
    
    self.circleWidth = 20;
    self.contextPadding = 20;

}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGFloat lineOffset = self.circleWidth / 2;
    CGSize contextSize = CGSizeMake(rect.size.width - self.contextPadding, rect.size.height - self.contextPadding);
    
    CGFloat centerX = rect.size.width / 2;
    CGFloat centerY = rect.size.height / 2;
    CGFloat radius = contextSize.width / 2 - lineOffset;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, self.unselectColor.CGColor);
    CGContextAddArc(context, centerX, centerY, radius, 0, 2 * M_PI, 0);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextSetStrokeColorWithColor(context, self.unselectColor.CGColor);
    CGContextSetLineWidth(context, self.circleWidth);
    CGContextAddArc(context, centerX, centerY, radius, 0, 2 * M_PI, 0);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGPoint centerPoint = CGPointMake(centerX - lineOffset, centerY - lineOffset);
    
    
    
    self.AMLength = fabs(contextSize.width / 2 - numberPadding / 2 - self.circleWidth);

    
    //绘制小圆球
    CGPoint dotPoint;
    
    if (self.isSelectAM) {
        dotPoint.y = round(centerPoint.y + (centerPoint.y - self.circleWidth - numberPadding - self.contextPadding / 2) * sin(self.rotation));
        dotPoint.x = round(centerPoint.x + (centerPoint.x - self.circleWidth - numberPadding - self.contextPadding / 2) * cos(self.rotation));
    }else
    {
        dotPoint.y = round(centerPoint.y + (centerPoint.y - self.contextPadding / 2) * sin(self.rotation));
        dotPoint.x = round(centerPoint.x + (centerPoint.x - self.contextPadding / 2) * cos(self.rotation));
    }
    
    [self.indicatorColor set];
    
    CGContextFillEllipseInRect(context, CGRectMake(dotPoint.x, dotPoint.y, self.circleWidth, self.circleWidth));
    
    CGContextSetStrokeColorWithColor(context, self.indicatorColor.CGColor);
    CGContextSetLineWidth(context, 1.f);
    CGContextMoveToPoint(context, centerX, centerY);
    CGContextAddLineToPoint(context, dotPoint.x + self.circleWidth / 2 , dotPoint.y + self.circleWidth / 2);
    CGContextStrokePath(context);
    
    
    
    //绘制0~12
    for (float i = 0; i < 12; i ++) {
        CGFloat timeNumberRotation = (i * 30.f - 60) / 360.f * 2.f * M_PI;
        CGPoint timeNumberPoint;
        timeNumberPoint.y = round(centerPoint.y + (centerPoint.y - self.circleWidth - numberPadding - self.contextPadding / 2) * sin(timeNumberRotation));
        timeNumberPoint.x = round(centerPoint.x + (centerPoint.x - self.circleWidth - numberPadding - self.contextPadding / 2) * cos(timeNumberRotation));
        
        CGContextSetLineWidth(context, 1.f);
        NSString *timeNumber = [NSString stringWithFormat:@"%.0f",i + 1];
        CGSize stringSize = [timeNumber sizeWithAttributes:@{
                                                             NSFontAttributeName : [UIFont systemFontOfSize:12]
                                                             }];
        
        [timeNumber drawInRect:CGRectMake(timeNumberPoint.x + self.circleWidth / 2 - stringSize.width / 2, timeNumberPoint.y + self.circleWidth / 2 - stringSize.height / 2, self.circleWidth, self.circleWidth)
                withAttributes:@{
                                 NSFontAttributeName : [UIFont systemFontOfSize:12],
                                 NSForegroundColorAttributeName : [UIColor whiteColor]
                                 }];
        
    }
    
    
    //绘制13~24
    for (float i = 12; i < 24; i ++) {
        CGFloat timeNumberRotation = (i * 30.f - 60) / 360.f * 2.f * M_PI;
        CGPoint timeNumberPoint;
        timeNumberPoint.y = round(centerPoint.y + (centerPoint.y - self.contextPadding / 2) * sin(timeNumberRotation));
        timeNumberPoint.x = round(centerPoint.x + (centerPoint.x - self.contextPadding / 2) * cos(timeNumberRotation));
        
        CGContextSetLineWidth(context, 1.f);
        NSString *timeNumber = [NSString stringWithFormat:@"%.0f",i + 1];
        CGSize stringSize = [timeNumber sizeWithAttributes:@{
                                                             NSFontAttributeName : [UIFont systemFontOfSize:12]
                                                             }];
        
        [timeNumber drawInRect:CGRectMake(timeNumberPoint.x + self.circleWidth / 2 - stringSize.width / 2, timeNumberPoint.y + self.circleWidth / 2 - stringSize.height / 2, self.circleWidth, self.circleWidth)
                withAttributes:@{
                                 NSFontAttributeName : [UIFont systemFontOfSize:12],
                                 NSForegroundColorAttributeName : [UIColor whiteColor]
                                 }];
        
    }
}

#pragma mark - Event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGPoint starTouchPoint = [[touches anyObject] locationInView:self];
    CGFloat rotation = atan2f(starTouchPoint.y - center.y, starTouchPoint.x - center.x);
    
    NSInteger angle = rotation / M_PI * 180;
    NSInteger newAngle = round(angle / 30.f) * 30;
    
    CGFloat newRotation = (CGFloat)newAngle / 180.f * M_PI;
    
    CGAffineTransform transform = CGAffineTransformRotate(_currentTransform, newRotation);
    
    
    CGFloat lengthBetweenCenterAndTouchPoint = sqrt((fabs(starTouchPoint.x) - fabs(center.x)) * (fabs(starTouchPoint.x) - fabs(center.x)) + (fabs(starTouchPoint.y) - fabs(center.y)) * (fabs(starTouchPoint.y) - fabs(center.y)));
    
    if (lengthBetweenCenterAndTouchPoint < self.AMLength) {
        self.isSelectAM = YES;
    }else{
        self.isSelectAM = NO;
    }
    
    [self changeAngleWithTransform:transform rotation:newRotation];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
}

- (void)endTrackingWithTouch:(nullable UITouch*)touch withEvent:(nullable UIEvent*)event
{
    [super endTrackingWithTouch:touch withEvent:event];
    [self sendActionsForControlEvents:UIControlEventEditingDidEnd];
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super continueTrackingWithTouch:touch withEvent:event];
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidX(self.bounds));
    CGPoint starTouchPoint = [touch locationInView:self];
    CGPoint endTouchPoint = [touch previousLocationInView:self];
    
    CGFloat rotation = atan2f(starTouchPoint.y - center.y, starTouchPoint.x - center.x) - atan2f(endTouchPoint.y - center.y, endTouchPoint.x - center.x);
    CGAffineTransform transform = CGAffineTransformRotate(_currentTransform, rotation);
    
    CGFloat starRotation = atan2f(starTouchPoint.y - center.y, starTouchPoint.x - center.x);
    
    NSInteger angle = starRotation / M_PI * 180;
    NSInteger newAngle = round(angle / 30.f) * 30;
    
    CGFloat newRotation = (CGFloat)newAngle / 180.f * M_PI;
    
    CGFloat lengthBetweenCenterAndTouchPoint = sqrt((fabs(starTouchPoint.x) - fabs(center.x)) * (fabs(starTouchPoint.x) - fabs(center.x)) + (fabs(starTouchPoint.y) - fabs(center.y)) * (fabs(starTouchPoint.y) - fabs(center.y)));
    
    if (lengthBetweenCenterAndTouchPoint < self.AMLength) {
        self.isSelectAM = YES;
    }else{
        self.isSelectAM = NO;
    }
    
    [self changeAngleWithTransform:transform rotation:newRotation];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}

- (void)changeAngleWithTransform:(CGAffineTransform)transform rotation:(CGFloat)rotation
{
    _currentTransform = transform;
    _rotation = rotation;
    self.angle = round(_rotation / M_PI * 180);
    
    [self setNeedsDisplay];
}

- (NSInteger)hour
{
    NSInteger angle = self.angle + 180;
    NSInteger hour;
    if (angle >= 0 && angle <= 90) {
        hour = angle / 30 + 9;
    }else{
        hour = angle / 30 - 3;
    }
    
    if (self.isSelectAM) {
        return hour;
    }else{
        return hour + 12;
    }
    
}

- (void)setHour:(NSInteger)hour
{
    if (hour > 12) {
        self.isSelectAM = NO;
    }else{
        self.isSelectAM = YES;
    }
    
    NSInteger angle;
    if (hour >= 9 && hour < 12) {
        angle = (hour - 9) * 30;
    }else
    {
        angle = (hour + 3) * 30;
    }
    
    self.angle = angle - 180;
    self.rotation = (CGFloat)self.angle / 180.f * M_PI;
    
    [self setNeedsDisplay];
}

@end
