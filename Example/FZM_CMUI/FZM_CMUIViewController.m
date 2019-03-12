//
//  FZM_CMUIViewController.m
//  FZM_CMUI
//
//  Created by 2711056454@qq.com on 11/26/2018.
//  Copyright (c) 2018 2711056454@qq.com. All rights reserved.
//

#import "FZM_CMUIViewController.h"
#import "FZMCMTableManager.h"
#import "CMTableViewCell.h"
#import "CMTableCellModel.h"
#import "CMTableHeader.h"
#import "CMTableHeaderModel.h"

#import "SectionViewController.h"


@interface FZM_CMUIViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FZMCMUITableManager * manager;
@end

@implementation FZM_CMUIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.manager = [[FZMCMUITableManager alloc] initWithTableView:self.tableView];
    [_manager registerCell:@"CMTableViewCell" cellModel:@"CMTableCellModel"];
    [_manager registerSectionHeader:@"CMTableHeader" headerModel:@"CMTableHeaderModel"];
    [self configModel];
}





- (void)configModel{
    
    NSMutableArray *cellAry1 = [NSMutableArray arrayWithCapacity:20];
    for (int i = 0; i < 10 ; i++) {
        CMTableCellModel *model = [CMTableCellModel new];
        if (i == 6) {
            model.cellHeight = 77;
            model.title = [NSString stringWithFormat:@"%d 行高单独指定", i];
        }else{
            model.title = [NSString stringWithFormat:@"%d", i];
        }
        
        __weak typeof (self)weakSelf = self;
        [model setSelectedBlock:^(__kindof CMTableCellModel *cellModel, NSIndexPath *indexPath) {
            SectionViewController *vc = [SectionViewController new];
            [weakSelf.navigationController pushViewController:vc animated:YES];
            NSLog(@"%@ 点击了", cellModel.title);
        }];
        [cellAry1 addObject:model];
    }
    
    FZMCMUITableSection *section1 =  [FZMCMUITableSection new];
    [section1 addCellModels:cellAry1];
    section1.cellHeight = 44;
    CMTableHeaderModel *model1 = [CMTableHeaderModel new];
    model1.title = @"第一组title";
    section1.headerViewModel = model1;
    
    
    NSMutableArray *cellAry2 = [NSMutableArray arrayWithCapacity:20];
    for (int i = 10; i < 20 ; i++) {
        CMTableCellModel *model = [CMTableCellModel new];
        model.title = [NSString stringWithFormat:@"%d", i];
        [model setSelectedBlock:^(__kindof CMTableCellModel *cellModel, NSIndexPath *indexPath) {
            NSLog(@"%@ 点击了", cellModel.title);
        }];
        [cellAry2 addObject:model];
    }
    
    FZMCMUITableSection *section2 =  [FZMCMUITableSection new];
    [section2 addCellModels:cellAry2];
    CMTableHeaderModel *model2 = [CMTableHeaderModel new];
    section2.cellHeight = 66;
    model2.title = @"第二组title";
    section2.headerViewModel = model2;
    
    [_manager addSection:section1];
    [_manager addSection:section2];
    
}



- (UITableView *)tableView{
    if (!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight =0;
        _tableView.estimatedSectionHeaderHeight =0;
        _tableView.estimatedSectionFooterHeight =0;
        _tableView.showsVerticalScrollIndicator = NO;
        
    }
    return _tableView;
}



@end
