//
//  FZMCMUICollectonManager.m
//  FZM_CMUI
//
//  Created by 33 on 2018/12/4.
//

#import "FZMCMUICollectonManager.h"
#import "FZMCMUICollectionCellModel.h"
#import "FZMCMUICollectionHeaderFooterViewModel.h"
#import "FZMCMUICollectionSection.h"
#import "FZMCMUICollectionCellProtocol.h"
#import "FZMCMUICollectionHeaderFooterProtocol.h"


@interface FZMCMUICollectonManager () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableDictionary *cellInfo;
@property (nonatomic, strong) NSMutableDictionary *headInfo;
@property (nonatomic, strong) NSMutableDictionary *footInfo;

@end

@implementation FZMCMUICollectonManager
+ (instancetype)managerWithCollectionView:(UICollectionView *)collectionView{
    return [[self alloc] initWithCollectionView:collectionView];
}

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView{
    self = [super init];
    if (self) {
        
        self.collectionView = collectionView;
        self.cellInfo   = [NSMutableDictionary dictionary];
        self.headInfo   = [NSMutableDictionary dictionary];
        self.footInfo   = [NSMutableDictionary dictionary];
        _sections = [NSMutableArray array];
        
        _collectionView.delegate      = self;
        _collectionView.dataSource    = self;
        NSLog(@"collection %@", _collectionView );
    }
    return self;
}


#pragma mark UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
     NSLog(@"collection count %d", _sections.count );
    return _sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    FZMCMUICollectionSection  *sections = [_sections objectAtIndex:section];
      NSLog(@"collection row %d", sections.cellModes.count );
    return sections.cellModes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FZMCMUICollectionSection  *sections = [_sections objectAtIndex:indexPath.section];
    FZMCMUICollectionCellModel *cellModel = [sections.cellModes objectAtIndex:indexPath.row];
    NSString *cellModelName = NSStringFromClass([cellModel class]);
    NSString *cellClassName = self.cellInfo[cellModelName];
    if (!cellClassName) {
        return nil;
    }
    UICollectionViewCell <FZMCMUICollectionCellProtocol>*cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellClassName forIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(configCellModel:)]) {
        [cell configCellModel:cellModel];
    }else{
        NSLog(@"***************  警告 %@没有实现FZMCMUITableCellProtocol 协议", cell);
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
     FZMCMUICollectionSection *section = [_sections objectAtIndex:indexPath.section];
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        if (section.headerViewModel == nil) {
            return nil;
        }
        
        NSString *headModelName = NSStringFromClass([section.headerViewModel class]);
        NSString *headClassNmae = self.headInfo[headModelName];
        if (!headClassNmae) {
            return nil;
        }
        
        UICollectionReusableView <FZMCMUICollectionHeaderFooterProtocol> *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headClassNmae forIndexPath:indexPath];
        if ([headView respondsToSelector:@selector(configHeaderFooterViewModel:)]) {
            [headView configHeaderFooterViewModel:section.headerViewModel];
        }else{
             NSLog(@"***************  警告 %@没有实现FZMCMUICollectionHeaderFooterProtocol 协议", headView);
        }
        
        
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        if (section.footerViewModel == nil) {
            return nil;
        }
        NSString *foodModelName = NSStringFromClass([section.footerViewModel class]);
        NSString *footClassNmae = self.footInfo[foodModelName];
        if (footClassNmae == nil)
        {
            return nil;
        }
        
        UICollectionReusableView <FZMCMUICollectionHeaderFooterProtocol> *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footClassNmae forIndexPath:indexPath];
        if ([footerView respondsToSelector:@selector(configHeaderFooterViewModel:)]) {
            [footerView configHeaderFooterViewModel:section.headerViewModel];
        }else{
            NSLog(@"***************  警告 %@没有实现FZMCMUICollectionHeaderFooterProtocol 协议", footerView);
        }
        
    }
    return nil;
}


// cell size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
     FZMCMUICollectionSection *section = [_sections objectAtIndex:indexPath.section];
     FZMCMUICollectionCellModel *cellModel = section.cellModes[indexPath.row];
    if (CGSizeEqualToSize(cellModel.cellSize, CGSizeZero)) {
        return section.cellSize;
    }
    return cellModel.cellSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    FZMCMUICollectionSection *sec = self.sections[section];
    FZMCMUICollectionHeaderFooterViewModel *headerViewModel = sec.headerViewModel;
    if (headerViewModel ==  nil) {
        return CGSizeZero;
    }
    return headerViewModel.headerFooterSize;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    FZMCMUICollectionSection *sec = self.sections[section];
    FZMCMUICollectionHeaderFooterViewModel *footerViewModel = sec.headerViewModel;
    if (footerViewModel ==  nil) {
        return CGSizeZero;
    }
    return footerViewModel.headerFooterSize;
    
}

// cell即将出现
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    FZMCMUICollectionSection *section = self.sections[indexPath.section];
    FZMCMUICollectionCellModel *cellModel = section.cellModes[indexPath.row];
    
    cellModel.indexPath = indexPath;
    
    if (cellModel.willDisplay) {
        cellModel.willDisplay(cell, cellModel, indexPath);
    }
}
// cell 已经消失
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    FZMCMUICollectionSection *section = self.sections[indexPath.section];
    FZMCMUICollectionCellModel *cellModel = section.cellModes[indexPath.row];
    
    cellModel.indexPath = indexPath;
    
    if (cellModel.didEndDisplay) {
        cellModel.didEndDisplay(cell, cellModel, indexPath);
    }
}



// head / footer 即将出现
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    
    FZMCMUICollectionSection *section = self.sections[indexPath.section];
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        FZMCMUICollectionHeaderFooterViewModel *headerViewModel = section.headerViewModel;
        if (headerViewModel == nil) {
            return;
        }
        UICollectionReusableView *headerView = (UICollectionReusableView *)view;
        if (headerViewModel.willDisplay) {
            headerViewModel.willDisplay(headerView, headerViewModel, indexPath.section);
        }
    }else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]){
        FZMCMUICollectionHeaderFooterViewModel *fooderViewModel = section.footerViewModel;
        if (fooderViewModel == nil) {
            return;
        }
        UICollectionReusableView *footerView = (UICollectionReusableView *)view;
        if (fooderViewModel.willDisplay) {
            fooderViewModel.willDisplay(footerView, fooderViewModel, indexPath.section);
        }
    }
}
// 消失
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    FZMCMUICollectionSection *section = self.sections[indexPath.section];
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        FZMCMUICollectionHeaderFooterViewModel *headerViewModel = section.headerViewModel;
        if (headerViewModel == nil) {
            return;
        }
        UICollectionReusableView *headerView = (UICollectionReusableView *)view;
        if (headerViewModel.didEndDisplay) {
            headerViewModel.didEndDisplay(headerView, headerViewModel, indexPath.section);
        }
    }else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]){
        FZMCMUICollectionHeaderFooterViewModel *fooderViewModel = section.footerViewModel;
        if (fooderViewModel == nil) {
            return;
        }
        UICollectionReusableView *footerView = (UICollectionReusableView *)view;
        if (fooderViewModel.didEndDisplay) {
            fooderViewModel.didEndDisplay(footerView, fooderViewModel, indexPath.section);
        }
    }
}

// 选中
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FZMCMUICollectionSection *section = self.sections[indexPath.section];
    FZMCMUICollectionCellModel *cellModel = section.cellModes[indexPath.row];
    if (cellModel.selectedBlock) {
        cellModel.selectedBlock(cellModel, indexPath);
    }
    if (self.didSelectRow) {
        self.didSelectRow(collectionView, cellModel);
    }
}




#pragma mark 注册   cell必须遵守 FZMCMUICollectionCellProtocol 重要 !!!!!!!!!!

- (void)registerCell:(NSString *)cellName cellModel:(NSString *)modelName{
    self.cellInfo[modelName] = cellName;
    [_collectionView registerClass:NSClassFromString(cellName) forCellWithReuseIdentifier:cellName];
}


// * hearView 必须遵守FZMCMUICollectionHeaderFooterProtocol 重要 !!!!!!!!!!

- (void)registerSectionHeader:(NSString *)headerName headerModel:(NSString *)modelName{
     self.headInfo[modelName] = headerName;
    [_collectionView registerClass:NSClassFromString(headerName) forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:modelName];
}


//* footerView 必须遵守 FZMCMUICollectionHeaderFooterProtocol 重要 !!!!!

- (void)registerSectionFooter:(NSString *)footerName footerModel:(NSString *)modelName{
   self.footInfo[modelName] = footerName;
    [_collectionView registerClass:NSClassFromString(footerName) forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:modelName];
}


- (void)addSection:(FZMCMUICollectionSection *)section{
     [self.sections addObject:section];
}

//移除一个section
- (void)removeSection:(FZMCMUICollectionSection *)section{
     [self.sections removeObject:section];
}

//插入一个CellModel
- (void)insertSection:(FZMCMUICollectionSection *)section atIndex:(NSInteger)index{
     [self.sections insertObject:section atIndex:index];
}

//插入一个section到另个一个section前面
- (void)insertSection:(FZMCMUICollectionSection *)section aboveSection:(FZMCMUICollectionSection *)siblingSection{
    NSInteger index = [self.sections indexOfObject:siblingSection];
    [self.sections insertObject:section atIndex:index];
}

//插入一个CellModel到另个一个CellModel下面
- (void)insertSection:(FZMCMUICollectionSection *)section belowSection:(FZMCMUICollectionSection *)siblingSection{
    NSInteger index = [self.sections indexOfObject:siblingSection];
    [self.sections insertObject:section atIndex:index];
}


//替换所有的sections
- (void)replaceAllSections:(NSArray <FZMCMUICollectionSection *>*)sections{
    [self.sections removeAllObjects];
    [self.sections addObjectsFromArray:sections];
    [_collectionView reloadData];
}
@end
