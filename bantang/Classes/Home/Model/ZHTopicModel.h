//
//  ZHTopicModel.h
//  bantang
//
//  Created by MS on 15-12-30.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHBaseModel.h"
@interface ZHTopicModel : ZHBaseModel


@property (nonatomic, assign) BOOL islike;

@property (nonatomic, copy) NSString *update_time;


@property (nonatomic, copy) NSString *pic;


@property (nonatomic, copy) NSString *likes;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *tags;

@end