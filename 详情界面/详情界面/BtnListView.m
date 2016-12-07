//
//  BtnListView.m
//  详情界面
//
//  Created by 昊誉信息 on 16/10/10.
//  Copyright © 2016年 haoyu. All rights reserved.
//

#import "BtnListView.h"


@implementation BtnListView
-(instancetype)init{
    if (self = [super init]) {
        [self addSubviews];
    }
    return self;
}
-(void)addSubviews{
    NSArray *arr = @[@"商品详情",@"参数",@"用户评价"];
    for (NSInteger i=0; i<arr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(i*kScreenW/3, 10, kScreenW/3, 20);
        btn.tag = i;
        if (i==0) {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}
-(void)btn:(UIButton *)btn{
    for (UIButton *btn in self.subviews) {
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}
@end
