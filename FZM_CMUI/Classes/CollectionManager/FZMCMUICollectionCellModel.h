//
//  FZMCMUICollectionCellModel.h
//  FZM_CMUI
//
//  Created by 33 on 2018/12/4.
//

#import <UIKit/UIKit.h>



@interface FZMCMUICollectionCellModel : NSObject
//是否隐藏
@property (nonatomic, assign) BOOL rowHidden;

//cellModel对应的indexPath
@property (nonatomic, strong) NSIndexPath *indexPath;

//当需要对cell做修改时,通过这个设置, 默认使用section里定义的高度
@property (nonatomic, assign) CGSize cellSize;

//cellModel对应的Cell被选中时的回调
@property (nonatomic, copy) void(^selectedBlock)(__kindof FZMCMUICollectionCellModel *cellModel,NSIndexPath *indexPath);

//即将出现
@property (nonatomic, copy) void(^willDisplay)( __kindof UICollectionViewCell *cell,  FZMCMUICollectionCellModel *cellModel, NSIndexPath *indexPath);


//已经消失
@property (nonatomic, copy) void(^didEndDisplay)( __kindof UICollectionViewCell *cell,  FZMCMUICollectionCellModel *cellModel, NSIndexPath *indexPath);
@end


