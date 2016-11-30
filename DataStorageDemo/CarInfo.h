//
//  CarInfo.h
//  DataStorageDemo
//
//  Created by x8f on 16/11/26.
//  Copyright © 2016年 xbk. All rights reserved.
//



/*
 *
 *
 *   本类用于FMDB做数据存储的演示，请联系FMDBVC查看
 *
 *
 *
 */

#import <Foundation/Foundation.h>
#import <FMDatabase.h>
#import <FMDatabaseAdditions.h>

@interface CarInfo : NSObject
@property(nonatomic, strong)NSString *userID;      //用户id
@property(nonatomic, strong)NSString *carID;       //车id
@property(nonatomic, strong)NSString *carName;     //车名
@property(nonatomic, strong)NSString *carNumber;   //车牌号
@property(nonatomic, assign)NSInteger carIsDefault;//是否为默认车辆

//向数据库中添加或修改车辆信息
-(BOOL)saveCarDataByUserID:(NSString *)userid carID:(NSString *)carid;

//根据userid、carid删除某用户特定车辆信息
-(BOOL)removeCarDataByUserId:(NSString *)userid carID:(NSString *)carid;

//删除userid对应的全部车辆
-(BOOL)removeAllCarData;

//查询某用户车辆信息
-(NSArray *)loadCarDateByUserID:(NSString *)userid carID:(NSString *)carid;


@end
