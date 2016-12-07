//
//  ViewController.m
//  详情界面
//
//  Created by 昊誉信息 on 16/10/10.
//  Copyright © 2016年 haoyu. All rights reserved.
//

#import "ViewController.h"
#import "ImagesView.h"
#import "IntroduceView.h"
#import "IntroduceModel.h"
#import "BtnListView.h"
@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollview;
@property(nonatomic,strong)UIView *navBarView;
@property(nonatomic,strong)ImagesView *imageArrView;
@property(nonatomic,strong)IntroduceView *introduceView;
@property(nonatomic,strong)BtnListView  *btnlistView;
@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //去掉分割线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addSubView];
    [self.view addSubview:self.navBarView];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)addSubView{
    [self.view addSubview:self.scrollview];
    [self.scrollview addSubview:self.imageArrView];
    [self.scrollview addSubview:self.introduceView];
    [self.scrollview addSubview:self.btnlistView];
    
    [self.imageArrView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(0);
        make.height.mas_equalTo(imageH);
    }];
    [self.introduceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageArrView.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 150));
    }];
    [self.btnlistView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.introduceView.mas_bottom).offset(5);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 40));
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >0) {
        CGFloat alpha = MIN(1, offsetY/(imageH-64));
        self.navBarView.backgroundColor = BXAlphaColor(253, 171, 47, alpha);
    } else {
        self.navBarView.backgroundColor = BXAlphaColor(253, 171, 47, 0);
    }
    
}

-(UIScrollView *)scrollview{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _scrollview.delegate = self;
        _scrollview.backgroundColor = [UIColor grayColor];
        _scrollview.contentSize = CGSizeMake(kScreenW, 2*kScreenH);
    }
    return _scrollview;
}
-(ImagesView *)imageArrView{
    if (!_imageArrView) {
        _imageArrView = [[ImagesView alloc]init];
        _imageArrView.imageArr = @[@"img_01",@"img_02",@"img_03",@"img_04",@"img_05"];
    }
    return _imageArrView;
}
-(IntroduceView *)introduceView{
    if (!_introduceView) {
        _introduceView = [[IntroduceView alloc]init];
        _introduceView.backgroundColor = [UIColor whiteColor];
        IntroduceModel *model = [[IntroduceModel alloc]init];
        model.title = @"案例标题啊案例标题";
        model.introduce = @"标题简单描述";
        model.price = @"$5555";
        model.originalPrice = @"$5555";
        _introduceView.model = model;
    }
    return _introduceView;
}
-(BtnListView *)btnlistView{
    if (!_btnlistView) {
        _btnlistView = [[BtnListView alloc]init];
        _btnlistView.backgroundColor = [UIColor whiteColor];
    }
    return _btnlistView;
}
-(UIView *)navBarView{
    if (!_navBarView) {
        _navBarView = [[UIView alloc]init];
        _navBarView.frame = CGRectMake(0, 0, kScreenW, 64);
        _navBarView.backgroundColor = [UIColor clearColor];
    }
    return _navBarView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
