//
//  ViewController.m
//  Demo
//
//  Created by Harvey on 2018/3/31.
//  Copyright © 2018年 com.Group.Harvey. All rights reserved.
//

#import "ViewController.h"
#import <SlideVerify/SlideVerify.h>
#import "Masonry.h"

@interface ViewController ()
{
    SVSlideVerifyView *scView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *originImage = [UIImage imageNamed:@"origin_image"];
    
    scView = [[SVSlideVerifyView alloc] init];
    scView.image = originImage;
    scView.disableGuideAnimation = NO;
    scView.targetColor = [UIColor whiteColor];
    scView.interactColor = [UIColor redColor];
    [self.view addSubview:scView];
    
    [scView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(50);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(originImage.size.width);     // 请保持与originImage的width一样,否则无法正常裁图
        make.height.mas_equalTo(originImage.size.height);   // 请保持与originImage的height一样,否则无法正常裁图
    }];
    
    SVSlideBarView *slideBarView = [[SVSlideBarView alloc] init];
    [self.view addSubview:slideBarView];
    [slideBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(scView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(scView.mas_width);
        make.height.mas_equalTo(40);
    }];
    
    scView.slideBarView = slideBarView;
    __weak typeof(self) weakSelf = self;
    scView.compeleted = ^(BOOL isSuccess) {
        
        [weakSelf showAlertWithTitle:isSuccess ? @"成功":@"失败"];
    };
}

- (void)showAlertWithTitle:(NSString *)title {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [ac addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:ac animated:YES completion:nil];
}

- (IBAction)refresh {
    
    [scView refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
