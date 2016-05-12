//
//  ZHDataModel.m
//  bantang
//
//  Created by MS on 16-1-4.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import "ZHDataModel.h"
#import "ZHListModel.h"

@implementation ZHDataModel




-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


- (NSDictionary *)objectClassInArray{

    return @{@"pics" : [Pics class],@"likes_list":[Likes class]};
}


@end


@implementation Likes

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end