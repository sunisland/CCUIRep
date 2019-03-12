//
//  FZMCMUICollectionHeaderFooterProtocol.h
//  FZM_CMUI
//
//  Created by 33 on 2018/12/4.
//

#import <Foundation/Foundation.h>
@class FZMCMUICollectionHeaderFooterViewModel;


@protocol FZMCMUICollectionHeaderFooterProtocol <NSObject>


- (void)configHeaderFooterViewModel:(__kindof FZMCMUICollectionHeaderFooterViewModel *)viewModel;
@end


