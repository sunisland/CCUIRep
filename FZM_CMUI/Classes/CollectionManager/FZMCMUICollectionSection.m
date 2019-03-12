//
//  FZMCMUICollectionSection.m
//  FZM_CMUI
//
//  Created by 33 on 2018/12/4.
//

#import "FZMCMUICollectionSection.h"
#import "FZMCMUICollectionHeaderFooterViewModel.h"
#import "FZMCMUICollectionCellModel.h"

@implementation FZMCMUICollectionSection
+ (instancetype)section
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cellModes = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

//是否没有
- (BOOL)isNoRows
{
    for (FZMCMUICollectionCellModel *cellModel in self.cellModes) {
        if (cellModel.rowHidden == NO) {
            return NO;
        }
    }
    return YES;;
}



//添加一个cellModel
- (void)addCellModel:(__kindof FZMCMUICollectionCellModel *)cellModel
{
    [self.cellModes addObject:cellModel];
}

- (void)addCellModels:(NSArray <__kindof FZMCMUICollectionCellModel *> *)cellModels{
    if (!cellModels || cellModels.count == 0) {
        return;
    }
    [self.cellModes addObjectsFromArray:cellModels];
}

//移除一个CellModel
- (void)removeCellModel:(__kindof FZMCMUICollectionCellModel *)cellModel
{
    [self.cellModes removeObject:cellModel];
}

//插入一个CellModel
- (void)insertCellModel:(__kindof FZMCMUICollectionCellModel *)cellModel atIndex:(NSInteger)index
{
    [self.cellModes insertObject:cellModel atIndex:index];
}

//插入一个CellModel到另个一个CellModel上面
- (void)insertCellModel:(__kindof FZMCMUICollectionCellModel *)cellModel aboveCellModel:(__kindof FZMCMUICollectionCellModel *)siblingCellMode
{
    NSInteger index = [self.cellModes indexOfObject:siblingCellMode];
    [self.cellModes insertObject:cellModel atIndex:index];
}

//插入一个CellModel到另个一个CellModel下面
- (void)insertCellModel:(__kindof FZMCMUICollectionCellModel *)cellModel belowCellModel:(__kindof FZMCMUICollectionCellModel *)siblingCellMode
{
    NSInteger index = [self.cellModes indexOfObject:siblingCellMode];
    index += 1;
    [self.cellModes insertObject:cellModel atIndex:index];
}


//替换所有的cellModels
- (void)replaceAllCellModels:(NSArray <FZMCMUICollectionCellModel *> *)cellModes;
{
    [self.cellModes removeAllObjects];
    [self.cellModes addObjectsFromArray:cellModes];
}
@end
