//
//  ViewController.m
//  卡牌式图片轮播
//
//  Created by 昊誉信息 on 2016/11/18.
//  Copyright © 2016年 haoyu. All rights reserved.
//

#import "ViewController.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#define Width [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<NewPagedFlowViewDelegate,NewPagedFlowViewDataSource>
@property(nonatomic,strong)NSMutableArray *imageArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"图片轮播";
    for (NSInteger i=0; i<5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Yosemite%02li",i]];
        [self.imageArr addObject:image];
    }
    [self setupUI];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)setupUI{
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc]initWithFrame:CGRectMake(0, 40, Width, 200)];
    pageFlowView.backgroundColor = [UIColor orangeColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource =self;
    pageFlowView.minimumPageAlpha = 0.2;
    pageFlowView.minimumPageScale = 0.8;
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [bottomScrollView addSubview:pageFlowView];
    
    [pageFlowView reloadData];
    
    [self.view addSubview:bottomScrollView];
}

-(CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView{
    return CGSizeMake(Width-100, 200);
}
-(void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex{
    NSLog(@"1111");
}
-(NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView{
    return self.imageArr.count;
}
-(UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, Width - 100, 200)];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    bannerView.mainImageView.image = self.imageArr[index];
    
    return bannerView;

}
-(NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
