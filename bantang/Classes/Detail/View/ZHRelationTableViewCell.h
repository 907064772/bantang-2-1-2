//
//  ZHRelationTableViewCell.h
//  bantang
//
//  Created by MS on 16-1-8.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHListModel.h"
@interface ZHRelationTableViewCell : UITableViewCell

/**
 *  用来存储tableController给的数据模型,
 */
@property(nonatomic,strong)ZHListModel *product;
/**
 *  内容视图中的collectionController返回出来的数据模型
 */
@property(nonatomic,strong)ZHListModel *list;

/**
 *  展示视图控制器的block回调
 */
@property(nonatomic,copy)void (^showVC)(ZHListModel *list);



@end
