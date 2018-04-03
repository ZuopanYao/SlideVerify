//
//  SVSlideVerifyView.h
//  Demo
//
//  Created by Harvey on 2018/3/27.
//  Copyright © 2018年 Harvey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SlideVerify/SVSlideBarView.h>

@interface SVSlideVerifyView : UIImageView

@property (nonatomic, assign) CGSize targetSize;    // Defualt is (50,50)
@property (nonatomic, assign) CGFloat padding;      // Defualt is 5.0
@property (nonatomic, assign) CGFloat offsetValue;  // Defualt is 5.0
@property (nonatomic, assign) CGFloat radius;       // Defualt is 6.0
@property (nonatomic, assign) BOOL disableGuideAnimation; // Defualt is NO

@property (nonatomic, strong, nullable) UIColor *targetColor;
@property (nonatomic, strong, nullable) UIColor *interactColor;

@property (nonatomic, strong, nullable) SVSlideBarView *slideBarView;

@property (nonnull, copy, nonatomic) void (^compeleted)(BOOL isSuccess);

- (void)refresh;

@end
