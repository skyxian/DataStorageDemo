//
//  PlistViewController.m
//  DataStorageDemo
//
//  Created by x8f on 16/11/24.
//  Copyright © 2016年 xbk. All rights reserved.
//

#import "PlistViewController.h"
#import <Masonry.h>
@interface PlistViewController ()

@property(nonatomic, strong)UIButton *infoplistBtn;//直接读取项目中的.plist文件btn

@property(nonatomic, strong)UIButton *writeBtn;//写入btn

@property(nonatomic, strong)UIButton *readBtn;//读取btn

@property(nonatomic, strong)UIButton *deleteBtn;//删除沙盒中的.plist文件

@end

@implementation PlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self.view addSubview:self.infoplistBtn];
    [self.infoplistBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.width.equalTo(@200);
        make.height.equalTo(@30);
    }];
    
    [self.view addSubview:self.writeBtn];
    [self.writeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.infoplistBtn.mas_bottom).offset(30);
        make.width.equalTo(@200);
        make.height.equalTo(@30);
    }];
    
    [self.view addSubview:self.readBtn];
    [self.readBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.writeBtn.mas_bottom).offset(30);
        make.width.equalTo(@200);
        make.height.equalTo(@30);
    }];
    
    
    [self.view addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.readBtn.mas_bottom).offset(30);
        make.width.equalTo(@200);
        make.height.equalTo(@30);
    }];
    
}


-(NSString *)getfilePath
{
    //plist文件所在沙盒中的路径
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0] stringByAppendingPathComponent:@"person.plist"];
}


#pragma mark --- property懒加载

-(UIButton *)infoplistBtn
{
    if (!_infoplistBtn) {
        _infoplistBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_infoplistBtn addTarget:self action:@selector(infoplistBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_infoplistBtn setTitle:@"读取项目中的.plist" forState:(UIControlStateNormal)];
        _infoplistBtn.backgroundColor = [UIColor redColor];
        _infoplistBtn.layer.masksToBounds = YES;
        _infoplistBtn.layer.cornerRadius = 10.0;//设置矩形四个圆角半径
        _infoplistBtn.layer.borderWidth = 1.0;//边框宽度
    }
    return _infoplistBtn;
}

-(void)infoplistBtnAction
{
    //读取Plist
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"PlistView" ofType:@"plist"];
    NSMutableArray *PlistArr = [NSMutableArray arrayWithContentsOfFile:plistPath];
    NSLog(@"%@",PlistArr);
}

-(UIButton *)writeBtn
{
    if (!_writeBtn) {
        _writeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_writeBtn addTarget:self action:@selector(writeBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_writeBtn setTitle:@"将文件写入沙盒中的plist" forState:(UIControlStateNormal)];
        _writeBtn.backgroundColor = [UIColor blueColor];
        _writeBtn.layer.masksToBounds = YES;
        _writeBtn.layer.cornerRadius = 10.0;//设置矩形四个圆角半径
        _writeBtn.layer.borderWidth = 1.0;//边框宽度
    }
    return _writeBtn;
}


-(void)writeBtnAction
{
    NSLog(@"%@",[self getfilePath]);
    //读取Plist
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"PlistView" ofType:@"plist"];
    NSMutableArray *PlistArr = [NSMutableArray arrayWithContentsOfFile:plistPath];
    
    //如果沙盒中不存在这个plist文件 则写入
    if (![[NSFileManager defaultManager]fileExistsAtPath:[self getfilePath]]) {
        [PlistArr insertObject:@{@"name":@"xmz",@"sex":@"men"} atIndex:0];
        [PlistArr writeToFile:[self getfilePath] atomically:YES];
    }{
        NSLog(@"存在plist，不做操作");
    }
}


-(UIButton *)readBtn
{
    if (!_readBtn) {
        _readBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_readBtn addTarget:self action:@selector(readBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_readBtn setTitle:@"读取沙盒中的plist" forState:(UIControlStateNormal)];
        _readBtn.backgroundColor = [UIColor purpleColor];
        _readBtn.layer.masksToBounds = YES;
        _readBtn.layer.cornerRadius = 10.0;//设置矩形四个圆角半径
        _readBtn.layer.borderWidth = 1.0;//边框宽度
    }
    return _readBtn;
}

-(void)readBtnAction
{
    //怎么知道我写入数据与否？可以前往文件夹，将打印的路径输入。或者直接打印沙盒中的数据（如下：）
    if ([[NSFileManager defaultManager]fileExistsAtPath:[self getfilePath]]) {
        NSMutableArray *plistArr1 = [NSMutableArray arrayWithContentsOfFile:[self getfilePath]];
        NSLog(@"%@",plistArr1);
    }
}


-(UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_deleteBtn setTitle:@"删除沙盒中的plist" forState:(UIControlStateNormal)];
        _deleteBtn.backgroundColor = [UIColor purpleColor];
        _deleteBtn.layer.masksToBounds = YES;
        _deleteBtn.layer.cornerRadius = 10.0;
        _deleteBtn.layer.borderWidth = 1.0;
    }
    return _deleteBtn;
}

-(void)deleteBtnAction
{
    //删除沙盒中的plist
    if ([[NSFileManager defaultManager]fileExistsAtPath:[self getfilePath]]) {
        [[NSFileManager defaultManager]removeItemAtPath:[self getfilePath] error:nil];
        NSLog(@"删除成功");
    }
}


@end
