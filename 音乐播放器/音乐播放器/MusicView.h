//
//  MusicView.h
//  音乐播放器
//
//  Created by 昊誉信息 on 16/11/3.
//  Copyright © 2016年 haoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MusicModel;
@interface MusicView : UIView
@property(nonatomic,strong)MusicModel *musicModel;
@property(nonatomic,strong)UISlider *progressSlider;

@end
