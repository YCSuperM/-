//
//  ImagesView.m
//  详情界面
//
//  Created by 昊誉信息 on 16/10/10.
//  Copyright © 2016年 haoyu. All rights reserved.
//

#import "ImagesView.h"

@interface ImagesView ()<UIScrollViewDelegate>
@property (weak, nonatomic)UIScrollView *scrollView;

@property (weak, nonatomic)UIPageControl *pageView;

@property (strong, nonatomic)NSTimer *timer;

@end
@implementation ImagesView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}
-(void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    [self prepareScollView];
    [self preparePageView];
}
- (void)prepareScollView {
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, imageH)];
    scrollView.delegate = self;
    
    for (int i = 0; i < self.imageArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        //        NSString *name = [NSString stringWithFormat:@"img_%02d",i + 1];
        imageView.image = [UIImage imageNamed:self.imageArr[i]];
        CGFloat imageX = kScreenW * (i + 1);
        imageView.frame = CGRectMake(imageX, 0, kScreenW, imageH);
        [scrollView addSubview:imageView];
    }
    
    UIImageView *firstImage = [[UIImageView alloc] init];
    firstImage.image = [UIImage imageNamed:self.imageArr.lastObject];
    firstImage.frame = CGRectMake(0, 0, kScreenW, imageH);
    [scrollView addSubview:firstImage];
    scrollView.contentOffset = CGPointMake(kScreenW, 0);
    
    UIImageView *lastImage = [[UIImageView alloc] init];
    lastImage.image = [UIImage imageNamed:self.imageArr.firstObject];
    lastImage.frame = CGRectMake((self.imageArr.count + 1) * kScreenW, 0, kScreenW, imageH);
    [scrollView addSubview:lastImage];
    scrollView.contentSize = CGSizeMake((self.imageArr.count + 2) * kScreenW, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    [self addTimer];
}

-(void)preparePageView {
    CGFloat pageW = 100;
    UIPageControl *pageView = [[UIPageControl alloc] initWithFrame:CGRectMake((kScreenW - pageW) * 0.5, 190, pageW, 4)];
    pageView.numberOfPages = self.imageArr.count;
    pageView.currentPageIndicatorTintColor = [UIColor redColor];
    pageView.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageView.currentPage = 0;
    [self addSubview:pageView];
    self.pageView = pageView;
}

- (void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)nextImage {
    CGFloat width = self.scrollView.frame.size.width;
    NSInteger index = self.pageView.currentPage;
    if (index == self.imageArr.count + 1) {
        index = 0;
    } else {
        index++;
    }
    [self.scrollView setContentOffset:CGPointMake((index + 1) * width, 0)animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat width = self.scrollView.frame.size.width;
    int index = (self.scrollView.contentOffset.x + width * 0.5) / width;
    if (index == self.imageArr.count + 2) {
        index = 1;
    } else if(index == 0) {
        index = (CGFloat)self.imageArr.count;
    }
    self.pageView.currentPage = index - 1;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat width = self.scrollView.frame.size.width;
    int index = (self.scrollView.contentOffset.x + width * 0.5) / width;
    if (index == self.imageArr.count + 1) {
        [self.scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
    } else if (index == 0) {
        [self.scrollView setContentOffset:CGPointMake(self.imageArr.count * width, 0) animated:NO];
    }
}

@end
