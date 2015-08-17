//
//  ViewController.m
//  CALayerLearn
//
//  Created by hujianmeng on 15/8/17.
//  Copyright (c) 2015年 hujianmeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong) CALayer *layer;
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
}

- (void)layerAnimation {
    _layer.frame = CGRectMake(0, 0, 375, 2);
    _layer.backgroundColor = [UIColor blueColor].CGColor;
}

@end
