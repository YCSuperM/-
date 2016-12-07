//
//  IntroduceView.m
//  详情界面
//
//  Created by 昊誉信息 on 16/10/10.
//  Copyright © 2016年 haoyu. All rights reserved.
//

#import "IntroduceView.h"
#import "IntroduceModel.h"
//第一个view，介绍内容

@interface IntroduceView ()
@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)UILabel *introduceLB;
@property(nonatomic,strong)UILabel *priceLB;
@property(nonatomic,strong)UILabel *originalPriceLB;
@property(nonatomic,strong)UIButton *collectionBtn;
@property(nonatomic,strong)UIButton *shareBtn;
@end
@implementation IntroduceView


-(instancetype)init{
    if (self = [super init]) {
        [self addSubviews];
    }
    return self;
}
-(void)addSubviews{
    [self addSubview:self.titleLB];
    [self addSubview:self.introduceLB];
    [self addSubview:self.priceLB];
    [self addSubview:self.originalPriceLB];
    [self addSubview:self.collectionBtn];
    [self addSubview:self.shareBtn];
    [self makeViewSize];
}
-(void)makeViewSize{
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(190, 30));
    }];
    [self.introduceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLB.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(kScreenW-40, 20));
    }];
    [self.priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.introduceLB.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    [self.originalPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.priceLB);
        make.left.equalTo(self.priceLB.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLB);
        make.right.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLB);
        make.right.equalTo(self.shareBtn.mas_left).offset(-10);
    }];
}
-(void)setModel:(IntroduceModel *)model{
    _model = model;
    self.titleLB.text = model.title;
    self.introduceLB.text = model.introduce;
    self.priceLB.text = model.price;
    self.originalPriceLB.text = model.originalPrice;
}
-(UILabel *)titleLB{
    if (!_titleLB) {
        _titleLB = [[UILabel alloc]init];
        _titleLB.textColor = [UIColor blackColor];
        _titleLB.font = [UIFont systemFontOfSize:17];
    }
    return _titleLB;
}
-(UILabel *)introduceLB{
    if (!_introduceLB) {
        _introduceLB = [[UILabel alloc]init];
        _introduceLB.textColor = [UIColor grayColor];
        _introduceLB.font = [UIFont systemFontOfSize:13];
    }
    return _introduceLB;
}
-(UILabel *)priceLB{
    if (!_priceLB) {
        _priceLB = [[UILabel alloc]init];
        _priceLB.textColor = [UIColor redColor];
        _priceLB.font = [UIFont systemFontOfSize:17];
    }
    return _priceLB;
}
-(UILabel *)originalPriceLB{
    if (!_originalPriceLB) {
        _originalPriceLB = [[UILabel alloc]init];
        _originalPriceLB.textColor = [UIColor grayColor];
        _originalPriceLB.font = [UIFont systemFontOfSize:13];
    }
    return _originalPriceLB;
}
-(UIButton *)collectionBtn{
    if (!_collectionBtn) {
        _collectionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_collectionBtn setTitle:@"星星" forState:UIControlStateNormal];
        _collectionBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_collectionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _collectionBtn;
}
-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _shareBtn;
}
@end
