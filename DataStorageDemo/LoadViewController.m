//
//  LoadViewController.m
//  DataStorageDemo
//
//  Created by x8f on 16/11/25.
//  Copyright © 2016年 xbk. All rights reserved.
//

#import "LoadViewController.h"
#import <Masonry.h>
#import "LoginViewController.h"
@interface LoadViewController ()<UIScrollViewDelegate>


@property(nonatomic, strong)UIButton *btn;

@property(nonatomic, strong)UIImageView *firstImageView;
@property(nonatomic, strong)UIImageView *secondImageView;
@property(nonatomic, strong)UIImageView *ThirdImageView;

@end

@implementation LoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.navigationBar.hidden = YES;
    
    scrollview = [[UIScrollView alloc]init];
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.pagingEnabled = YES;
    scrollview.delegate = self;
    scrollview.bounces = NO;
    
    [self.view addSubview:scrollview];
    [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    //中转view
    containerView = [UIView new];
    [scrollview addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollview);
        make.height.equalTo(scrollview);
    }];
    
    
    //第一张图片
    
    [containerView addSubview:self.firstImageView];
    [self.firstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(containerView);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.left.mas_equalTo(containerView);
    }];
    
    //第二张图片
    
    [containerView addSubview:self.secondImageView];
    [self.secondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(containerView);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.left.equalTo(self.firstImageView.mas_right);
    }];
    
    //第三张图片
    
    [containerView addSubview:self.ThirdImageView];
    self.ThirdImageView.userInteractionEnabled = YES;//图片支持交互
    [self.ThirdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(containerView);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.left.mas_equalTo(self.secondImageView.mas_right);
    }];
    
    
    //进入app按钮
    self.btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.btn.backgroundColor = [UIColor purpleColor];
    [self.btn setTitle:@"进入app" forState:(UIControlStateNormal)];
    [self.btn addTarget:self action:@selector(btnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.ThirdImageView addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.ThirdImageView);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
        make.bottom.equalTo(self.ThirdImageView.mas_bottom).offset(-100);
    }];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.ThirdImageView.mas_right);
    }];
    
    
    //pagecontrol
    pagecontrol = [[UIPageControl alloc]init];
    pagecontrol.numberOfPages = 3;
    pagecontrol.currentPage = 0;
    pagecontrol.pageIndicatorTintColor = [UIColor redColor];//原点颜色
    pagecontrol.currentPageIndicatorTintColor = [UIColor blueColor];//当前页原点颜色
    [pagecontrol addTarget:self action:@selector(pageAction:) forControlEvents:(UIControlEventValueChanged)];
    [containerView addSubview:pagecontrol];
    [pagecontrol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.bottom.equalTo(self.view).with.offset(-30);
    }];
}

#pragma mark --- 按钮响应事件

-(void)btnAction
{
    LoginViewController *login = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:YES];
}



-(void)pageAction:(UIPageControl *)sender
{
    [scrollview setContentOffset:CGPointMake(pagecontrol.currentPage * ([UIScreen mainScreen].bounds.size.width), 0)];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGRect bounds = self.view.frame;
    int pa = scrollview.contentOffset.x / (bounds.size.width);
    pagecontrol.currentPage = pa;
}


#pragma mark --- 懒加载图片对象

-(UIImageView *)firstImageView
{
    if (!_firstImageView) {
        _firstImageView = [[UIImageView alloc]init];
        _firstImageView.image = [UIImage imageNamed:@"fbf"];
    }
    return _firstImageView;
}

-(UIImageView *)secondImageView
{
    if (!_secondImageView) {
        _secondImageView = [[UIImageView alloc]init];
        _secondImageView.image = [UIImage imageNamed:@"sbf"];
    }
    return _secondImageView;
}

-(UIImageView *)ThirdImageView
{
    if (!_ThirdImageView) {
        _ThirdImageView = [[UIImageView alloc]init];
        _ThirdImageView.image = [UIImage imageNamed:@"tbf"];
    }
    return _ThirdImageView;
}


@end
