//
//  FZMCMUITableCellProtocol.h
//  FZM_CMUI
//
//  Created by 33 on 2018/11/26.
//

#import <Foundation/Foundation.h>

@class FZMCMUITableViewCellModel;

@protocol FZMCMUITableCellProtocol <NSObject>
- (void)configCellModel:(__kindof FZMCMUITableViewCellModel *)cellModel;
@end


