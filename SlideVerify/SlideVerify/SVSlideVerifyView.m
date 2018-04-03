//
//  SVSlideVerifyView.m
//  Demo
//
//  Created by Harvey on 2018/3/27.
//  Copyright © 2018年 Harvey. All rights reserved.
//

#import "SVSlideVerifyView.h"
#import "SVCategory.h"
#import "SVTargetView.h"

@interface SVSlideVerifyView ()
{
    BOOL isLoaded;
    UIImageView *arrowView;
    CGPoint beganPoint;
}
@property (strong, nonatomic, nonnull) SVTargetView *targetView;
@property (strong, nonatomic, nonnull) UIImageView *interactView;

@property (nonatomic, assign) CGPoint interactCenter;
@property (nonatomic, assign) BOOL isVerified;
@property (nonatomic, assign) BOOL isLegalPoint;


@end

@implementation SVSlideVerifyView

@synthesize targetSize = _targetSize;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFit;
        
        [self design];
        
        self.padding = 5.0;
        self.offsetValue = 5.0;
        self.radius = 6.0;
        self.targetSize = CGSizeMake(50, 50);
        self.targetColor = [UIColor whiteColor];
        self.interactColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (!isLoaded) {
        
        isLoaded = YES;
        [self adjustSubviews];
    }
    
    [self refresh];
}

- (void)adjustSubviews {
    
    self.targetView.frame = self.bounds;
    self.interactView.layer.shadowColor = self.interactColor.CGColor;
    self.interactView.frame = CGRectMake(0, 0, self.targetSize.width, self.targetSize.height);
}

#pragma mark - Property Method
- (void)setImage:(UIImage *)image {
    
    [super setImage:image];
    self.targetView.originImage = image;
}

- (void)setPadding:(CGFloat)padding {
    
    _padding = padding;
    self.targetView.padding = padding;
}

- (void)setTargetColor:(UIColor *)targetColor {
    
    _targetColor = targetColor;
    self.targetView.targetColor = targetColor;
}

- (void)setInteractColor:(UIColor *)interactColor {
    
    _interactColor = interactColor;
    self.targetView.interactColor = interactColor;
}

- (void)setSlideBarView:(SVSlideBarView *)slideBarView {
    
    _slideBarView = slideBarView;
    __weak typeof(self) weakSelf = self;
    _slideBarView.movedBlock = ^(CGFloat moveDistance, BOOL isEnded) {
        
        if (isEnded) {
            
            [weakSelf runVerification];
        }else {
            
            CGPoint center = weakSelf.interactView.center;
            center.x += moveDistance;
            center.x = [weakSelf adjustCenterX:center.x withAreaWidth:weakSelf.interactView.width];
            weakSelf.interactView.center = center;
        }
    };
}

#pragma mark -
- (void)refresh {
    
    [self.targetView refresh];
    
    self.isVerified = NO;
    self.interactView.image = self.targetView.interactImage;
    
    self.interactCenter = self.targetView.interactCenter;
    if (self.slideBarView) {
        
        self.interactCenter = CGPointMake(self.interactCenter.x, self.targetView.targetCenter.y);
    }
    self.interactView.center = self.interactCenter;
    self.interactView.hidden = NO;
    
    [self guideAnimation];
}

- (void)design {
    
    self.targetView = [[SVTargetView alloc] init];
    self.targetView.contentMode = UIViewContentModeScaleAspectFit;
    self.targetView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.targetView];
    
    self.interactView = [[UIImageView alloc] init];
    self.interactView.contentMode = UIViewContentModeScaleAspectFit;
    self.interactView.layer.shadowOffset = CGSizeZero;
    self.interactView.layer.shadowOpacity = 0.8;
    self.interactView.layer.shadowRadius = 4;
    [self addSubview:self.interactView];
    
    arrowView = [[UIImageView alloc] init];
    arrowView.hidden = YES;
    
    arrowView.image = @"arrow".toImage;
    arrowView.frame = CGRectMake(0, 0, 31, 34);
    [self addSubview:arrowView];
}

- (void)removeGuideAnimation {
    
    if (self.disableGuideAnimation) {
        
        return;
    }
    
    [arrowView.layer removeAnimationForKey:@"position"];
    arrowView.hidden = YES;
}

- (void)guideAnimation {
    
    if (self.slideBarView) {
        
        return;
    }
    
    if (self.disableGuideAnimation) {
        
        return;
    }
    [self removeGuideAnimation];
    
    arrowView.center = self.interactView.center;
    arrowView.hidden = NO;
    
    CGFloat angle = [self angleWithBetweenPoints:self.interactView.center :self.targetView.targetCenter];
    arrowView.transform = CGAffineTransformMakeRotation(angle);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    animation.fromValue = [NSValue valueWithCGPoint:self.interactView.center];
    animation.toValue = [NSValue valueWithCGPoint:self.targetView.targetCenter];
    
    animation.repeatCount = INT_MAX;
    animation.duration = 1.8;
    
    [arrowView.layer addAnimation:animation forKey:@"position"];
}

- (CGFloat)angleWithBetweenPoints:(CGPoint)startPoint :(CGPoint)endPoint{
    
    CGPoint Xpoint = CGPointMake(startPoint.x + 100, startPoint.y);
    
    CGFloat a = endPoint.x - startPoint.x;
    CGFloat b = endPoint.y - startPoint.y;
    CGFloat c = Xpoint.x - startPoint.x;
    CGFloat d = Xpoint.y - startPoint.y;
    
    CGFloat rads = acos(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
    if (startPoint.y>endPoint.y) {
        
        rads = -rads;
    }
    
    return rads;
}

#pragma mark - Property Method
- (void)setTargetSize:(CGSize)targetSize {
    
    _targetSize = targetSize;
    self.targetView.targetSize = targetSize;
}

- (void)setRadius:(CGFloat)radius {
    
    self.targetView.radius = radius;
}

#pragma mark -
- (CGFloat)adjustCenterX:(CGFloat)centerX withAreaWidth:(CGFloat)aWidth {
    
    CGFloat tCenterX = centerX;
    
    if (tCenterX<(aWidth/2.0+self.padding)) {
        
        tCenterX = aWidth/2.0+self.padding;
    }else if (tCenterX>(self.width - aWidth/2.0 - self.padding)) {
        
        tCenterX = (self.width - aWidth/2.0 - self.padding);
    }
    
    return tCenterX;
}

- (CGFloat)adjustCenterY:(CGFloat)centerY withAreaWidth:(CGFloat)aHeight {
    
    CGFloat tCenterY = centerY;
    
    if (tCenterY<(aHeight/2.0+self.padding)) {
        
        tCenterY = aHeight/2.0+self.padding;
    }else if (tCenterY>(self.height - aHeight/2.0 - self.padding)) {
        
        tCenterY = (self.height - aHeight/2.0 - self.padding);
    }
    
    return tCenterY;
}

#pragma mark - Custom Touch Handling
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self removeGuideAnimation];
    
    beganPoint = [touches.allObjects.lastObject locationInView:self];
    if (CGRectContainsPoint(self.interactView.frame, beganPoint)) {
        
        self.isLegalPoint = YES;
    }else {
        
        self.isLegalPoint = NO;
    }
    
    self.interactCenter = self.interactView.center;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (!self.isLegalPoint) {
        
        return;
    }
    
    if (self.isVerified) {
        
        return;
    }
    
    CGPoint point = [touches.allObjects.lastObject locationInView:self];
    point.x = [self adjustCenterX:point.x withAreaWidth:self.interactView.width];
    point.y = [self adjustCenterY:point.y withAreaWidth:self.interactView.height];
    
    self.interactView.center = point;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (!self.isLegalPoint) {
        
        return;
    }
    
    if (self.isVerified) {
        
        return;
    }
    
    CGPoint point = [touches.allObjects.lastObject locationInView:self];
    if (CGPointEqualToPoint(beganPoint, point)) {
        
        return;
    }
    
    [self runVerification];
}

- (void)runVerification {
    
    int offsetX = self.targetView.targetCenter.x - self.interactView.center.x;
    int offsetY = self.targetView.targetCenter.y - self.interactView.center.y;
    
    if (abs(offsetX)< self.offsetValue && abs(offsetY)< self.offsetValue) {
        
        self.isVerified = YES;
        self.interactView.hidden = YES;
        [self.targetView refreshWhenSuccess];
        self.compeleted(YES);
    }else {
        
        self.compeleted(NO);
        self.interactView.center = self.interactCenter;
    }
}

#pragma mark -
@end

