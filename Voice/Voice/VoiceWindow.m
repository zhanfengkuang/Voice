//
//  VoiceWindow.m
//  mask
//
//  Created by 邝战锋 on 2017/6/21.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "VoiceWindow.h"
#import "FullScreenView.h"


@interface VoiceWindow () <CAAnimationDelegate>

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) CAShapeLayer *mask;

@end

@implementation VoiceWindow {
    CGRect _originMaskFrame;
}

+ (instancetype)share {
    static VoiceWindow *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[VoiceWindow alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    });
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        backgroundView.image = [UIImage imageNamed:@"a61773e9c1561d64240ce4d100027272.jpg"];
        [self addSubview:backgroundView];
        [self initView];
    }
    return self;
}

- (void)initView {
    self.backgroundColor = [UIColor redColor];
    _icon = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - kIconWidth) / 2, kIconY, kIconWidth, kIconHeight)];
    _icon.layer.masksToBounds = YES;
    _icon.layer.cornerRadius = kIconWidth / 2;
    _icon.image = [UIImage imageNamed:@"maple"];
    [self addSubview:_icon];
    
    UIButton *fullScreen = [UIButton buttonWithType:UIButtonTypeCustom];
    fullScreen.frame = CGRectMake((kScreenWidth - 100) / 2, 300, 100, 60);
    [fullScreen setTitle:@"缩小" forState:UIControlStateNormal];
    [fullScreen setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [fullScreen addTarget:self action:@selector(fullScreenAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:fullScreen];
}

- (void)fullScreenAction {
    //截屏(只能截取静态图) 在这里不改变size使用蒙板，没必要截图
////    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
////        UIGraphicsBeginImageContextWithOptions([UIScreen mainScreen].bounds.size, NO, [UIScreen mainScreen].scale);
////    } else {
////        UIGrap
////    }
//    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
//    imageView.image = image;
//    [self addSubview:imageView];
    
    //蒙板最大半径
    CGFloat radius = sqrt(pow(kScreenWidth / 2, 2) + pow(kScreenHeight - kIconY - kIconHeight / 2, 2));
    _mask = [CAShapeLayer layer];
    _mask.frame = CGRectMake(-(radius - kScreenWidth / 2), -(radius - (kIconY + kIconHeight / 2)), radius * 2, radius * 2);
    _originMaskFrame = _mask.frame;
    _mask.masksToBounds = YES;
    _mask.cornerRadius = radius;
    _mask.contents = (__bridge id)[UIImage imageNamed:@"mask"].CGImage;
    _mask.backgroundColor = [UIColor clearColor].CGColor;
    self.layer.mask = _mask;
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-(radius - kScreenWidth / 2), -(radius - (kIconY + kIconHeight / 2)), radius * 2, radius * 2) cornerRadius:radius];
//    mask.path = path.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.duration = 1.f;
    animation.keyPath = @"bounds";
    animation.fromValue = [NSValue valueWithCGRect:_mask.frame];
    animation.toValue = [NSValue valueWithCGRect:_icon.frame];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    [_mask addAnimation:animation forKey:@"scaleScreen"];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [[FullScreenView share] show];
    self.hidden = YES;
}

- (void)show {
    [self makeKeyAndVisible];
}

- (void)fullScreen {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.duration = 1.f;
    animation.keyPath = @"bounds";
    animation.toValue = [NSValue valueWithCGRect:_originMaskFrame];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [_mask addAnimation:animation forKey:@"fullScreen"];
}





@end






