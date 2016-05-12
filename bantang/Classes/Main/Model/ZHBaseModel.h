//
//  ZHBaseModel.h
//  bantang
//
//  Created by MS on 16-1-6.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHBaseModel : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic,copy) NSString * price;

@property(nonatomic,strong)NSData *image;

@end
