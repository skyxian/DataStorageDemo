//
//  CoreDataViewController.m
//  DataStorageDemo
//
//  Created by x8f on 16/11/24.
//  Copyright © 2016年 xbk. All rights reserved.
//

#import "CoreDataViewController.h"

@interface CoreDataViewController ()

@end

@implementation CoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 30)];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    self.label.text = @"http://www.jianshu.com/p/3fa7036528eb";
    [self.view addSubview:self.label];
    
    
    
    
}




















@end
