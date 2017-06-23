//
//  ViewController.m
//  Voice
//
//  Created by 邝战锋 on 2017/6/21.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "ViewController.h"
#import "VoiceViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *QQVoice = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 60)];
    [QQVoice setTitle:@"QQ语音" forState:UIControlStateNormal];
    [QQVoice setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [QQVoice addTarget:self action:@selector(voiceAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:QQVoice];
}

- (void)voiceAction {
    [self.navigationController pushViewController:[[VoiceViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
