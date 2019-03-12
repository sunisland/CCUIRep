//
//  UIControl+FZMCMTimerControl.h
//  FZM_CMUI
//
//  Created by fuzamei on 2019/1/7.
//

#import <UIKit/UIKit.h>



@interface UIControl (FZMCMTimerControl)
@property (nonatomic, strong) NSTimer *cmTimer;

- (void)startTimerWithInterval:(NSTimeInterval)interval  updateTitle:(void (^) (NSInteger interval, UIControl * btn))update  timeout:(void (^) (UIControl *))timeout;
@end


