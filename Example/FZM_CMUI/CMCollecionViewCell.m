//
//  CMCollecionViewCell.m
//  FZM_CMUI_Example
//
//  Created by 33 on 2018/12/4.
//  Copyright © 2018年 2711056454@qq.com. All rights reserved.
//

#import "CMCollecionViewCell.h"
#import "FZMCMUICollectionCellProtocol.h"


@interface CMCollecionViewCell ()

@property (nonatomic, strong) UIButton *btn;
@end


@implementation CMCollecionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =  [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        
      
        
        
    }
    return self;
}





- (void)configCellModel:(__kindof FZMCMUICollectionCellModel *)cellModel{
    
}
@end
