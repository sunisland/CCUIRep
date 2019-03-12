//
//  FZMTableSection.h
//  Management
//
//  Created by 杜Arlen on 2018/8/24.
//  Copyright © 2018年 杜Arlen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FZMCMUITableViewCellModel.h"
#import "FZMCMUITableHeaderFooterViewModel.h"

@interface FZMCMUITableSection : NSObject

+ (instancetype)section;

//sectionHeaderView的viewModel
@property (nonatomic, strong) __kindof FZMCMUITableHeaderFooterViewModel *headerViewModel;

//sectionFooterView的viewModel
@property (nonatomic, strong) __kindof FZMCMUITableHeaderFooterViewModel *footerViewModel;

//当前区所有的cellViewModels
@property (nonatomic, strong, readonly) NSMutableArray <__kindof FZMCMUITableViewCellModel *>*cellModes;

//当没有Row的时候隐藏HeaderView
@property (nonatomic, assign) BOOL hiddenHeaderViewWhenNoRows;

//当没有Row的时候隐藏FooterView
@property (nonatomic, assign) BOOL hiddenFooterViewWhenNoRows;

//当没有headerview的时候HeaderView的高度
@property (nonatomic, assign) CGFloat heightForHeaderViewWhenNoHeaderView;

//当没有footerview的时候footer的高度
@property (nonatomic, assign) CGFloat heightForFooterViewWhenNoFooterView;

// 如果cellModel里没有设置cellHeight, 将会使用个高度
@property (nonatomic, assign) CGFloat cellHeight;

//是否没有row
- (BOOL)isNoRows;


//tableView
@property (nonatomic, weak) UITableView *tableView;

//添加一个cellModel
- (void)addCellModel:(__kindof FZMCMUITableViewCellModel *)cellModel;
// 添加多个cellModel
- (void)addCellModels:(NSArray <__kindof FZMCMUITableViewCellModel *> *)cellModels;

//移除一个CellModel
- (void)removeCellModel:(__kindof FZMCMUITableViewCellModel *)cellModel;

//插入一个CellModel
- (void)insertCellModel:(__kindof FZMCMUITableViewCellModel *)cellModel atIndex:(NSInteger)index;

//插入一个CellModel到另个一个CellModel上面
- (void)insertCellModel:(__kindof FZMCMUITableViewCellModel *)cellModel aboveCellModel:(__kindof FZMCMUITableViewCellModel *)siblingCellMode;

//插入一个CellModel到另个一个CellModel下面
- (void)insertCellModel:(__kindof FZMCMUITableViewCellModel *)cellModel belowCellModel:(__kindof FZMCMUITableViewCellModel *)siblingCellMode;

//替换所有的cellModels
- (void)replaceAllCellModels:(NSArray <FZMCMUITableViewCellModel *> *)cellModes;

@end











