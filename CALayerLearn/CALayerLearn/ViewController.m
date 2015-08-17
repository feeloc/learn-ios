//
//  ViewController.m
//  CALayerLearn
//
//  Created by hujianmeng on 15/8/17.
//  Copyright (c) 2015年 hujianmeng. All rights reserved.
//

#import "ViewController.h"
#import "ProgressView.h"

@interface ViewController ()
@property(nonatomic, strong) CALayer *layer;
@property(nonatomic, strong) ProgressView *progressView;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, strong) NSArray *color;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 创建一个view
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    contentView.backgroundColor = [UIColor redColor];

    [self.view addSubview:contentView];

    // 修改view的相关值
    contentView.layer.frame = CGRectMake(0, 0, 375, 2);
    contentView.layer.backgroundColor = [UIColor grayColor].CGColor;

    // 创建CALayer
    _layer = [CALayer layer];
    _layer.frame = CGRectMake(0, 0, 0, 2);
    _layer.backgroundColor = [UIColor yellowColor].CGColor;

    // layer添加到容器中
    [contentView.layer addSublayer:_layer];

    // 创建动画
    [self performSelector:@selector(layerAnimation) withObject:nil afterDelay:3.0f];

    // 通过插件创建
    _progressView = [[ProgressView alloc] initWithFrame:CGRectMake(0, 100, 400, 2)];

    [self.view addSubview:_progressView];
    [self performSelector:@selector(progressAnimation) withObject:nil afterDelay:2.0f];

    //创建定时器1S执行一次
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(progressAnimation) userInfo:nil repeats:YES];

    _color = [[NSArray alloc]
            initWithObjects:[UIColor yellowColor], [UIColor redColor], nil];
}

- (void)layerAnimation {
    _layer.frame = CGRectMake(0, 0, 375, 2);
    _layer.backgroundColor = [UIColor blueColor].CGColor;
}

- (void)progressAnimation {
    _progressView.progress = arc4random() % 100 / 100.f;
    _progressView.backgroundColor = [_color objectAtIndex:arc4random() % 2];
}

@end
