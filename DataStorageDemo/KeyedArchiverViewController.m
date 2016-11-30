//
//  KeyedArchiverViewController.m
//  DataStorageDemo
//
//  Created by x8f on 16/11/24.
//  Copyright © 2016年 xbk. All rights reserved.
//

#import "KeyedArchiverViewController.h"
#import "User.h"
@interface KeyedArchiverViewController ()

@property(nonatomic, strong)UILabel *userNameLabel;
@property(nonatomic, strong)UILabel *passwordLabel;

@property(nonatomic, strong)UIButton *deleteBtn;

@property(nonatomic, strong)User *user;

@end

@implementation KeyedArchiverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //用户名（123456）
    [self.view addSubview:self.userNameLabel];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(150);
        make.width.equalTo(@100);
        make.height.equalTo(@21);
    }];
    
    //密码(123456)
    [self.view addSubview:self.passwordLabel];
    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(20);
        make.width.equalTo(@100);
        make.height.equalTo(@21);
    }];
    
    //退出登录
    [self.view addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.passwordLabel.mas_bottom).offset(30);
        make.width.equalTo(@100);
        make.height.equalTo(@21);
    }];
    
    
    //获取归档存储的数据
    [self getArchiverData];
    
    
    
}

//取数
-(void)getArchiverData
{
    /* 直接取model参数 */
    if ([[NSFileManager defaultManager]fileExistsAtPath:[self getFilePath]]) {
        self.user = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePath]];
        NSLog(@"%@---%@",self.user.userName,self.user.userPassWord);
        self.userNameLabel.text = self.user.userName;
        self.passwordLabel.text = self.user.userPassWord;
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"不存在此模型" message:@"请先创建模型" preferredStyle:(UIAlertControllerStyleAlert)];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击取消");
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击确认");
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

//退出登录（删除数据）
-(void)deleteArchiverData
{
    NSFileManager *defaultFileManager = [NSFileManager defaultManager];
    if ([defaultFileManager fileExistsAtPath:[self getFilePath]]) {
        [defaultFileManager removeItemAtPath:[self getFilePath] error:nil];
        
        //退出登录的同时需要将NSuserDefaults中存储的一并删除
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:@"isLogin"];
        
        
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"closelogin" object:nil];
        
        NSLog(@"删除nakeyedArchiver模型成功");
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"不存在此模型" message:@"请先创建模型" preferredStyle:(UIAlertControllerStyleAlert)];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击取消");
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击确认");
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


//路径
-(NSString *)getFilePath
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0] stringByAppendingPathComponent:@"User"];
}


#pragma mark --- 懒加载

-(UILabel *)userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc]init];
        _userNameLabel.textAlignment = NSTextAlignmentCenter;//文本居中
        _userNameLabel.textColor = [UIColor redColor];
    }
    return _userNameLabel;
}

-(UILabel *)passwordLabel
{
    if (!_passwordLabel) {
        _passwordLabel = [[UILabel alloc]init];
        _passwordLabel.textAlignment = NSTextAlignmentCenter;
        _passwordLabel.textColor = [UIColor redColor];
    }
    return _passwordLabel;
}

-(UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_deleteBtn setTitle:@"退出登录" forState:(UIControlStateNormal)];
        [_deleteBtn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
        [_deleteBtn addTarget:self action:@selector(deleteArchiverData) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _deleteBtn;
}



@end
