//
//  UserDefaultViewController.m
//  DataStorageDemo
//
//  Created by x8f on 16/11/24.
//  Copyright © 2016年 xbk. All rights reserved.
//

#import "UserDefaultViewController.h"
#import <Masonry.h>
@interface UserDefaultViewController ()

@property(nonatomic, strong)UIButton *writeBtn;
@property(nonatomic, strong)UIButton *readBtn;




@end

@implementation UserDefaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.writeBtn];
    [self.writeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.width.equalTo(@60);
        make.height.equalTo(@30);
    }];
    
    [self.view addSubview:self.readBtn];
    [self.readBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.writeBtn.mas_bottom).offset(30);
        make.width.equalTo(@60);
        make.height.equalTo(@30);
    }];

}



-(UIButton *)writeBtn
{
    if (!_writeBtn) {
        _writeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_writeBtn addTarget:self action:@selector(writeBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_writeBtn setTitle:@"存" forState:(UIControlStateNormal)];
        _writeBtn.backgroundColor = [UIColor purpleColor];
        _writeBtn.layer.masksToBounds = YES;
        _writeBtn.layer.cornerRadius = 10.0;//设置矩形四个圆角半径
        _writeBtn.layer.borderWidth = 1.0;//边框宽度
    }
    return _writeBtn;
}


-(void)writeBtnAction
{
    //存
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *mutableArr = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    NSArray *arr = [NSArray arrayWithArray:mutableArr];
    [defaults setObject:arr forKey:@"mutableArr"];//这里最好是不可变的
}


-(UIButton *)readBtn
{
    if (!_readBtn) {
        _readBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_readBtn addTarget:self action:@selector(readBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_readBtn setTitle:@"取" forState:(UIControlStateNormal)];
        _readBtn.backgroundColor = [UIColor purpleColor];
        _readBtn.layer.masksToBounds = YES;
        _readBtn.layer.cornerRadius = 10.0;//设置矩形四个圆角半径
        _readBtn.layer.borderWidth = 1.0;//边框宽度
    }
    return _readBtn;
}

-(void)readBtnAction
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //取：错误的写法（不要直接赋值给可变数组（NSMutableArray））
//    NSMutableArray *getmutableArr = [defaults objectForKey:@"mutableArr"];
//    NSLog(@"%@",getmutableArr);
//    [getmutableArr insertObject:@"4" atIndex:0];
//    NSLog(@"%@",getmutableArr);

    //先取出存储的数组（不可变的），然后将取出的不可变数组赋值给可变数组
    NSMutableArray *getmutableArr = [NSMutableArray arrayWithArray:[defaults objectForKey:@"mutableArr"]];
    [getmutableArr insertObject:@"4" atIndex:0];
    NSLog(@"%@",getmutableArr);
    [defaults setObject:getmutableArr forKey:@"mutableArr" ];
    NSLog(@"%@",[defaults objectForKey:@"mutableArr"]);
    
    
}




@end
