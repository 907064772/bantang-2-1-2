//
//  ZHRelationCollectionViewController.h
//  bantang
//
//  Created by MS on 16-1-8.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHListModel.h"
@interface ZHRelationCollectionViewController : UICollectionViewController

@property(nonatomic,strong)ZHListModel *product;

@property(nonatomic,copy)void (^block)(ZHListModel *list);

@property (nonatomic,strong) NSArray *listModelArray;

@property (nonatomic,assign) BOOL favorite;

@end
