一、CALayer隐式动画
```objective-c
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

```

二、CALayer封装加载动画
```objective-c

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

```

三、UIImageView中的CALayer
* 操作UIImageView的CALayer的bounds值进行显式动画
* 修改UIImageView的CALayer的content值切换图片动画
* 用CAAnimationGroup将bounds动画与contents动画结合
* 封装UIView的子类成组件
