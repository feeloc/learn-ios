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

```objective-c

@interface ViewController ()

@property(nonatomic, strong) CALayer *layer;
@property(nonatomic, strong) ProgressView *progressView;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, strong) NSArray *color;

@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) CALayer *imageLayer;
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
    _progressView = [[ProgressView alloc] initWithFrame:CGRectMake(0, 40, 400, 2)];

    [self.view addSubview:_progressView];
    [self performSelector:@selector(progressAnimation) withObject:nil afterDelay:2.0f];

    //创建定时器1S执行一次
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(progressAnimation) userInfo:nil repeats:YES];

    _color = [[NSArray alloc]
            initWithObjects:[UIColor yellowColor], [UIColor redColor], nil];

    // 图片
    _image = [UIImage imageNamed:@"2.jpg"];
    // 创建layer
    _imageLayer = [CALayer layer];
    _imageLayer.frame = CGRectMake(0, 70, 400, 600);
    _imageLayer.contents = (__bridge id) _image.CGImage;
    // 添加sublayer
    [self.view.layer addSublayer:_imageLayer];

    // 3S后开始动画
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changeImageLayer) userInfo:nil repeats:YES];
//    [self performSelector:@selector(changeImageLayer) withObject:nil afterDelay:3.0f];
}

- (void)layerAnimation {
    _layer.frame = CGRectMake(0, 0, 375, 2);
    _layer.backgroundColor = [UIColor blueColor].CGColor;
}

- (void)progressAnimation {
    _progressView.progress = arc4random() % 100 / 100.f;
    _progressView.backgroundColor = [_color objectAtIndex:arc4random() % 2];
}

- (void)changeImageLayer {
    // content动画
    float index = [[@[[NSNumber numberWithFloat:1.0f], [NSNumber numberWithFloat:2.0f]] objectAtIndex:arc4random() % 2] floatValue];

    NSString *img = [[NSArray arrayWithObjects:@"2.jpg", @"3.jpg", nil] objectAtIndex:arc4random() % 2];
    CGRect rect = CGRectMake(0, 0, 400 / index, 600 / index);

    CABasicAnimation *contentsAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
    contentsAnimation.fromValue = _imageLayer.contents;
    contentsAnimation.toValue = (__bridge id) [UIImage imageNamed:img].CGImage;
    contentsAnimation.duration = 2.0f;

    CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundsAnimation.fromValue = [NSValue valueWithCGRect:_imageLayer.bounds];
    boundsAnimation.toValue = [NSValue valueWithCGRect:rect];
    boundsAnimation.duration = 2.0f;

    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[contentsAnimation, boundsAnimation];

    _imageLayer.bounds = rect;
    _imageLayer.contents = (__bridge id) [UIImage imageNamed:img].CGImage;

    [_imageLayer addAnimation:contentsAnimation forKey:nil];
}

@end

```
