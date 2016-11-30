//
//  LoginViewController.m
//  DataStorageDemo
//
//  Created by x8f on 16/11/25.
//  Copyright © 2016年 xbk. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"
#import "RootViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>

@property(nonatomic, strong)UITextField *countNameTextfield;
@property(nonatomic, strong)UITextField *passwordTextfield;
@property(nonatomic, strong)UIButton *loginBtn;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    //用户名 textfield
    [view addSubview:self.countNameTextfield];
    [self.countNameTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.width.equalTo(@200);
        make.height.equalTo(@30);
        make.centerY.equalTo(view.mas_centerY).offset(-50);
    }];
    
    //密码  textfield
    [view addSubview:self.passwordTextfield];
    [self.passwordTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.countNameTextfield);
        make.width.equalTo(@200);
        make.height.equalTo(@30);
        make.top.equalTo(self.countNameTextfield.mas_bottom).offset(20);
    }];
    
    //登录按钮
    [view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.width.equalTo(@60);
        make.height.equalTo(@21);
        make.top.equalTo(self.passwordTextfield.mas_bottom).offset(30);
    }];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(lll) name:@"closelogin" object:nil];
    
}

-(void)lll
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.countNameTextfield resignFirstResponder];
    [self.passwordTextfield resignFirstResponder];
    
}


#pragma mark -- property懒加载


-(UITextField *)countNameTextfield
{
    if (!_countNameTextfield) {
        _countNameTextfield = [[UITextField alloc]init];
        _countNameTextfield.delegate =self;
        _countNameTextfield.borderStyle = UITextBorderStyleRoundedRect;//边框样式
        _countNameTextfield.returnKeyType = UIReturnKeyDefault;//键盘样式
        _countNameTextfield.placeholder = @"请输入123456";
    }
    return _countNameTextfield;
}

-(UITextField *)passwordTextfield
{
    if (!_passwordTextfield) {
        _passwordTextfield = [[UITextField alloc]init];
        _passwordTextfield.delegate =self;
        _passwordTextfield.borderStyle = UITextBorderStyleRoundedRect;
        _passwordTextfield.returnKeyType = UIReturnKeyDone;
        _passwordTextfield.placeholder = @"请输入123456";
    }
    return _passwordTextfield;
}


-(UIButton *)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _loginBtn.backgroundColor = [UIColor clearColor];
        [_loginBtn setTitle:@"登陆" forState:(UIControlStateNormal)];
        [_loginBtn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
        [_loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _loginBtn;
}


-(void)loginBtnAction
{
    
    //实际开发中执行一些请求操作....
    
    
    //判断用户名与密码是否正确
    if ([self.countNameTextfield.text isEqualToString:@"123456"]&&[self.passwordTextfield.text isEqualToString:@"123456"]) {
        //存储用户信息
        User *user = [[User alloc]init];
        user.userName = self.countNameTextfield.text;
        user.userPassWord = self.passwordTextfield.text;
        [NSKeyedArchiver archiveRootObject:user toFile:[self getFilePath]];
        
        //存储是否登陆字符串
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults objectForKey:@"isLogin"];
        [defaults setObject:@"doyouself" forKey:@"isLogin"];
        
        //登陆成功之后页面跳转
        RootViewController *root = [[RootViewController alloc]init];
        [self.navigationController pushViewController:root animated:YES];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您输入的信息有误" message:@"请重新输入" preferredStyle:(UIAlertControllerStyleAlert)];
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



@end
