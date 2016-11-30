//
//  FMDBViewController.m
//  DataStorageDemo
//
//  Created by x8f on 16/11/24.
//  Copyright © 2016年 xbk. All rights reserved.
//

#import "FMDBViewController.h"
#import "CarInfo.h"
#import <Masonry.h>
@interface FMDBViewController ()

@property(nonatomic, strong)UIButton *saveORupdateBtn;      //增加或者修改
@property(nonatomic, strong)UIButton *loadDateBtn;          //查询数据
@property(nonatomic, strong)UIButton *deleteSpecialCarBtn;  //删除特定车辆
@property(nonatomic, strong)UIButton *deleteAllCarBtn;      //删除某用户全部车辆

@end

@implementation FMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //保存或者更新按钮
    [self.view addSubview:self.saveORupdateBtn];
    [self.saveORupdateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.width.equalTo(@250);
        make.height.equalTo(@30);
    }];
    
    //查询按钮
    [self.view addSubview:self.loadDateBtn];
    [self.loadDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.saveORupdateBtn.mas_bottom).offset(20);
        make.width.equalTo(@250);
        make.height.equalTo(@30);
    }];
    
    //删除特定车辆按钮
    [self.view addSubview:self.deleteSpecialCarBtn];
    [self.deleteSpecialCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.loadDateBtn.mas_bottom).offset(20);
        make.width.equalTo(@250);
        make.height.equalTo(@30);
    }];
    
    
    //删除某用户的所有车辆按钮
    [self.view addSubview:self.deleteAllCarBtn];
    [self.deleteAllCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.deleteSpecialCarBtn.mas_bottom).offset(20);
        make.width.equalTo(@250);
        make.height.equalTo(@30);
    }];
    
}



//添加或者修改车辆信息
-(void)saveORupdateBtnAction
{
    /*
     *
     *  这里只是简单的演示 FMDB 增、删、改、查的功能，所以自己测试的时候请先多添加几次数据（数据不重叠）
     *  便于改、删、查的操作演示
     *
     *
     */
    

    CarInfo *carinfo = [[CarInfo alloc]init];
    carinfo.userID = @"3";
    carinfo.carID = @"dr3r3nr39r03r3";
    carinfo.carName = @"奥迪";
    carinfo.carNumber = @"京A93032";
    carinfo.carIsDefault = 1;
    if ([carinfo saveCarDataByUserID:carinfo.userID carID:carinfo.carID]) {
        NSLog(@"添加或者修改数据成功");
    };
}

//查询某用户的全部车辆信息
-(void)loadDateBtnAction
{
    /*
     *
     *  这里只是简单的演示 FMDB 增、删、改、查的功能，所以自己测试的时候请根据数据库具体数据信息进行查询
     *
     *
     *
     */
    CarInfo *carinfo = [[CarInfo alloc]init];
    carinfo.userID = @"1";
    //这里最少要给一个userID  用于查询某用户的所有车辆信息
    NSArray *arr = [carinfo loadCarDateByUserID:carinfo.userID carID:nil];
    if (arr) {
        for (CarInfo *info in arr) {
            NSLog(@"%@---%@---%@---%@---%ld",info.userID,info.carID,info.carName,info.carNumber,info.carIsDefault);
        }
    }
}

//删除某用户特定车辆信息
-(void)deleteSpecialCarBtnAction
{
    /*
     *
     *  这里只是简单的演示 FMDB 增、删、改、查的功能，所以自己测试的时候请根据数据库具体数据信息进行删除
     *
     *
     *
     */
    CarInfo *carinfo = [[CarInfo alloc]init];
    carinfo.userID = @"1";
    carinfo.carID = @"dnk3r35k5n6363";
    //这里要给一个userid以及carid用于确定删除的是哪一辆车
    if ([carinfo removeCarDataByUserId:carinfo.userID carID:carinfo.carID]) {
        NSLog(@"删除车辆成功");
    };
}

//删除某用户所有车辆信息
-(void)deleteAllCarBtnAction
{
//    CarInfo *carinfo = [[CarInfo alloc]init];
//    //同样的我们需要知道这个carifo的userid是多少，用于确定删除的是哪一个用户的所有车辆
//    carinfo.userID = @"";
//    [carinfo removeAllCarData];
}


#pragma mark --- property 懒加载

-(UIButton *)saveORupdateBtn
{
    if (!_saveORupdateBtn) {
        _saveORupdateBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_saveORupdateBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        [_saveORupdateBtn setTitle:@"增加或者修改车辆信息" forState:(UIControlStateNormal)];
        [_saveORupdateBtn addTarget:self action:@selector(saveORupdateBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        _saveORupdateBtn.layer.masksToBounds = YES;
        _saveORupdateBtn.layer.cornerRadius = 10.0;//设置矩形四个圆角半径
        _saveORupdateBtn.layer.borderWidth = 1.0;//边框宽度
    }
    return _saveORupdateBtn;
}

-(UIButton *)loadDateBtn
{
    if (!_loadDateBtn) {
        _loadDateBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_loadDateBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        [_loadDateBtn setTitle:@"查询车辆信息" forState:(UIControlStateNormal)];
        [_loadDateBtn addTarget:self action:@selector(loadDateBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        _loadDateBtn.layer.masksToBounds = YES;
        _loadDateBtn.layer.cornerRadius = 10.0;//设置矩形四个圆角半径
        _loadDateBtn.layer.borderWidth = 1.0;//边框宽度
    }
    return _loadDateBtn;
}

-(UIButton *)deleteSpecialCarBtn
{
    if (!_deleteSpecialCarBtn) {
        _deleteSpecialCarBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_deleteSpecialCarBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        [_deleteSpecialCarBtn setTitle:@"删除特定车辆信息" forState:(UIControlStateNormal)];
        [_deleteSpecialCarBtn addTarget:self action:@selector(deleteSpecialCarBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        _deleteSpecialCarBtn.layer.masksToBounds = YES;
        _deleteSpecialCarBtn.layer.cornerRadius = 10.0;//设置矩形四个圆角半径
        _deleteSpecialCarBtn.layer.borderWidth = 1.0;//边框宽度
    }
    return _deleteSpecialCarBtn;
}

-(UIButton *)deleteAllCarBtn
{
    if (!_deleteAllCarBtn) {
        _deleteAllCarBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_deleteAllCarBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        [_deleteAllCarBtn setTitle:@"删除某用户所有车辆信息" forState:(UIControlStateNormal)];
        [_deleteAllCarBtn addTarget:self action:@selector(deleteAllCarBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        _deleteAllCarBtn.layer.masksToBounds = YES;
        _deleteAllCarBtn.layer.cornerRadius = 10.0;//设置矩形四个圆角半径
        _deleteAllCarBtn.layer.borderWidth = 1.0;//边框宽度
    }
    return _deleteAllCarBtn;
}






@end
