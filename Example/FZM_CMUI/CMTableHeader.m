//
//  CMTableHeader.m
//  FZM_CMUI_Example
//
//  Created by 33 on 2018/11/26.
//  Copyright © 2018年 2711056454@qq.com. All rights reserved.
//

#import "CMTableHeader.h"
#import "CMTableHeaderModel.h"
#import "FZMCMUITableHeaderFooterProtocol.h"

@interface CMTableHeader () <FZMCMUITableHeaderFooterProtocol>

@property (nonatomic, strong) UILabel *titleLab;

@end

@implementation CMTableHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLab];
        self.titleLab.frame = CGRectMake(20, 20, 100, 30);
    }
    return  self;
}


- (void)configHeaderFooterViewModel:(CMTableHeaderModel *)viewModel{
    
    _titleLab.text = viewModel.title;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont systemFontOfSize:6];
        lab.textColor = UIColor.blackColor;
        _titleLab = lab;
    }
    return _titleLab;
}
@end
