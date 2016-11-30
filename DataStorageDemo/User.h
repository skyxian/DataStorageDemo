//
//  User.h
//  DataStorageDemo
//
//  Created by x8f on 16/11/25.
//  Copyright © 2016年 xbk. All rights reserved.
//





/*
 *
 *   本类用于NSKeyedArchiver的演示
 *   归档（存数）在LoginVC中演示
 *   解档（取数）以及删除数据在KeyedArchiverVC中
 *
 */


#import <Foundation/Foundation.h>

//要实现对数据模型的归档，需要我们实现NScoding协议，NScoping（copy协议是为了模型数据可以复制，对于归档而言，不是必须要实现）
@interface User : NSObject<NSCoding,NSCopying>
@property(nonatomic, strong)NSString *userName;
@property(nonatomic, strong)NSString *userPassWord;
@end
