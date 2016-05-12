//
//  ZHDataModel.h
//  bantang
//
//  Created by MS on 16-1-4.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHBaseModel.h"
@class at_user,Product;
@interface ZHDataModel : ZHBaseModel



@property (nonatomic, assign) NSInteger category;

@property (nonatomic, copy) NSString *likes;

@property (nonatomic, copy) NSString *tags;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *pics;

@property (nonatomic, copy) NSString *tag_ids;

@property (nonatomic, copy) NSString *share_pic;

@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, copy) NSString *user_avatr_host;

@property (nonatomic, assign) BOOL islike;

@property (nonatomic, copy) NSString *product_pic_host;

@property (nonatomic,copy)NSString * topic_id;

@property(nonatomic,copy)NSString  *url;

@property(nonatomic,copy)NSString  *iscomments;

@property(nonatomic,copy)NSString  *comments;

@property(nonatomic,copy)NSString  *item_id;

@property(nonatomic,copy)NSString  *platform;

@property(nonatomic,strong)NSMutableArray * pic;

@property(nonatomic,strong)NSMutableArray  *likes_list;

@property(nonatomic,strong)ZHDataModel *product;



#pragma mark - product的模型


@property(nonatomic,copy)NSString  *category_id;


#pragma mark - comment_list的模型


@property(nonatomic,copy)NSString  *user_id;

@property(nonatomic,copy)NSString  *nickname;

@property(nonatomic,copy)NSString  *avatar;

@property(nonatomic,copy)NSString  *conent;

@property(nonatomic,copy)NSString  *dateline;

@property(nonatomic,copy)NSString  *datestr;

@property(nonatomic,copy)NSString  *praise;

@property(nonatomic,copy)NSString  *is_praise;

@property(nonatomic,copy)NSString  *is_hot;

@property(nonatomic,copy)NSString  *is_official;

@property(nonatomic,strong)at_user *at_user;






@end

@interface Likes : ZHBaseModel
@property(nonatomic,copy)NSString  *u;
@property(nonatomic,copy)NSString  *a;
@property(nonatomic,copy)NSString  *user_id;
@property(nonatomic,copy)NSString  *nickname;
@property(nonatomic,copy)NSString  *avatar;
@end

