//
//  FZMCMUICollectionSection.h
//  FZM_CMUI
//
//  Created by 33 on 2018/12/4.
//

#import <Foundation/Foundation.h>
@class FZMCMUICollectionHeaderFooterViewModel;
@class FZMCMUICollectionCellModel;


@interface FZMCMUICollectionSection : NSObject

+ (instancetype)section;

//sectionHeaderView的viewModel
@property (nonatomic, strong) __kindof FZMCMUICollectionHeaderFooterViewModel *headerViewModel;

//sectionFooterView的viewModel
@property (nonatomic, strong) __kindof FZMCMUICollectionHeaderFooterViewModel *footerViewModel;

//当前区所有的cellViewModels
@property (nonatomic, strong, readonly) NSMutableArray <__kindof FZMCMUICollectionCellModel *>*cellModes;

//当没有Row的时候隐藏HeaderView
@property (nonatomic, assign) BOOL hiddenHeaderViewWhenNoRows;

//当没有Row的时候隐藏FooterView
@property (nonatomic, assign) BOOL hiddenFooterViewWhenNoRows;

//当没有headerview的时候HeaderView的高度
@property (nonatomic, assign) CGFloat heightForHeaderViewWhenNoHeaderView;

//当没有footerview的时候footer的高度
@property (nonatomic, assign) CGFloat heightForFooterViewWhenNoFooterView;

// 如果cellModel里没有设置cellSize, 将会使用个高度
@property (nonatomic, assign) CGSize cellSize;

//是否没有row
- (BOOL)isNoRows;

//tableView
@property (nonatomic, weak) UITableView *tableView;



//添加一个cellModel
- (void)addCellModel:(__kindof FZMCMUICollectionCellModel *)cellModel;
// 添加多个cellModel
- (void)addCellModels:(NSArray <__kindof FZMCMUICollectionCellModel *> *)cellModels;

//移除一个CellModel
- (void)removeCellModel:(__kindof FZMCMUICollectionCellModel *)cellModel;

//插入一个CellModel
- (void)insertCellModel:(__kindof FZMCMUICollectionCellModel *)cellModel atIndex:(NSInteger)index;

//插入一个CellModel到另个一个CellModel上面
- (void)insertCellModel:(__kindof FZMCMUICollectionCellModel *)cellModel aboveCellModel:(__kindof FZMCMUICollectionCellModel *)siblingCellMode;

//插入一个CellModel到另个一个CellModel下面
- (void)insertCellModel:(__kindof FZMCMUICollectionCellModel *)cellModel belowCellModel:(__kindof FZMCMUICollectionCellModel *)siblingCellMode;

//替换所有的cellModels
- (void)replaceAllCellModels:(NSArray <FZMCMUICollectionCellModel *> *)cellModes;
@end


