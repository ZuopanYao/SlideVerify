//
//  SVSlideBarView.m
//  SlideVerify
//
//  Created by Harvey on 2018/3/31.
//  Copyright © 2018年 com.Group.Harvey. All rights reserved.
//

#import "SVSlideBarView.h"
#import "SVCategory.h"

@interface SVSlideBarView ()
{
    BOOL isLoaded;
    UIButton *slideBar;
    
    CGPoint startPoint;
    BOOL isLegalPoint;
}
@end

@implementation SVSlideBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1].CGColor;
        self.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
        self.layer.shadowColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1].CGColor;
        self.layer.shadowOffset = CGSizeZero;
        self.layer.shadowRadius = 4;
        self.layer.shadowOpacity = 0.5;
        
        slideBar = [UIButton buttonWithType:UIButtonTypeCustom];
        slideBar.backgroundColor = [UIColor whiteColor];
        slideBar.userInteractionEnabled = NO;
        [slideBar setImage:@"arrow_bar_normal".toImage forState:UIControlStateNormal];
        [self addSubview:slideBar];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!isLoaded) {
        
        isLoaded = YES;
        [self adjustSubviews];
    }
}

- (void)adjustSubviews {
 
    slideBar.frame = CGRectMake(0, 0, self.height, self.height);
}

#pragma mark - Custom Touch Handling
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
 
    startPoint = [touches.allObjects.lastObject locationInView:self];
    
    if (CGRectContainsPoint(slideBar.frame, startPoint)) {
        
        slideBar.backgroundColor = [UIColor colorWithRed:0.15 green:0.58 blue:0.97 alpha:1];
        [slideBar setImage:@"arrow_bar_Highlighted".toImage forState:UIControlStateNormal];
        isLegalPoint = YES;
    }else {
        
        isLegalPoint = NO;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (!isLegalPoint) {
        
        return;
    }
    
    CGPoint currentPoint = [touches.allObjects.lastObject locationInView:self];
    
    CGFloat moveX = currentPoint.x - startPoint.x;
    startPoint.x = currentPoint.x;
    
    self.movedBlock(moveX, NO);
    
    CGPoint center = slideBar.center;
    center.x += moveX;
    if (center.x<slideBar.width/2.0) {
        
        center.x = slideBar.width/2.0;
    }else if (center.x+slideBar.width/2.0>self.width) {
        
        center.x = self.width - slideBar.width/2.0;
    }
    slideBar.center = center;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGPoint endedPoint = [touches.allObjects.lastObject locationInView:self];
    if (!CGPointEqualToPoint(startPoint, endedPoint) && isLegalPoint) {
        
        self.movedBlock(0, YES);
    }
    
    [slideBar setImage:@"arrow_bar_normal".toImage forState:UIControlStateNormal];
    slideBar.backgroundColor = [UIColor whiteColor];
    
    slideBar.frame = CGRectMake(0, 0, self.height, self.height);
}

#pragma mark -

@end
