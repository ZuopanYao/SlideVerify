//
//  UIColor+Hex.m
//  YSUnion
//
//  Created by Harvey on 2016/10/12.
//  Copyright © 2016年 All rights reserved.
//

#import "UIColor+Hex.h"

UIColor * __nullable UIColorFromRGB(CGFloat R, CGFloat G, CGFloat B) {
    
    return UIColorFromRGBA(R, G, B, 1.0);
}

UIColor * __nullable UIColorFromRGBA(CGFloat R, CGFloat G, CGFloat B, CGFloat alpha) {
    
   return  [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:alpha];
}

UIColor * __nullable UIColorFromHexValue(NSUInteger hexValue) {
    
    CGFloat red = (hexValue & 0xFF0000) >> 16;
    CGFloat green = (hexValue & 0x00FF00) >> 8;
    CGFloat blue = hexValue & 0x0000FF;
    
    
    return UIColorFromRGB(red, green, blue);
}

