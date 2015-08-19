//
//  ViewController.m
//  RoundHeadPortrait
//
//  Created by 66 on 15/8/14.
//  Copyright (c) 2015年 w66. All rights reserved.
//

#import "ViewController.h"
#import "WliuHeadPortraitImageView.h"
@interface ViewController () <WliuHeadPortraitImageViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // test1
//    WliuHeadPortraitImageView *iconV0 = [[WliuHeadPortraitImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    iconV0.backgroundColor = [UIColor redColor];
//    iconV0.maskBGColor = [UIColor yellowColor];
//    iconV0.maskAlpha = 0.6;
//    [self.view addSubview:iconV0];
    // test 2
//    WliuHeadPortraitImageView *iconV1 = [[WliuHeadPortraitImageView alloc] init];
//    iconV1.frame = CGRectMake(100, 100, 100, 200);
//    iconV1.backgroundColor = [UIColor redColor];
//    iconV1.maskBGColor = [UIColor blackColor];
//    iconV1.maskAlpha = 0.6;
//    [self.view addSubview:iconV1];
//    UIView *mask = [[UIView alloc] initWithFrame:CGRectMake(100, 150, 100, 100)];
//    mask.backgroundColor = [UIColor blackColor];
//    mask.alpha = 0.6;
//    [self.view addSubview:mask];
    // test 3
    
    WliuHeadPortraitImageView *iconV = [[WliuHeadPortraitImageView alloc] init];
    iconV.frame = CGRectMake(100, 100, 100, 300);
    iconV.cornerRadius = 22;
    iconV.borderColor = [UIColor redColor];
    iconV.borderWidth = 6;
    iconV.image = [UIImage imageNamed:@"20150409134630_17_5249091.jpg"];
    iconV.maskBGColor = [UIColor blackColor];
    iconV.maskAlpha = 0.6;
    iconV.highlightBorderColor = [UIColor brownColor];
    iconV.highlightBorderWidth = 10;
    iconV.highlightMaskAlpha = 0.5;
    iconV.highlightMaskBGColor = [UIColor whiteColor];
    iconV.delegate = self;
    [self.view addSubview:iconV];
    
    WliuHeadPortraitImageView *iconV6 = [[WliuHeadPortraitImageView alloc] init];
    iconV6.frame = CGRectMake(100, 60, 100, 100);
    iconV6.borderColor = [UIColor redColor];
    iconV6.borderWidth = 6;
    iconV6.image = [UIImage imageNamed:@"20150409134630_17_5249091.jpg"];
    iconV6.maskBGColor = [UIColor blackColor];
    iconV6.maskAlpha = 0.6;
    iconV6.highlightBorderColor = [UIColor brownColor];
    iconV6.highlightBorderWidth = 10;
    iconV6.highlightMaskAlpha = 0.5;
    iconV6.highlightMaskBGColor = [UIColor whiteColor];
    iconV6.delegate = self;
    [self.view addSubview:iconV6];

    
    
//    UIImageView *iV = [[UIImageView alloc] init];
//    iV.animationImages = @[];
//    iV.animationDuration = 0.3;
//    [iV startAnimating];// 按住说话贱执行
//    [iV stopAnimating];// 拔出说话贱执行
    
    
    
    
    // test
    //    WliuHeadPortraitImageView *iconV = [WliuHeadPortraitImageView allocWithZone:nil];
    //    iconV.frame = CGRectMake(100, 100, 100, 200);
    //    iconV.backgroundColor = [UIColor redColor];
    //    [self.view addSubview:iconV];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)w6_isClicked
{
    NSLog(@"完成了");
}
@end
