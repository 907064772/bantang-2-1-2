//
//  SearchModel.h
//  sugar
//
//  Created by MS on 16-1-10.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject

@property (nonatomic,strong) NSString *name;

@property (nonatomic,assign) int id;

@property (nonatomic,strong) NSString *icon;

@property (nonatomic,strong) NSArray * subclass;


@end
