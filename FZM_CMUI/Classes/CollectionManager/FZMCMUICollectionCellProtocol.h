//
//  FZMCMUICollectionCellProtocol.h
//  FZM_CMUI
//
//  Created by 33 on 2018/12/4.
//

#import <Foundation/Foundation.h>
@class FZMCMUICollectionCellModel;
NS_ASSUME_NONNULL_BEGIN

@protocol FZMCMUICollectionCellProtocol <NSObject>
- (void)configCellModel:(__kindof FZMCMUICollectionCellModel *)cellModel;
@end

NS_ASSUME_NONNULL_END
