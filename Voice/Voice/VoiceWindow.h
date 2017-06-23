//
//  VoiceWindow.h
//  mask
//
//  Created by 邝战锋 on 2017/6/21.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kIconWidth 80.f
#define kIconHeight 80.f
#define kIconY 120.f

@interface VoiceWindow : UIWindow


/**
 是否在语音中
 */
@property (nonatomic, assign) BOOL isVoice;

+ (instancetype)share;

/**
 显示视图
 */
- (void)show;

/**
 全屏
 */
- (void)fullScreen;

@end
