//
//  UIView+FZMCMDevice.h
//  FZM_CMUI
//
//  Created by 33 on 2018/11/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FZMCMDevice)


+ (CGFloat)cm_ScreenH;

+ (CGFloat)cm_ScreenW;

/*
 *  是否是iPhoneX 类型的全面屏
 */
+ (BOOL)cm_iPhoneXStyle;

/*
 * 底部的安全区域高度
 */
+ (CGFloat)cm_bottomArea;

/*
 * 与6s的屏幕尺寸对比 0.56 : 1
 */
+ (CGFloat)cm_ScreeRratio6S;

/*
 * 与iPhone X的屏幕尺寸做对比 宽高 0.46 : 1
 */
+ (CGFloat)cm_ScreenRatioX;
@end

NS_ASSUME_NONNULL_END
