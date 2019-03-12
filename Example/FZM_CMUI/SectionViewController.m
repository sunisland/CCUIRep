//
//  SectionViewController.m
//  FZM_CMUI_Example
//
//  Created by 33 on 2018/12/4.
//  Copyright © 2018年 2711056454@qq.com. All rights reserved.
//

#import "SectionViewController.h"
#import "FZMCMCollectionManager.h"
#import "FZM_CMUICollecionCellModel.h"
#import "CMCollecionViewCell.h"


@interface SectionViewController ()
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) FZMCMUICollectonManager *manager;
@end

@implementation SectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    
    self.manager = [FZMCMUICollectonManager managerWithCollectionView:self.collectionView];
    [_manager registerCell:@"CMCollecionViewCell" cellModel:@"FZM_CMUICollecionCellModel"];
    
    FZMCMUICollectionSection *section = [FZMCMUICollectionSection section];
    section.cellSize = CGSizeMake(100, 100);
    FZM_CMUICollecionCellModel *model = [FZM_CMUICollecionCellModel new];
    [model setSelectedBlock:^(__kindof FZMCMUICollectionCellModel *cellModel, NSIndexPath *indexPath) {
        NSLog(@"collection cell 点击了");
    }];
    FZM_CMUICollecionCellModel *model2 = [FZM_CMUICollecionCellModel new];
    FZM_CMUICollecionCellModel *model3 = [FZM_CMUICollecionCellModel new];
    FZM_CMUICollecionCellModel *model4 = [FZM_CMUICollecionCellModel new];
    [section addCellModels:@[model, model2, model3, model4]];
    [_manager addSection:section];
    [self.collectionView reloadData];
    
    
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        view.showsHorizontalScrollIndicator = NO;
        view.pagingEnabled = YES;
        _collectionView = view;
      
        
    }
    return _collectionView;
}



@end
