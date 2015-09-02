//
//  ViewController.m
//  SampleSDKApp
//
//  Created by admin on 15/2/2.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "ViewController.h"
#import "YoukeSDK.h"

// 获取设备屏幕的物理尺寸
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define KFColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define iOS6 ([[UIDevice currentDevice].systemVersion doubleValue] >= 6.0 && [[UIDevice currentDevice].systemVersion doubleValue] <= 7.0)
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1];
    
    CGFloat y = 150;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-280)/2, y, 280, 40)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"请使用以下DEMO账号登录 t.youkesdk.com";
    [self.view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-280)/2, CGRectGetMaxY(label.frame), 280, 40)];
    label1.backgroundColor = [UIColor clearColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"youkedemo@youkesdk.com\n123456";
    label1.textColor = KFColorFromRGB(0x777777);
    label1.font = [UIFont systemFontOfSize:14.0f];
    label1.numberOfLines = 0;
    label1.lineBreakMode = NSLineBreakByCharWrapping;
    [self.view addSubview:label1];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake((kScreenWidth-130)/2, y + 110, 130, 40);
    [button1 setTitle:@"在线客服" forState:0];
    [button1 setTitleColor:[UIColor blackColor] forState:0];
    button1.layer.cornerRadius = 20;
    button1.layer.masksToBounds = YES;
    button1.layer.borderWidth = 1.2;
    button1.layer.borderColor = KFColorFromRGB(0x555555).CGColor;
    [button1 addTarget:self action:@selector(buttonAction1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake((kScreenWidth-130)/2, y + 180, 130, 40);
    [button2 setTitle:@"帮助中心" forState:0];
    [button2 setTitleColor:[UIColor blackColor] forState:0];
    button2.layer.cornerRadius = 20;
    button2.layer.masksToBounds = YES;
    button2.layer.borderWidth = 1.2;
    button2.layer.borderColor = KFColorFromRGB(0x555555).CGColor;
    [button2 addTarget:self action:@selector(buttonAction2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

// 打开在线客服
- (void)buttonAction1 {
    [YoukeSDK contactCustomServiceWithViewController:self];
}
// 帮助中心
- (void)buttonAction2 {
    
    [YoukeSDK openHelpViewControllerWithViewController:self];
    
}

@end
