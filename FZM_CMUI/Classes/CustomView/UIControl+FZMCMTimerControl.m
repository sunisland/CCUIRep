//
//  UIControl+FZMCMTimerControl.m
//  FZM_CMUI
//
//  Created by fuzamei on 2019/1/7.
//

#import "UIControl+FZMCMTimerControl.h"

#import <objc/runtime.h>

static NSString *const  KFZMCMTimerControlTimer = @"KFZMCMTimerControlTimer";
static NSString *const  KFZMCMTimerControlInterval = @"KFZMCMTimerControlInterval";
static NSString *const  KFZMCMTimerControlTimeoutBlock = @"KFZMCMTimerControlTimeoutBlock";
static NSString *const  KFZMCMTimerControlUpdateBlock = @"KFZMCMTimerControlUpdateBlock";

@interface UIControl ()

@property (nonatomic, strong) NSNumber  *interval;

@property (nonatomic, strong) void (^timeout) (UIControl *btn);

@property (nonatomic, strong) void (^updateTitle) (NSInteger interval, UIControl * btn);
@end


@implementation UIControl (FZMCMTimerControl)

- (void)setCmTimer:(NSTimer *)cmTimer{
    objc_setAssociatedObject(self, &KFZMCMTimerControlTimer, cmTimer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



- (NSTimer *)cmTimer{
     return objc_getAssociatedObject(self, &KFZMCMTimerControlTimer);
}

- (void)setInterval:(NSNumber *)interval{
    objc_setAssociatedObject(self, &KFZMCMTimerControlInterval, interval, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)interval{
    return objc_getAssociatedObject(self, &KFZMCMTimerControlInterval);
}


- (void)setTimeout:(void (^)(UIControl *))timeout{
    objc_setAssociatedObject(self, &KFZMCMTimerControlTimeoutBlock, timeout, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(UIControl *))timeout{
    return  objc_getAssociatedObject(self, &KFZMCMTimerControlTimeoutBlock);
}


- (void)setUpdateTitle:(void (^)(NSInteger, UIControl *))updateTitle{
    
    objc_setAssociatedObject(self, &KFZMCMTimerControlUpdateBlock, updateTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(NSInteger, UIControl *))updateTitle{
    
    return  objc_getAssociatedObject(self, &KFZMCMTimerControlUpdateBlock);
}

- (void)startTimerWithInterval:(NSTimeInterval)interval  updateTitle:(void (^) (NSInteger interval, UIControl * btn))update  timeout:(void (^) (UIControl *))timeout{
    self.interval = @(interval);
    self.timeout =  timeout;
    self.updateTitle = update;
    self.cmTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTitleSel) userInfo:nil repeats:YES];

}

- (void)updateTitleSel{
    //    self.interval = @(self.interval.integerValue--);
    NSInteger interval = self.interval.integerValue;
    interval--;
    if (interval == 0) {
        if (self.timeout) {
            self.timeout(self);
        }
        [self.cmTimer invalidate];
        self.timeout = nil;
        self.updateTitle = nil;
        return;
    }
    
    if (self.updateTitle) {
        self.updateTitle(interval, self);
    }
    
    self.interval = @(interval);
}

@end
