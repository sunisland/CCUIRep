//
//  FZMCMUICollectonManager.h
//  FZM_CMUI
//
//  Created by 33 on 2018/12/4.
//

#import <UIKit/UIKit.h>
@class FZMCMUICollectionCellModel;
@class FZMCMUICollectionSection;


@interface FZMCMUICollectonManager : UICollectionViewCell

+ (instancetype)managerWithCollectionView:(UICollectionView *)collectionView;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

@property (nonatomic, strong, readonly) NSMutableArray <FZMCMUICollectionSection *> *sections;

@property (nonatomic, copy) void  (^didSelectRow) (UICollectionView * collectionView, FZMCMUICollectionCellModel *cellModel);

/*
 *  cell必须遵守 FZMCMUICollectionCellProtocol 重要 !!!!!!!!!!
 * 注册cell
 */
- (void)registerCell:(NSString *)cellName cellModel:(NSString *)modelName;

/*
 * hearView 必须遵守FZMCMUICollectionHeaderFooterProtocol 重要 !!!!!!!!!!
 * 注册headerView
 */
- (void)registerSectionHeader:(NSString *)headerName headerModel:(NSString *)modelName;

/*
 * footerView 必须遵守 FZMCMUICollectionHeaderFooterProtocol 重要 !!!!!
 * 注册footerView
 */
- (void)registerSectionFooter:(NSString *)footerName footerModel:(NSString *)modelName;


- (void)addSection:(FZMCMUICollectionSection *)section;

//移除一个section
- (void)removeSection:(FZMCMUICollectionSection *)section;

//插入一个CellModel
- (void)insertSection:(FZMCMUICollectionSection *)section atIndex:(NSInteger)index;

////插入一个section到另个一个section前面
- (void)insertSection:(FZMCMUICollectionSection *)section aboveSection:(FZMCMUICollectionSection *)siblingSection;

////插入一个section到另个一个section后面
- (void)insertSection:(FZMCMUICollectionSection *)section belowSection:(FZMCMUICollectionSection *)siblingSection;


//替换所有的sections
- (void)replaceAllSections:(NSArray <FZMCMUICollectionSection *>*)sections;
@end


