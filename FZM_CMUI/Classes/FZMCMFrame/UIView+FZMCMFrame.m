//
//  UIView+FZMCMFrame.m
//  FZM_CMUI_Example
//
//  Created by 33 on 2018/11/26.
//  Copyright © 2018年 2711056454@qq.com. All rights reserved.
//

#import "UIView+FZMCMFrame.h"

@implementation UIView (FZMCMFrame)
- (CGFloat)FZMCM_height
{
    return self.frame.size.height;
}

- (CGFloat)FZMCM_width
{
    return self.frame.size.width;
}

- (void)setFZMCM_height:(CGFloat)FZMCM_height {
    CGRect frame = self.frame;
    frame.size.height = FZMCM_height;
    self.frame = frame;
}
- (void)setFZMCM_width:(CGFloat)FZMCM_width {
    CGRect frame = self.frame;
    frame.size.width = FZMCM_width;
    self.frame = frame;
}

- (CGFloat)FZMCM_x
{
    return self.frame.origin.x;
}

- (void)setFZMCM_x:(CGFloat)FZMCM_x {
    CGRect frame = self.frame;
    frame.origin.x = FZMCM_x;
    self.frame = frame;
}


- (CGFloat)FZMCM_y
{
    return self.frame.origin.y;
}


- (void)setFZMCM_y:(CGFloat)FZMCM_y {
    CGRect frame = self.frame;
    frame.origin.y = FZMCM_y;
    self.frame = frame;
}


- (void)setFZMCM_centerX:(CGFloat)FZMCM_centerX {
    CGPoint center = self.center;
    center.x = FZMCM_centerX;
    self.center = center;
}

- (CGFloat)FZMCM_centerX
{
    return self.center.x;
}


- (void)setFZMCM_centerY:(CGFloat)FZMCM_centerY {
    CGPoint center = self.center;
    center.y = FZMCM_centerY;
    self.center = center;
}

- (CGFloat)FZMCM_centerY
{
    return self.center.y;
}


- (CGFloat)FZMCM_tail{
    
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setFZMCM_tail:(CGFloat)FZMCM_tail{
    self.FZMCM_x = FZMCM_tail - self.FZMCM_width;
}


- (CGFloat)FZMCM_bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setFZMCM_bottom:(CGFloat)FZMCM_bottom{
    self.FZMCM_y = FZMCM_bottom - self.FZMCM_height;
}

- (void)setFZMCM_Size:(CGSize)FZMCM_Size{
    CGRect frame = self.frame;
    frame.size = FZMCM_Size;
    self.frame = frame;
}

- (CGSize)FZMCM_Size{
    return self.frame.size;
}


- (CGFloat )FZMCM_middleX{
    return self.FZMCM_width * 0.5;
}

- (CGFloat)FZMCM_middleY{
    return self.FZMCM_height * 0.5;
}

@end
