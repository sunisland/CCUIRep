//
//  UIView+FZMCMDevice.m
//  FZM_CMUI
//
//  Created by 33 on 2018/11/27.
//

#import "UIView+FZMCMDevice.h"

@implementation UIView (FZMCMDevice)


+ (CGFloat)cm_ScreenH{
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)cm_ScreenW{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (BOOL)cm_iPhoneXStyle{
    CGSize mainSize =  [UIScreen mainScreen].bounds.size;
    CGSize iPhoneXS = CGSizeMake(375.f, 812.f);
    CGSize iPhoneXSMax = CGSizeMake(414.f, 896.f);
    if (CGSizeEqualToSize(mainSize, iPhoneXS)) {
        return YES;
    }
    if (CGSizeEqualToSize(mainSize, iPhoneXSMax)) {
        return YES;
    }
    return NO;
}

+ (CGFloat)cm_bottomArea{
    if ([self cm_iPhoneXStyle]) {
        return 34.0;
    }
    return 0.0f;
}


+ (CGFloat)cm_ScreeRratio6S{
    return [self cm_ScreenW] / 375;
}

/*
 * 与iPhone X的屏幕尺寸做对比 宽高 0.46 : 1
 */
+ (CGFloat)cm_ScreenRatioX{
    return [self cm_ScreenW] / 812;
}

@end
