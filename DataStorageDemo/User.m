//
//  User.m
//  DataStorageDemo
//
//  Created by x8f on 16/11/25.
//  Copyright © 2016年 xbk. All rights reserved.
//

#import "User.h"

#define kUserName      @"userName"
#define kUserPassWord  @"userPassWord"
@implementation User

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userName forKey:kUserName];
    [aCoder encodeObject:self.userPassWord forKey:kUserPassWord];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.userName = [aDecoder decodeObjectForKey:kUserName];
        self.userPassWord = [aDecoder decodeObjectForKey:kUserPassWord];
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone
{
    User *user = [[self class]allocWithZone:zone];
    user.userName = [self.userName copyWithZone:zone];
    user.userPassWord = [self.userPassWord copyWithZone:zone];
    return user;
}




@end
