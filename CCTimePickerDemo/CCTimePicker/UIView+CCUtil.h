//
//  UIView+CCUtil.h
//  CCTimePickerDemo
//
//  Created by eHome on 17/3/31.
//  Copyright © 2017年 Bref. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CCUtil)

@property(nonatomic,assign) CGPoint origin;
@property(nonatomic,assign) CGFloat originX;
@property(nonatomic,assign) CGFloat originY;
@property(nonatomic,assign) CGSize  size;
@property(nonatomic,assign) CGFloat  sizeW;
@property(nonatomic,assign) CGFloat  sizeH;
@property(nonatomic,assign) CGFloat centerX;
@property(nonatomic,assign) CGFloat centerY;

+ (instancetype)viewFromXib;

@end
