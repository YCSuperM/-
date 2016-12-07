//
//  ViewController.m
//  3Dtouch
//
//  Created by 昊誉信息 on 2016/11/15.
//  Copyright © 2016年 haoyu. All rights reserved.
//

#import "ViewController.h"
#import "SubViewController.h"
@interface ViewController ()<UIViewControllerPreviewingDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    label.center = self.view.center;
    label.userInteractionEnabled = YES;
    label.text = @"peek测试";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:label];
    
    [self registerForPreviewingWithDelegate:self sourceView:label];
    // Do any additional setup after loading the view, typically from a nib.
}
-(nullable UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    SubViewController *subVC = [[SubViewController alloc]init];
//    subVC.preferredContentSize = CGSizeMake(0, 300);
    return subVC;
}

-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    [self.navigationController pushViewController:viewControllerToCommit animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
