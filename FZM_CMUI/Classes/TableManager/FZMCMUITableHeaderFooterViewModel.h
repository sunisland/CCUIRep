//
//  FZMUITableHeaderFooterViewModel.h
//  Management
//
//  Created by 杜Arlen on 2018/8/24.
//  Copyright © 2018年 杜Arlen. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface FZMCMUITableHeaderFooterViewModel : NSObject

//是否隐藏
@property (nonatomic, assign) BOOL headerFooterHidden;

//高度
@property (nonatomic, assign) CGFloat headerFooterHeight;


//即将出现
@property (nonatomic, copy) void(^willDisplay)( __kindof UITableViewHeaderFooterView *view,  __kindof FZMCMUITableHeaderFooterViewModel *headerViewModel, NSInteger section);

//已经消失
@property (nonatomic, copy) void(^didEndDisplay)( __kindof UITableViewHeaderFooterView *view,  __kindof FZMCMUITableHeaderFooterViewModel *headerViewModel, NSInteger section);


@end
