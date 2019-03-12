//
//  FZMUITableViewCellModel.h
//  Management
//
//  Created by 杜Arlen on 2018/8/24.
//  Copyright © 2018年 杜Arlen. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface FZMCMUITableViewCellModel : NSObject

//是否隐藏
@property (nonatomic, assign) BOOL rowHidden;

//cellModel对应的indexPath
@property (nonatomic, strong) NSIndexPath *indexPath;

//下一个页面的URL
@property (nonatomic, strong) NSString *nextPageURL;   

//当需要对cell做修改时,通过这个设置, 默认使用section里定义的高度
@property (nonatomic, assign) CGFloat cellHeight;

//cellModel对应的Cell被选中时的回调
@property (nonatomic, copy) void(^selectedBlock)(__kindof FZMCMUITableViewCellModel *cellModel,NSIndexPath *indexPath);

//即将出现
@property (nonatomic, copy) void(^willDisplay)( __kindof UITableViewCell *cell,  FZMCMUITableViewCellModel *cellModel, NSIndexPath *indexPath);

//已经消失
@property (nonatomic, copy) void(^didEndDisplay)( __kindof UITableViewCell *cell,  FZMCMUITableViewCellModel *cellModel, NSIndexPath *indexPath);



@end
