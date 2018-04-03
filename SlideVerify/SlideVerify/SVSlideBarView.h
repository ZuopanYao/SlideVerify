//
//  SVSlideBarView.h
//  SlideVerify
//
//  Created by Harvey on 2018/3/31.
//  Copyright © 2018年 com.Group.Harvey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SVSlideBarView : UIView

@property (nonnull, copy, nonatomic) void (^movedBlock)(CGFloat moveDistance, BOOL isEnded);

@end
