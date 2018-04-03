//
//  SVTargetView.h
//  SlideVerify
//
//  Created by Harvey on 2018/3/30.
//  Copyright © 2018年 com.Group.Harvey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SVTargetView : UIView

@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, assign, readonly) CGPoint targetCenter;

@property (nonatomic, strong, nullable) UIImage *originImage;
@property (nonatomic, strong, nullable, readonly) UIImage *interactImage;
@property (nonatomic, assign, readonly) CGPoint interactCenter;

@property (nonatomic, strong, nullable) UIColor *targetColor;
@property (nonatomic, strong, nullable) UIColor *interactColor;

@property (nonatomic, assign)  CGSize targetSize;
@property (nonatomic, assign)  CGFloat radius;

- (void)refresh;
- (void)refreshWhenSuccess;

@end
