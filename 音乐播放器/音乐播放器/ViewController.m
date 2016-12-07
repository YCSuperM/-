//
//  ViewController.m
//  音乐播放器
//
//  Created by 昊誉信息 on 16/9/12.
//  Copyright © 2016年 haoyu. All rights reserved.
//

#import "ViewController.h"
#import "MusicView.h"
#import "Masonry.h"
#import "MusicManager.h"
#import "MusicModel.h"
@interface ViewController ()
@property(nonatomic,strong)MusicView *musicV;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArr = [NSMutableArray arrayWithCapacity:0];
    MusicModel *model = [[MusicModel alloc]init];
    model.userNameStr = @"周杰伦";
    model.songNameStr = @"东方破";
    model.iconStr = @"1223.jpg";
    model.songUrl = @"http://audio.xmcdn.com/group16/M05/1D/4B/wKgDbFV4UYyQGBGyAB9tw0HK9oI870.m4a";
    [_dataArr addObject:model];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(50, 50, 50, 30);
    [btn setTitle:@"点击cell" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(btnclicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [self creatUI];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)creatUI{
    
    [self.view addSubview:self.musicV];
    [self.musicV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
}

-(void)btnclicked{
    //点击cell后，将音乐数组和要播放的音乐位置传进去
    //数组中放的是model；
    [MusicManager shareInfo].musicArray = _dataArr;
    [MusicManager shareInfo].index = 0;
    [self reloadDataWithIndex:[MusicManager shareInfo].index];
    //打开计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAct) userInfo:nil repeats:YES];
}
//得到model中的url，播放音乐
-(void)reloadDataWithIndex:(NSInteger)index{
    MusicModel *model = [MusicManager shareInfo].musicArray[index];
    self.musicV.musicModel = model;
    [[MusicManager shareInfo] replaceItemWithUrlString:model.songUrl];
}
-(void)timerAct{
    if ([MusicManager shareInfo].player.currentTime.timescale == 0 || [MusicManager shareInfo].player.currentItem.duration.timescale == 0) {
        return;
    }
    // 获得音乐总时长
    long long int totalTime = [MusicManager shareInfo].player.currentItem.duration.value / [MusicManager shareInfo].player.currentItem.duration.timescale;
    // 获得当前时间
    long long int currentTime = [MusicManager shareInfo].player.currentTime.value / [MusicManager shareInfo].player.currentTime.timescale;
    self.musicV.progressSlider.maximumValue = totalTime;
    self.musicV.progressSlider.minimumValue = 0;
    self.musicV.progressSlider.value = currentTime;
    
    //如果播放完就播放下一首
    if (self.musicV.progressSlider.value == totalTime) {
        [[MusicManager shareInfo] playNext];
        [self reloadDataWithIndex:[MusicManager shareInfo].index];
    }
}


-(MusicView *)musicV{
    if (!_musicV) {
        _musicV = [[MusicView alloc]init];
    }
    return _musicV;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
