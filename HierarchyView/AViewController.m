//
//  AViewController.m
//  HierarchyView
//
//  Created by 谢鹏翔 on 16/8/29.
//  Copyright © 2016年 ime. All rights reserved.
//

#import "AViewController.h"
#import "HierarchyView.h"

@interface AViewController ()

@property (nonatomic, strong) HierarchyView *topView;

@end

@implementation AViewController

- (void)viewDidLoad
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    _topView = [[HierarchyView alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, 60)];
    _topView.backgroundColor = [UIColor yellowColor];
    _topView.titleArray = @[@"11111",@"222222222222",@"3333",@"4",@"555",@"666666",@"7777777",@"888888888888888"];
    [self.view addSubview:_topView];
}

- (void)dealloc
{
    NSLog(@"AViewController dealloc ");
}

@end
