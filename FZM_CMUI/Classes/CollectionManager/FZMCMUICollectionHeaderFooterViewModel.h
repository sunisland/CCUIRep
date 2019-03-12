//
//  FZMCMUICollectionHeaderFooterViewModel.h
//  FZM_CMUI
//
//  Created by 33 on 2018/12/4.
//

#import <UIKit/UIKit.h>



@interface FZMCMUICollectionHeaderFooterViewModel : NSObject
//是否隐藏
@property (nonatomic, assign) BOOL headerFooterHidden;

//高度
@property (nonatomic, assign) CGSize headerFooterSize;


//即将出现
@property (nonatomic, copy) void(^willDisplay)( __kindof UICollectionReusableView *view,  __kindof FZMCMUICollectionHeaderFooterViewModel *headerViewModel, NSInteger section);

//已经消失
@property (nonatomic, copy) void(^didEndDisplay)( __kindof UICollectionReusableView *view,  __kindof FZMCMUICollectionHeaderFooterViewModel *headerViewModel, NSInteger section);
@end

