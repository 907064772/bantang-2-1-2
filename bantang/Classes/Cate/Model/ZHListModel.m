//
//  ZHListModel.m
//  bantang
//
//  Created by MS on 15-12-30.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import "ZHListModel.h"

@implementation ZHListModel







+ (NSDictionary *)objectClassInArray{
    return @{@"pics" : [Pics class], @"tags" : [Tags class],@"Dynamic":[Dynamic class],@"Author":[Author class]};
}

- (NSDictionary *)objectClassInArray
{
    return @{@"product" : [ZHListModel class],@"topic" : [ZHListModel class]};
}


@end



@implementation Dynamic

@end


@implementation Author

@end


@implementation Pics

@end


@implementation Tags

@end

