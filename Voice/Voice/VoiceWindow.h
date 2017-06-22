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

@property (nonatomic, assign) BOOL isVoice;

+ (instancetype)share;
- (void)show;
- (void)fullScreen;

@end
