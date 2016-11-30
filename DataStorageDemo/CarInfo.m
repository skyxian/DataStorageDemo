//
//  CarInfo.m
//  DataStorageDemo
//
//  Created by x8f on 16/11/26.
//  Copyright © 2016年 xbk. All rights reserved.
//

#import "CarInfo.h"

#define carSqlite      @"carInfo.sqlite" //数据库路径
#define k_carInfo      @"carInfo"        //表格

//表格中的字符
#define k_userID       @"userID"
#define k_carID        @"carID"
#define k_carName      @"carName"
#define k_carNumber    @"carNumber"
#define k_carIsDefault @"carIsDefault"

@implementation CarInfo

//向数据库中添加或修改车辆信息
-(BOOL)saveCarDataByUserID:(NSString *)userid carID:(NSString *)carid
{
    BOOL retVal = NO;
    //获取数据库路径
    NSString *database_path = [self getFilePath];
    NSLog(@"%@",database_path);
    FMDatabase *database = [FMDatabase databaseWithPath:database_path];
    if ([database open]) {
        //判断数据库中是否有carInfo表格,不存在则创建
        if (![database tableExists:k_carInfo]) {
            NSString *createTableSql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' text,'%@' text,'%@' text,'%@' text,'%@' text)",k_carInfo,k_userID,k_carID,k_carName,k_carNumber,k_carIsDefault];
            [database executeUpdate:createTableSql];
        }
        //根据userid以及carid查询
        NSString *querySql = [NSString stringWithFormat:@"select * from %@ where %@ = '%@' and %@ = '%@'",k_carInfo,k_userID,userid,k_carID,carid];
        FMResultSet *rs = [database executeQuery:querySql];
        int row = 0;
        while ([rs next]) {
            row++;
        }//如果row大于0说明数据库有这个userid及carid对应的数据，则进行数据的修改(update)
        if (row > 0) {
            //update
            NSString *updateSql = [NSString stringWithFormat:@"update %@ set %@ = '%@',%@ = '%@',%@ = '%@' where %@ = '%@' and %@ = '%@'",k_carInfo,k_carName,self.carName,k_carNumber,self.carNumber,k_carIsDefault,[NSString stringWithFormat:@"%ld",self.carIsDefault],k_userID,self.userID,k_carID,self.carID];
            retVal = [database executeUpdate:updateSql];
        }else{//如果row等于0说明数据库没有有这个userid及carid对应的数据，则进行数据的插入(insert)
            //insert
            NSString *insertSql = [NSString stringWithFormat:@"insert into %@(%@,%@,%@,%@,%@) values ('%@','%@','%@','%@','%@')",k_carInfo,k_userID,k_carID,k_carName,k_carNumber,k_carIsDefault,userid,carid,self.carName,self.carNumber,[NSString stringWithFormat:@"%ld",self.carIsDefault]];
            retVal = [database executeUpdate:insertSql];
        }
        [database close];
    }
    return retVal;
}



//根据userid、carid删除某用户特定车辆信息
-(BOOL)removeCarDataByUserId:(NSString *)userid carID:(NSString *)carid
{
    BOOL retVal = NO;
    NSString *database_path = [self getFilePath];
    NSLog(@"%@",database_path);
    FMDatabase *database = [FMDatabase databaseWithPath:database_path];
    if ([database open]) {
        if ([database tableExists:@"carInfo"]) {
            NSString *deleteSql = [NSString stringWithFormat:@"delete from %@ where %@ = '%@' and %@ = '%@'",k_carInfo,k_userID,userid,k_carID,carid];
            retVal = [database executeUpdate:deleteSql];
        }
        [database close];
    }
    return retVal;
}


//删除userid对应的全部车辆
-(BOOL)removeAllCarData
{
    BOOL retVal = NO;
    NSString *database_path = [self getFilePath];
    NSLog(@"%@",database_path);
    FMDatabase *database = [FMDatabase databaseWithPath:database_path];
    if ([database open]) {
        if ([database tableExists:@"carInfo"]) {
            NSString *deleteSql = [NSString stringWithFormat:@"delete from %@ where %@ = '%@'",k_carInfo,k_userID,self.userID];
            retVal = [database executeUpdate:deleteSql];
        }
        [database close];
    }
    return retVal;
}


//查询某用户车辆信息(userid一定不能为空，carid存在则是查询特定车辆，不存在查询该用户所有车辆)
-(NSArray *)loadCarDateByUserID:(NSString *)userid carID:(NSString *)carid
{
    NSString *database_path = [self getFilePath];
    NSLog(@"%@",database_path);
    FMDatabase *database = [FMDatabase databaseWithPath:database_path];
    if ([database open]) {
        if ([database tableExists:@"carInfo"]) {
            NSString *querySql;
            if (carid) {
                querySql = [NSString stringWithFormat:@"select * from %@ where %@ = '%@' and %@ = '%@'",k_carInfo,k_userID,userid,k_carID,carid];
            }else{
                querySql = [NSString stringWithFormat:@"select * from %@ where %@ = '%@'",k_carInfo,k_userID,userid];
            }
//            NSString *querySql = [NSString stringWithFormat:@"select * from %@ where %@ = '%@'",k_carInfo,k_userID,userid];
            FMResultSet *rs = [database executeQuery:querySql];
            NSMutableArray *carListArr = [NSMutableArray new];
            while ([rs next]) {
                CarInfo *carinfo = [[CarInfo alloc]init];
                carinfo.userID = [rs stringForColumn:k_userID];
                carinfo.carID = [rs stringForColumn:k_carID];
                carinfo.carName = [rs stringForColumn:k_carName];
                carinfo.carNumber = [rs stringForColumn:k_carNumber];
                carinfo.carIsDefault = [[rs stringForColumn:k_carIsDefault] integerValue];
                [carListArr addObject:carinfo];
            }
            return carListArr;
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}

/*
 //查询某用户车辆信息(userid一定不能为空，carid存在则是查询特定车辆，不存在查询该用户所有车辆)
 -(NSArray *)loadCarDateByUserID:(NSString *)userid carID:(NSString *)carid;
 
 */

-(NSString *)getFilePath
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:carSqlite];
}



@end
