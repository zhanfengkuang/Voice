//
//  FullScreenView.m
//  Voice
//
//  Created by 邝战锋 on 2017/6/21.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "FullScreenView.h"
#import "VoiceWindow.h"

#define kWidthScale 40
#define kHeightScale 40

#define kDuration 1.

@interface FullScreenView () <CAAnimationDelegate>

@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) CAShapeLayer *mask;

@end

@implementation FullScreenView{
    CGRect _originFrame;
}

+ (instancetype)share {
    static FullScreenView *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FullScreenView alloc] initWithFrame:CGRectMake((kScreenWidth - kIconWidth) / 2, 120, kIconWidth, kIconHeight)];
    });
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _originFrame = frame;
        self.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}

- (void)initView {
//    _mask = [CAShapeLayer layer];
//    _mask.contents = (__bridge id)[UIImage imageNamed:@"mask"].CGImage;
//    _mask.frame = self.bounds;
    
    _icon = [[UIImageView alloc] initWithFrame:self.bounds];
    _icon.image = [UIImage imageNamed:@"maple"];
    _icon.userInteractionEnabled = YES;
    _icon.layer.masksToBounds = YES;
    _icon.layer.cornerRadius = kIconWidth / 2;
    [self addSubview:_icon];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fullScreen)];
    [_icon addGestureRecognizer:tap];
}

- (void)fullScreen {
    _icon.image = [UIImage imageNamed:@"maple"];
    [UIView animateWithDuration:kDuration animations:^{
        self.frame = _originFrame;
        _icon.frame = CGRectMake(0, 0, kIconWidth, kIconHeight);
    } completion:^(BOOL finished) {
        
    }];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation.duration = kDuration;
    animation.toValue = @(kIconWidth / 2);
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    [_icon.layer addAnimation:animation forKey:nil];
}

- (void)show {
    [self makeKeyAndVisible];
    [self groupAnimation];
}

- (void)groupAnimation {
    [UIView animateWithDuration:kDuration animations:^{
        self.frame = CGRectMake(kScreenWidth - 60, kScreenHeight - 180, kWidthScale, kHeightScale);
        _icon.frame = CGRectMake(0, 0, kWidthScale, kHeightScale);
    } completion:^(BOOL finished) {
        _icon.image = [UIImage imageNamed:@"phone"];
    }];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation.duration = kDuration;
    animation.toValue = @(kWidthScale / 2);
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [_icon.layer addAnimation:animation forKey:nil];
}

#pragma mark - UITouch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _startPoint = [[touches anyObject] locationInView:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint currentPoint = [[touches anyObject] locationInView:self];
    CGPoint center = self.center;
    center.x += currentPoint.x - _startPoint.x;
    center.y += currentPoint.y - _startPoint.y;
    self.center = center;
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [VoiceWindow share].hidden = NO;
    [[VoiceWindow share] fullScreen];
    self.hidden = YES;
}



@end
