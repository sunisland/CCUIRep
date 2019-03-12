//
//  FZMTableManager.m
//  Management
//
//  Created by 杜Arlen on 2018/8/24.
//  Copyright © 2018年 杜Arlen. All rights reserved.
//

#import "FZMCMUITableManager.h"
//#import "FZMCMUITableViewCell.h"
//#import "FZMCMUITableHeaderFooterView.h"
#import "FZMCMUITableCellProtocol.h"
#import "FZMCMUITableHeaderFooterProtocol.h"

@interface FZMCMUITableManager () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *cellInfo;
@property (nonatomic, strong) NSMutableDictionary *headInfo;
@property (nonatomic, strong) NSMutableDictionary *footInfo;

@end

@implementation FZMCMUITableManager

+ (instancetype)managerWithTableView:(UITableView *)tableView {
    return [[self alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView
{
    self = [super init];
    if (self) {
        self.tableView  = tableView;

        self.cellInfo   = [NSMutableDictionary dictionary];
        self.headInfo   = [NSMutableDictionary dictionary];
        self.footInfo   = [NSMutableDictionary dictionary];
        _sections = [NSMutableArray array];
        
        tableView.delegate      = self;
        tableView.dataSource    = self;
    }
    return self;
}

#pragma mark  注册Cell、headerView、FooterView
- (void)registerCell:(NSString *)cellName cellModel:(NSString *)modelName
{
    self.cellInfo[modelName] = cellName;
    [self.tableView registerClass:NSClassFromString(cellName) forCellReuseIdentifier:cellName];
}
- (void)registerSectionHeader:(NSString *)headerName headerModel:(NSString *)modelName
{
    self.headInfo[modelName] = headerName;
    [self.tableView registerClass:NSClassFromString(headerName) forHeaderFooterViewReuseIdentifier:headerName];
}
- (void)registerSectionFooter:(NSString *)footerName footerModel:(NSString *)modelName
{
    self.footInfo[modelName] = footerName;
    [self.tableView registerClass:NSClassFromString(footerName) forHeaderFooterViewReuseIdentifier:footerName];
}

#pragma mark  number

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FZMCMUITableSection *tableSection = self.sections[section];
    return tableSection.cellModes.count;
}


#pragma mark  HeaderHeight、CellHeight、FooterHeight

//设置Header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    FZMCMUITableSection *tableSection = self.sections[section];
    if (tableSection.headerViewModel == nil) {
        return tableSection.heightForHeaderViewWhenNoHeaderView;
    }
    
    if (tableSection.hiddenHeaderViewWhenNoRows) {
        if ([tableSection isNoRows]) {
            return 0;
        }
    }
    FZMCMUITableHeaderFooterViewModel *headerViewModel = tableSection.headerViewModel;
    return headerViewModel.headerFooterHeight;
}

//设置Cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FZMCMUITableSection *tableSection = self.sections[indexPath.section];
    FZMCMUITableViewCellModel *cellModel = tableSection.cellModes[indexPath.row];
    if (cellModel.rowHidden == YES) return 0;
    if (cellModel.cellHeight < 0) {
        return tableSection.cellHeight;
    }
    return cellModel.cellHeight;
}

//设置Footer的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    FZMCMUITableSection *tableSection = self.sections[section];
    if (tableSection.footerViewModel == nil) {
        return tableSection.heightForFooterViewWhenNoFooterView;
    }
    
    if (tableSection.hiddenFooterViewWhenNoRows) {
        if ([tableSection isNoRows]) {
            return 0;
        }
    }
    FZMCMUITableHeaderFooterViewModel *footerViewModel = tableSection.footerViewModel;
    return footerViewModel.headerFooterHeight;
}


#pragma mark  HeaderView、Cell、FooterView

//设置HeaderView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FZMCMUITableSection *tableSection = self.sections[section];
    FZMCMUITableHeaderFooterViewModel *headerViewModel = tableSection.headerViewModel;
    if (headerViewModel == nil)
    {
        return nil;
    }
    NSString *headModelName = NSStringFromClass([headerViewModel class]);
    NSString *headClassNmae = self.headInfo[headModelName];
    if (!headClassNmae) {
        return nil;
    }
    UITableViewHeaderFooterView <FZMCMUITableHeaderFooterProtocol>*sectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headClassNmae];
    if ([sectionHeaderView respondsToSelector:@selector(configHeaderFooterViewModel:)]) {
        [sectionHeaderView configHeaderFooterViewModel:headerViewModel];
    }else{
        NSLog(@"***************  警告 %@没有实现FZMCMUITableHeaderFooterProtocol 协议", sectionHeaderView);
    }
    
    return sectionHeaderView;
}

//设置TableViewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FZMCMUITableSection *tableSection = self.sections[indexPath.section];
    FZMCMUITableViewCellModel *cellModel = tableSection.cellModes[indexPath.row];
    NSString *cellModelName = NSStringFromClass([cellModel class]);
    NSString *cellClassName = self.cellInfo[cellModelName];
    if (!cellClassName) {
        return nil;
    }
    UITableViewCell <FZMCMUITableCellProtocol>*cell = [tableView dequeueReusableCellWithIdentifier:cellClassName forIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(configCellModel:)]) {
          [cell configCellModel:cellModel];
    }else{
        NSLog(@"***************  警告 %@没有实现FZMCMUITableCellProtocol 协议", cell);
    }
  
    return cell;
}

//设置FooterView
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    FZMCMUITableSection *tableSection = self.sections[section];
    FZMCMUITableHeaderFooterViewModel *sectionFooterViewModel = tableSection.footerViewModel;
    if (sectionFooterViewModel == nil)
    {
        return nil;
    }
    NSString *footModelName = NSStringFromClass([sectionFooterViewModel class]);
    NSString *footClassNmae = self.footInfo[footModelName];
    if (footClassNmae == nil)
    {
        return nil;
    }
    
    UITableViewHeaderFooterView <FZMCMUITableHeaderFooterProtocol>*sectionFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footClassNmae];
    if ([sectionFooterView respondsToSelector:@selector(configHeaderFooterViewModel:)]) {
        [sectionFooterView configHeaderFooterViewModel:sectionFooterViewModel];
    }else{
        NSLog(@"***************  警告 %@没有实现FZMCMUITableHeaderFooterProtocol 协议", sectionFooterView);
    }
//    [sectionFooterView configHeaderFooterViewModel:sectionFooterViewModel];
    return sectionFooterView;
}

#pragma mark  willDisplay
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    FZMCMUITableSection *tableSection = self.sections[indexPath.section];
    FZMCMUITableViewCellModel *cellModel = tableSection.cellModes[indexPath.row];
    
    cellModel.indexPath = indexPath;
    
    if (cellModel.willDisplay) {
        cellModel.willDisplay(cell, cellModel, indexPath);
    }
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    
    if (self.sections.count == 0 ||self.sections.count <= section) {
        return;
    }
    FZMCMUITableSection *tableSection = self.sections[section];
    FZMCMUITableHeaderFooterViewModel *headerViewModel = tableSection.headerViewModel;
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)view;
    if (headerViewModel.willDisplay) {
        headerViewModel.willDisplay(headerView, headerViewModel, section);
    }
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    
    if (self.sections.count == 0 ||self.sections.count <= section) {
        return;
    }
    FZMCMUITableSection *tableSection = self.sections[section];
    FZMCMUITableHeaderFooterViewModel *footerViewModel = tableSection.footerViewModel;
    UITableViewHeaderFooterView *footerView = (UITableViewHeaderFooterView *)view;
    if (footerViewModel.willDisplay) {
        footerViewModel.willDisplay(footerView, footerViewModel, section);
    }
}

#pragma mark  didEndDisplay

//CellView已经消失
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (self.sections.count == 0 ||self.sections.count <= indexPath.section) {
        return;
    }
    FZMCMUITableSection *tableSection = self.sections[indexPath.section];
    if (tableSection.cellModes.count == 0 ||tableSection.cellModes.count <= indexPath.row) {
        return;
    }
    FZMCMUITableViewCellModel *cellModel = tableSection.cellModes[indexPath.row];
//    FZMCMUITableViewCell *tableCell = (FZMCMUITableViewCell *)cell;
    
    cellModel.indexPath = nil;
    
    if (cellModel.didEndDisplay) {
        cellModel.didEndDisplay(cell, cellModel, indexPath);
    }
}

//HeaderView已经消失
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    
    
    if (self.sections.count == 0 ||self.sections.count <= section) {
        return;
    }
    FZMCMUITableSection *tableSection = self.sections[section];
    
    FZMCMUITableHeaderFooterViewModel *headerViewModel = tableSection.headerViewModel;
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)view;
    if (headerViewModel.didEndDisplay) {
        headerViewModel.didEndDisplay(headerView, headerViewModel, section);
    }
}

//FooterView已经消失
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section
{
    if (self.sections.count == 0 ||self.sections.count <= section) {
        return;
    }
    FZMCMUITableSection *tableSection = self.sections[section];
    FZMCMUITableHeaderFooterViewModel *footerViewModel = tableSection.footerViewModel;
    UITableViewHeaderFooterView *footerView = (UITableViewHeaderFooterView *)view;
    if (footerViewModel.didEndDisplay) {
        footerViewModel.didEndDisplay(footerView, footerViewModel, section);
    }
}


#pragma mark  选中Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FZMCMUITableSection *section = self.sections[indexPath.section];
    FZMCMUITableViewCellModel *cellModel = section.cellModes[indexPath.row];
    
    if (cellModel.selectedBlock) {
        cellModel.selectedBlock(cellModel, indexPath);
    }
    
    if (self.didSelectRow) {
        self.didSelectRow(tableView, cellModel);
    }
}


#pragma mark  public

//添加一个section
- (void)addSection:(FZMCMUITableSection *)tableSection
{
    [self.sections addObject:tableSection];
}

//移除一个section
- (void)removeSection:(FZMCMUITableSection *)tableSection
{
    [self.sections removeObject:tableSection];
}

//插入一个CellModel
- (void)insertSection:(FZMCMUITableSection *)tableSection atIndex:(NSInteger)index
{
    [self.sections insertObject:tableSection atIndex:index];
}

//插入一个CellModel到另个一个CellModel上面
- (void)insertSection:(FZMCMUITableSection *)tableSection aboveTableSection:(FZMCMUITableSection *)siblingTableSection
{
    NSInteger index = [self.sections indexOfObject:siblingTableSection];
    [self.sections insertObject:tableSection atIndex:index];
}

//插入一个CellModel到另个一个CellModel下面
- (void)insertSection:(FZMCMUITableSection *)tableSection belowTableSection:(FZMCMUITableSection *)siblingTableSection
{
    NSInteger index = [self.sections indexOfObject:siblingTableSection];
    [self.sections insertObject:tableSection atIndex:index + 1];

}


//替换所有的sections
- (void)replaceAllSections:(NSArray <FZMCMUITableSection *>*)tableSections
{
    [self.sections removeAllObjects];
    [self.sections addObjectsFromArray:tableSections];
    [self.tableView reloadData];
}

@end






























