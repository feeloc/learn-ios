//
//  ProgressView.m
//  CALayerLearn
//
//  Created by hujianmeng on 15/8/17.
//  Copyright (c) 2015年 hujianmeng. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView ()

@property CALayer *progressLayer;   // 进度layer
@property(nonatomic, assign) CGFloat currentViewWidth;  // 当前的宽度
@property(nonatomic, strong) UIColor *backgroundColor;  // 背景颜色

@end

@implementation ProgressView

// 初使化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        _progressLayer = [CALayer layer];
        _progressLayer.frame = CGRectMake(0, 0, 0, frame.size.height);
        _progressLayer.backgroundColor = [UIColor redColor].CGColor;

        [self.layer addSublayer:_progressLayer];

        // 当前view的宽度值
        _currentViewWidth = frame.size.width;
    }
    return self;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;

    if (progress <= 0) {
        _progressLayer.frame = CGRectMake(0, 0, 0,
                self.frame.size.height);
    } else if (progress <= 1) {
        _progressLayer.frame = CGRectMake(0, 0,
                progress * _currentViewWidth,
                self.frame.size.height);
    } else {
        _progressLayer.frame = CGRectMake(0, 0,
                _currentViewWidth,
                self.frame.size.height);
    }
}

- (CGFloat)getProgress {
    return _progress;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _progressLayer.backgroundColor = backgroundColor.CGColor;
}
@end
