//
//  SVSlideBarView.m
//  SlideVerify
//
//  Created by Harvey on 2018/3/31.
//  Copyright © 2018年 com.Group.Harvey. All rights reserved.
//

#import "SVSlideBarView.h"
#import "SVCategory.h"
#import "UIColor+Hex.h"

@interface SVSlideBarView ()
{
    BOOL isLoaded;
    UIButton *slideBar;
    
    CGPoint startPoint;
    BOOL isLegalPoint;
    
    UIView *scrollBackView;
}

@property (nonnull, copy, nonatomic) void (^movedBlock)(CGFloat moveDistance, BOOL isEnded);
@property (assign, nonatomic) NSInteger stateCode;

@end

@implementation SVSlideBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.borderWidth = 1.0;
        self.backgroundColor = UIColorFromRGB(250, 250, 250);
        self.layer.shadowOffset = CGSizeZero;
        self.layer.shadowRadius = 4;
        self.layer.shadowOpacity = 0.5;
        
        scrollBackView = [[UIView alloc] init];
        [self addSubview:scrollBackView];
        
        slideBar = [UIButton buttonWithType:UIButtonTypeCustom];
        slideBar.userInteractionEnabled = NO;
        [slideBar setImage:@"arrow_bar_normal".toImage forState:UIControlStateNormal];
        [self addSubview:slideBar];
        
        [self defaultStyle];
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

- (void)setStateCode:(NSInteger)stateCode {

    _stateCode = stateCode;
    
    if (stateCode == 0) {

        [self failedStyle];
    }else if (stateCode == 1) {

        [self successfulStyle];
    }else if (stateCode == 2) {

        [self defaultStyle];
    }
}

- (void)failedStyle {
    
    scrollBackView.hidden = NO;
    scrollBackView.backgroundColor = UIColorFromRGB(250, 225, 225);
    slideBar.backgroundColor = UIColorFromRGB(244, 124, 124);
    self.layer.borderColor = slideBar.backgroundColor.CGColor;
    self.layer.shadowColor = self.layer.borderColor;
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [weakSelf defaultStyle];
    });
}

- (void)successfulStyle {
    
    scrollBackView.backgroundColor = UIColorFromRGB(210, 244, 240);
    slideBar.backgroundColor = UIColorFromRGB(88, 203, 186);
    self.layer.borderColor = slideBar.backgroundColor.CGColor;
    self.layer.shadowColor = self.layer.borderColor;
}

- (void)scrollStyleWithCenter: (CGPoint)point {
    
    scrollBackView.hidden = NO;
    slideBar.center = point;
    scrollBackView.width = point.x - self.height/2.0;
}

- (void)defaultStyle {
    
    scrollBackView.hidden = YES;
    scrollBackView.backgroundColor = UIColorFromRGB(210, 230, 250);
    slideBar.backgroundColor = UIColorFromRGB(38, 148, 248);
    self.layer.borderColor = slideBar.backgroundColor.CGColor;
    self.layer.shadowColor = self.layer.borderColor;
    
    [self adjustSubviews];
}

- (void)adjustSubviews {
 
    slideBar.frame = CGRectMake(0, 0, self.height, self.height);
    scrollBackView.frame = CGRectMake(0, 0, self.height/2.0, self.height);
}

#pragma mark - Custom Touch Handling
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    startPoint = [touches.allObjects.lastObject locationInView:self];
    
    if (CGRectContainsPoint(slideBar.frame, startPoint)) {
        
        isLegalPoint = YES;
    }else {
        
        isLegalPoint = NO;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.stateCode == 1) {
        
        return;
    }
    
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

    [self scrollStyleWithCenter:center];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGPoint endedPoint = [touches.allObjects.lastObject locationInView:self];
    if (!CGPointEqualToPoint(startPoint, endedPoint) && isLegalPoint && self.stateCode != 1 ) {
        
        self.movedBlock(0, YES);
    }
}

#pragma mark -

@end
