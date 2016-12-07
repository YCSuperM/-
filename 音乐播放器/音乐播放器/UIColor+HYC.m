//
//  UIColor+HYC.m
//  Discussion
//
//  Created by 昊誉信息 on 16/7/13.
//  Copyright © 2016年 haoyu. All rights reserved.
//

#import "UIColor+HYC.h"

@implementation UIColor (HYC)
+(instancetype)FrenchGreyColor{
    return [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
}
+(instancetype)MediumGreyColor{
    return [UIColor colorWithRed:90.0/255 green:90.0/255 blue:125.0/255 alpha:1];
}
+(instancetype)TabbarColor{
//    return [UIColor colorWithRed:27.0/255 green:91.0/255 blue:237.0/255 alpha:1];
    return [UIColor colorWithRed:83.0/255 green:170.0/255 blue:51.0/255 alpha:1];
}
+(instancetype)selectTextColor{
    return [UIColor colorWithRed:80.0/255 green:170.0/255 blue:50.0/255 alpha:1];
}
+(instancetype)musicColor{
    return [UIColor colorWithRed:45.0/255 green:45.0/255 blue:45.0/255 alpha:1];
}
@end
