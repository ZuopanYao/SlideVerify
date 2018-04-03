//
//  SVTargetView.m
//  SlideVerify
//
//  Created by Harvey on 2018/3/30.
//  Copyright © 2018年 com.Group.Harvey. All rights reserved.
//

#import "SVTargetView.h"
#import "SVCategory.h"

@interface SVTargetView ()
{
    CGPoint point;
    BOOL isSuccess;
    
    CGFloat random1;
    CGFloat random2;
    CGFloat random3;
}
@end

@implementation SVTargetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)refresh {
    
    isSuccess = NO;
    CGFloat seed = self.targetSize.width - self.radius*4;
    random1 = arc4random_uniform(seed) + self.radius;
    random2 = arc4random_uniform(seed) + self.radius;
    random3 = arc4random_uniform(seed) + self.radius;
    
    point = [self generatePoint];
    [self setNeedsDisplay];// 异步
}

- (void)refreshWhenSuccess {
    
    isSuccess = YES;
    [self setNeedsDisplay];
}

- (CGPoint)generatePoint {
    
    CGPoint point = CGPointZero;
    point.x = arc4random_uniform(self.width/5.0*3.0) + self.width/5.0*3.0;
    point.y = arc4random_uniform(self.height);
    
    if (point.x < self.width/5.0*3.0+self.padding) {
        
        point.x = self.padding + self.width/5.0*3.0;
    }else if (point.x > self.width - self.padding - self.targetSize.width) {
        
        point.x = self.width - self.padding - self.targetSize.width;
    }
    
    if (point.y < self.padding) {
        
        point.y = self.padding;
    }else if (point.y > self.height - self.padding - self.targetSize.height) {
        
        point.y = self.height - self.padding - self.targetSize.height;
    }
    
    return point;
}

- (CGPoint)interactCenter {
    
    CGPoint point = CGPointZero;
    point.x = arc4random_uniform(self.width/5.0*2.0);
    point.y = arc4random_uniform(self.height);
    
    if (point.x < self.padding) {
        
        point.x = self.padding;
    }else if (point.x > self.width/5.0*2.0 - self.padding - self.targetSize.width) {
        
        point.x = self.width/5.0*2.0 - self.padding - self.targetSize.width;
    }
    
    if (point.y < self.padding) {
        
        point.y = self.padding;
    }else if (point.y > self.height - self.padding - self.targetSize.height) {
        
        point.y = self.height - self.padding - self.targetSize.height;
    }
    
    return CGPointMake(point.x+self.targetSize.width/2.0, point.y+self.targetSize.height/2.0);
}

- (CGPoint)targetCenter {
    
    return CGPointMake(point.x + self.targetSize.width/2.0, point.y + self.targetSize.height/2.0);
}

- (nullable UIImage *)interactImage {
    
    UIImage *targetImage = [self imageFromOriginImage:self.originImage inRect:CGRectMake(point.x, point.y, self.targetSize.width, self.targetSize.height)];
    
    UIGraphicsBeginImageContextWithOptions(targetImage.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorRef color = self.interactColor.CGColor;
    CGContextSetLineWidth(context, 2);  // 数值越大，绘出来的路径越大
    CGContextSetStrokeColorWithColor(context, color); // 路径颜色
    CGContextSetLineCap(context, kCGLineCapRound);   // 路径起点/终点处显示风格
    CGContextSetLineJoin(context, kCGLineJoinRound); // 路径连接(拐弯)处显示风格
    CGContextSetFillColorWithColor(context, color);
    CGContextSetShadowWithColor(context, CGSizeZero, 4, color);
    
    [self drawWithCGContextRef:context startPoint: CGPointZero];
    CGContextClip(context);
    
    [targetImage drawInRect:CGRectMake(0, 0, targetImage.width, targetImage.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)imageFromOriginImage:(UIImage *)image inRect:(CGRect)rect{
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat x= rect.origin.x*scale;
    CGFloat y=rect.origin.y*scale;
    CGFloat w=rect.size.width*scale;
    CGFloat h=rect.size.height*scale;
    
    CGRect dianRect = CGRectMake(x, y, w, h);
    
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    
    return newImage;
}

- (void)drawRect:(CGRect)rect {
    
    if (isSuccess) {
        
        return;
    }
    
    // 获取绘图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) {
        
        NSLog(@"获取绘图context失败");
        return;
    }
    
    CGColorRef color = self.targetColor.CGColor;
    
    CGContextSetLineWidth(context, 2);  // 数值越大，绘出来的路径越大
    CGContextSetStrokeColorWithColor(context, color); // 路径颜色
    CGContextSetLineCap(context, kCGLineCapRound);   // 路径起点/终点处显示风格
    CGContextSetLineJoin(context, kCGLineJoinRound); // 路径连接(拐弯)处显示风格
    CGContextSetFillColorWithColor(context, color);
    CGContextSetShadowWithColor(context, CGSizeZero, 4, color);
    
    [self drawWithCGContextRef:context startPoint: point];
    
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)drawWithCGContextRef:(CGContextRef)context startPoint:(CGPoint)point {
    
    CGContextMoveToPoint(context, point.x, point.y);
    
    // top
    CGContextAddLineToPoint(context, point.x + random1, point.y);
    CGContextAddArc(context, point.x + random1 + self.radius, point.y, self.radius, M_PI, 0, YES);
    CGContextAddLineToPoint(context, point.x + self.targetSize.width, point.y);
    
    // right
    CGContextAddLineToPoint(context, point.x + self.targetSize.width, point.y + random2);
    CGContextAddArc(context, point.x + self.targetSize.width, point.y + random2 + self.radius, self.radius, -M_PI/2.0, M_PI/2.0, YES);
    CGContextAddLineToPoint(context, point.x + self.targetSize.width, point.y + self.targetSize.height);
    
    // buttom
    CGContextAddLineToPoint(context, point.x, point.y + self.targetSize.height);
    
    // left
    CGContextAddLineToPoint(context, point.x, point.y + self.targetSize.height - random3);
    CGContextAddArc(context, point.x, point.y + self.targetSize.height - random3 - self.radius, self.radius, M_PI/2.0, 3*M_PI/2.0, YES);
    CGContextAddLineToPoint(context, point.x, point.y);
}

@end

