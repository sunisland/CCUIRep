//
//  FZMTableManager.h
//  Management
//
//  Created by 杜Arlen on 2018/8/24.
//  Copyright © 2018年 杜Arlen. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FZMCMUITableSection.h"

@interface FZMCMUITableManager : NSObject

//初始化的对象
+ (instancetype)managerWithTableView:(UITableView *)tableView;

- (instancetype)initWithTableView:(UITableView *)tableView;

@property (nonatomic, strong, readonly) NSMutableArray <FZMCMUITableSection *> *sections;


@property (nonatomic, copy) void(^didSelectRow)(UITableView *tableView,FZMCMUITableViewCellModel *cellModel);



/*
 *  cell必须遵守 FZMCMUITableCellProtocol 重要 !!!!!!!!!!
 * 注册cell
 */
- (void)registerCell:(NSString *)cellName cellModel:(NSString *)modelName;

/*
 * hearView 必须遵守FZMCMUITableHeaderFooterProtocol 重要 !!!!!!!!!!
 * 注册headerView
 */
- (void)registerSectionHeader:(NSString *)headerName headerModel:(NSString *)modelName;

/*
 * footerView 必须遵守 FZMCMUITableHeaderFooterProtocol 重要 !!!!!
 * 注册footerView
 */
- (void)registerSectionFooter:(NSString *)footerName footerModel:(NSString *)modelName;



//添加一个section
- (void)addSection:(FZMCMUITableSection *)tableSection;

//移除一个section
- (void)removeSection:(FZMCMUITableSection *)tableSection;

//插入一个CellModel
- (void)insertSection:(FZMCMUITableSection *)tableSection atIndex:(NSInteger)index;

//插入一个CellModel到另个一个CellModel上面
- (void)insertSection:(FZMCMUITableSection *)tableSection aboveTableSection:(FZMCMUITableSection *)siblingTableSection;

//插入一个CellModel到另个一个CellModel下面
- (void)insertSection:(FZMCMUITableSection *)tableSection belowTableSection:(FZMCMUITableSection *)siblingTableSection;


//替换所有的sections
- (void)replaceAllSections:(NSArray <FZMCMUITableSection *>*)tableSections;

@end
