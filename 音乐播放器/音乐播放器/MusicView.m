//
//  MusicView.m
//  音乐播放器
//
//  Created by 昊誉信息 on 16/11/3.
//  Copyright © 2016年 haoyu. All rights reserved.
//

#import "MusicView.h"
#import "Masonry.h"
#import "UIColor+HYC.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MusicManager.h"
#import "MusicModel.h"
@interface MusicView ()
@property(nonatomic,strong)UIImageView *iconIV;
@property(nonatomic,strong)UILabel *songNameLB;
@property(nonatomic,strong)UILabel *userNameLB;
@property(nonatomic,strong)UIButton *playBtn;
@property(nonatomic,strong)UIButton *nextBtn;
@property(nonatomic,strong)UIButton *moreBtn;
@property(nonatomic,strong)AVAudioPlayer *player;
@property(nonatomic,strong)NSTimer *timer;
@end
@implementation MusicView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor musicColor];
        [self addSubviews];
    }
    return self;
}
-(void)addSubviews{
    [self addSubview:self.iconIV];
    [self addSubview:self.progressSlider];
    [self addSubview:self.songNameLB];
    [self addSubview:self.userNameLB];
    [self addSubview:self.playBtn];
    [self addSubview:self.nextBtn];
    [self addSubview:self.moreBtn];
    
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [self.progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.equalTo(self.iconIV.mas_right).offset(10);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(5);
    }];
    [self.songNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressSlider.mas_bottom).offset(5);
        make.left.equalTo(self.iconIV.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    [self.userNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.songNameLB.mas_bottom).offset(5);
        make.left.equalTo(self.iconIV.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 10));
    }];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressSlider.mas_bottom).offset(5);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressSlider.mas_bottom).offset(5);
        make.right.equalTo(self.moreBtn.mas_left).offset(-10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressSlider.mas_bottom).offset(5);
        make.right.equalTo(self.nextBtn.mas_left).offset(-10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}
-(UIImageView *)iconIV{
    if (!_iconIV) {
        _iconIV = [[UIImageView alloc]init];
        _iconIV.layer.masksToBounds = YES;
        _iconIV.layer.cornerRadius = 20;
        _iconIV.image = [UIImage imageNamed:@"123.jpeg"];
    }
    return _iconIV;
}
-(UISlider *)progressSlider{
    if (!_progressSlider) {
        _progressSlider = [[UISlider alloc]init];
        _progressSlider.maximumTrackTintColor = [UIColor grayColor];
        _progressSlider.minimumTrackTintColor = [UIColor yellowColor];
        [_progressSlider setThumbImage:[UIImage new] forState:UIControlStateNormal];
        [_progressSlider setThumbImage:[UIImage new] forState:UIControlStateHighlighted];
        _progressSlider.continuous = NO;
        [_progressSlider addTarget:self action:@selector(sliderBeginChage:) forControlEvents:UIControlEventTouchDown];
        [_progressSlider addTarget:self action:@selector(sliderDidChange:) forControlEvents:UIControlEventValueChanged];
        _progressSlider.value = 0.7;
    }
    return _progressSlider;
}
-(UILabel *)songNameLB{
    if (!_songNameLB) {
        _songNameLB = [[UILabel alloc]init];
        _songNameLB.text = @"在，也不在";
        _songNameLB.textColor = [UIColor whiteColor];
        _songNameLB.font = [UIFont systemFontOfSize:19];
    }
    return _songNameLB;
}
-(UILabel *)userNameLB{
    if (!_userNameLB ) {
        _userNameLB = [[UILabel alloc]init];
        _userNameLB.text = @"孙燕姿";
        _userNameLB.textColor = [UIColor lightGrayColor];
        _userNameLB.font = [UIFont systemFontOfSize:14];
    }
    return _userNameLB;
}
-(UIButton *)playBtn{
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _playBtn.layer.masksToBounds = YES;
        _playBtn.layer.cornerRadius = 15;
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"bofan"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}
-(UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _nextBtn.layer.masksToBounds = YES;
        _nextBtn.layer.cornerRadius = 15;
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"xuanzhongde"] forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(nextBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}
-(UIButton *)moreBtn{
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_moreBtn addTarget:self action:@selector(moreBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}
//暂停或播放
-(void)playBtnClicked:(UIButton *)playBtn{
    if ([MusicManager shareInfo].isPlay) {
        [playBtn setBackgroundImage:[UIImage imageNamed:@"zanting-1"] forState:UIControlStateNormal];
    }else{
        [playBtn setBackgroundImage:[UIImage imageNamed:@"bofan"] forState:UIControlStateNormal];
    }
    [[MusicManager shareInfo] playAndPause];
}
//下一首
-(void)nextBtnClicked{
    [[MusicManager shareInfo] playNext];
    MusicModel *model = [MusicManager shareInfo].musicArray[[MusicManager shareInfo].index];
    [[MusicManager shareInfo] replaceItemWithUrlString:model.songUrl];
}
//上一首（以后万一用）
-(void)beforeBtnClicked{
    [[MusicManager shareInfo] playPrevious];
    MusicModel *model = [MusicManager shareInfo].musicArray[[MusicManager shareInfo].index];
    [[MusicManager shareInfo] replaceItemWithUrlString:model.songUrl];
}
//列表
-(void)moreBtnClicked{

}
//结束滑动
-(void)sliderDidChange:(UISlider *)slider{
    [[MusicManager shareInfo] playerPlay];
    [[MusicManager shareInfo] playerProgressWithProgressFloat:slider.value];
}
//开始滑动
-(void)sliderBeginChage:(UISlider *)slider{
    [[MusicManager shareInfo] playerPause];
}
-(void)setMusicModel:(MusicModel *)musicModel{
    _musicModel = musicModel;
    _iconIV.image = [UIImage imageNamed:musicModel.iconStr];
    _songNameLB.text = musicModel.songNameStr;
    _userNameLB.text = musicModel.userNameStr;
    
}
@end
