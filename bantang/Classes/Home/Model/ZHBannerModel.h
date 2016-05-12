//
//  ZHBannerModel.h
//  bantang
//
//  Created by MS on 15-12-30.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHBaseModel.h"
@interface ZHBannerModel : ZHBaseModel

@property (nonatomic, copy) NSString *extend;

@property (nonatomic, copy) NSString *sub_title;


@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) NSString *pic_versions;

@property (nonatomic,copy) NSString * pic;
@property (nonatomic,copy) NSString * likes;

@property (nonatomic,copy) NSString * desc;

@property (nonatomic,copy) NSString * product_pic_host;
@property (nonatomic,copy) NSString * share_pic;
@property (nonatomic,copy) NSString * user_avatr_host;



#pragma mark - 清单的数据模型
@property(nonatomic,copy)NSString  *name;
@property(nonatomic,copy)NSString  *en_name;
@property(nonatomic,copy)NSString  *icon;




@end

