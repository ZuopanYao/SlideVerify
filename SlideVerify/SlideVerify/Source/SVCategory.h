//
//  SVCategory.h
//  SlideVerify
//
//  Created by Harvey on 2018/3/30.
//  Copyright © 2018年 com.Group.Harvey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (Size)

@property (nonatomic, assign, readonly) CGFloat width;
@property (nonatomic, assign, readonly) CGFloat height;

@end


@interface UIView (Position)

@property (nonatomic, assign, readonly) CGFloat left;
@property (nonatomic, assign, readonly) CGFloat top;
@property (nonatomic, assign, readonly) CGFloat right;
@property (nonatomic, assign, readonly) CGFloat bottom;
@property (nonatomic, assign, readwrite) CGFloat width;
@property (nonatomic, assign, readonly) CGFloat height;

@end


@interface NSString (LocalImage)

@property (nonatomic, strong, readonly, nullable) UIImage *toImage;

@end
