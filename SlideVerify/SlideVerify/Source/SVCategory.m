//
//  SVCategory.m
//  SlideVerify
//
//  Created by Harvey on 2018/3/30.
//  Copyright © 2018年 com.Group.Harvey. All rights reserved.
//

#import "SVCategory.h"
#import "SVSlideVerifyView.h"

@implementation UIImage (Size)

- (CGFloat)width {
    
    return self.size.width;
}

- (CGFloat)height {
    
    return self.size.height;
}

@end


@implementation UIView (Position)

- (CGFloat)left {
    
    return self.frame.origin.x;
}

- (CGFloat)right {
    
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)top {
    
    return self.frame.origin.y;
}

- (CGFloat)bottom {
    
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)width {
    
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    
    CGRect aFrame = self.frame;
    aFrame.size.width = width;
    self.frame = aFrame;
}

- (CGFloat)height {
    
    return self.frame.size.height;
}

@end



@implementation NSString (LocalImage)

- (UIImage *)toImage {
    
    NSBundle *bundle = [NSBundle bundleForClass:[SVSlideVerifyView class]];
     return [UIImage imageNamed:self inBundle:bundle compatibleWithTraitCollection:nil];
}

@end
