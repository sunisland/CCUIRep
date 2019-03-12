//
//  CMTableViewCell.m
//  FZM_CMUI_Example
//
//  Created by 33 on 2018/11/26.
//  Copyright © 2018年 2711056454@qq.com. All rights reserved.
//

#import "CMTableViewCell.h"
#import "CMTableCellModel.h"
#import "FZMCMUITableCellProtocol.h"
#import "UIControl+FZMCMTimerControl.h"

@interface CMTableViewCell () <FZMCMUITableCellProtocol>

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIView *separatorLine;

@property (nonatomic, strong) UIButton *btn;

@end

@implementation CMTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLab];
        self.titleLab.frame = CGRectMake(20, 20, 100, 30);
        
        UIView *line = UIView.new;
        line.backgroundColor = UIColor.lightGrayColor;
       
        self.separatorLine = line;
        [self.contentView addSubview:self.separatorLine];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"开始定时器" forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(toWithdraw:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(200, 0, 100, 30);
        [self addSubview:btn];
        self.btn = btn;
        
     
       
    }
    return self;
}



- (void)toWithdraw:(UIButton *)sender{
    [sender startTimerWithInterval:10 updateTitle:^(NSInteger interval, UIControl *btn) {
        [sender setTitle:[NSString stringWithFormat:@"已发送%d", (int)interval] forState:UIControlStateNormal];
    } timeout:^(UIControl *btn) {
        [sender setTitle:@"重新获取" forState:UIControlStateNormal];
    }];
//    NSLog(@"%@  interval %f", sender.cmTimer, sender.cmTimer.timeInterval);
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.separatorLine.frame = CGRectMake(10, self.frame.size.height - 0.5, self.frame.size.width- 20, 0.5);
}

- (void)configCellModel:(CMTableCellModel *)cellModel{
    self.titleLab.text = cellModel.title;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont systemFontOfSize:16];
        lab.textColor = UIColor.blackColor;

        _titleLab = lab;
    }
    return _titleLab;
}

@end
