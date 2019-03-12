//
//  FZMCMUITableHeaderFooterProtocol.h
//  FZM_CMUI
//
//  Created by 33 on 2018/11/26.
//

#import <Foundation/Foundation.h>
@class FZMCMUITableHeaderFooterViewModel;

@protocol FZMCMUITableHeaderFooterProtocol <NSObject>


- (void)configHeaderFooterViewModel:(__kindof FZMCMUITableHeaderFooterViewModel *)viewModel;
@end


