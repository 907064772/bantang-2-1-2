//
//  ZHListModel.h
//  bantang
//
//  Created by MS on 15-12-30.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHBaseModel.h"
@class Author,Dynamic,Product;
@interface ZHListModel : ZHBaseModel


@property(nonatomic,copy)NSString  *name;

@property(nonatomic,copy)NSString  *pic1;

@property(nonatomic,copy)NSString  *pic2;

@property (nonatomic, copy) NSString *relation_id;

@property (nonatomic, copy) NSString *is_recommend;

@property (nonatomic, strong) NSArray *comments;

@property (nonatomic, strong) Author *author;

@property (nonatomic, copy) NSString *datestr;

@property (nonatomic, strong) NSArray *product;

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, strong) Dynamic *dynamic;


@property (nonatomic, copy) NSString *author_id;

@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, copy) NSString *publish_time;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *i_tags;

@property (nonatomic, strong) NSArray *pics;

@property (nonatomic, copy) NSString *content;




#pragma mark - product的模型

@property(nonatomic,copy)NSString  *url;

@property(nonatomic,copy)NSString  *category_id;

@property(nonatomic,copy)NSString  *item_id;

@property(nonatomic,copy)NSString  *platform;

@property(nonatomic,copy)NSString  *desc;

@property(nonatomic,copy)NSString  *pic;

@property(nonatomic,copy)NSString  *type_id;

@property(nonatomic,copy)NSString  *category;

@property(nonatomic,copy)NSString  *likes;

@property(nonatomic,copy)NSString  *islike;

@property(nonatomic,strong)NSArray *topic;


#pragma mark - 首页product模型

@property(nonatomic,copy)NSString  *good_id;

@property(nonatomic,copy)NSString  *dateline;

@end

@interface Dynamic : ZHBaseModel

@property (nonatomic, copy) NSString *comments;

@property (nonatomic, strong) NSArray *likes_users;

@property (nonatomic, assign) BOOL is_comment;

@property (nonatomic, copy) NSString *praises;

@property (nonatomic, copy) NSString *views;

@property (nonatomic, copy) NSString *likes;

@property (nonatomic, assign) BOOL is_collect;

@property (nonatomic, copy) NSString *attentions;

@end

@interface Author : ZHBaseModel

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger is_official;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, assign) NSInteger attention_type;

@property (nonatomic, copy) NSString *user_cover;

@end

@interface Pics : ZHBaseModel

@property (nonatomic, copy) NSString *tags;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@property(nonatomic,copy)NSString  *p;

@property(nonatomic,copy)NSString  *w;

@property(nonatomic,copy)NSString  *h;

@property(nonatomic,copy)NSString  *pic;





@end

@interface Tags : ZHBaseModel


@property (nonatomic, copy) NSString *name;

@end

