//
//  FZMTableSection.m
//  Management
//
//  Created by 杜Arlen on 2018/8/24.
//  Copyright © 2018年 杜Arlen. All rights reserved.
//

#import "FZMCMUITableSection.h"


@implementation FZMCMUITableSection

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
    for (FZMCMUITableViewCellModel *cellModel in self.cellModes) {
        if (cellModel.rowHidden == NO) {
            return NO;
        }
    }
    return YES;;
}


//添加一个cellModel
- (void)addCellModel:(__kindof FZMCMUITableViewCellModel *)cellModel
{
    [self.cellModes addObject:cellModel];
}

- (void)addCellModels:(NSArray <__kindof FZMCMUITableViewCellModel *> *)cellModels{
    if (!cellModels || cellModels.count == 0) {
        return;
    }
    [self.cellModes addObjectsFromArray:cellModels];
}

//移除一个CellModel
- (void)removeCellModel:(__kindof FZMCMUITableViewCellModel *)cellModel
{
    [self.cellModes removeObject:cellModel];
}

//插入一个CellModel
- (void)insertCellModel:(__kindof FZMCMUITableViewCellModel *)cellModel atIndex:(NSInteger)index
{
    [self.cellModes insertObject:cellModel atIndex:index];
}

//插入一个CellModel到另个一个CellModel上面
- (void)insertCellModel:(__kindof FZMCMUITableViewCellModel *)cellModel aboveCellModel:(__kindof FZMCMUITableViewCellModel *)siblingCellMode
{
    NSInteger index = [self.cellModes indexOfObject:siblingCellMode];
    [self.cellModes insertObject:cellModel atIndex:index];
}

//插入一个CellModel到另个一个CellModel下面
- (void)insertCellModel:(__kindof FZMCMUITableViewCellModel *)cellModel belowCellModel:(__kindof FZMCMUITableViewCellModel *)siblingCellMode
{
    NSInteger index = [self.cellModes indexOfObject:siblingCellMode];
    index += 1;
    [self.cellModes insertObject:cellModel atIndex:index];
}


//替换所有的cellModels
- (void)replaceAllCellModels:(NSArray <FZMCMUITableViewCellModel *> *)cellModes;
{
    [self.cellModes removeAllObjects];
    [self.cellModes addObjectsFromArray:cellModes];
}


@end







