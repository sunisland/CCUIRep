//
//  UIView+FZMCMFrame.h
//  FZM_CMUI_Example
//
//  Created by 33 on 2018/11/26.
//  Copyright © 2018年 2711056454@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIView (FZMCMFrame)

@property (nonatomic, assign) CGFloat FZMCM_centerX;
@property (nonatomic, assign) CGFloat FZMCM_centerY;

@property (nonatomic, assign) CGFloat FZMCM_x;
@property (nonatomic, assign) CGFloat FZMCM_y;
@property (nonatomic, assign) CGFloat FZMCM_width;
@property (nonatomic, assign) CGFloat FZMCM_height;

@property (nonatomic, assign) CGFloat FZMCM_tail;
@property (nonatomic, assign) CGFloat FZMCM_bottom;

@property (nonatomic, assign) CGSize FZMCM_Size;

@property (nonatomic, assign, readonly) CGFloat FZMCM_middleX;
@property (nonatomic, assign, readonly) CGFloat FZMCM_middleY;

@end


