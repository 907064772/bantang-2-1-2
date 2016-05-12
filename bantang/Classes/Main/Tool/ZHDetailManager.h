//
//  ZHDetailManager.h
//  bantang
//
//  Created by MS on 16-1-15.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHDataModel.h"


@interface ZHDetailManager : NSObject

/**
 *  添加一个类方法
 *
 *  @param instancetype <#instancetype description#>
 *
 *  @return <#return value description#>
 */

+(instancetype)defaultManager;
/**
 *  插入一个模型记录的数据
 *
 *  @param dm <#dm description#>
 */
-(void)insertDataWithModel:(ZHBaseModel *)dm;
/**
 *  更新某一条数据
 *
 *  @param dm    <#dm description#>
 *  @param index <#index description#>
 */
-(void)updateModel:(ZHBaseModel *)dm forIndex:(NSInteger)index;
/**
 *  查询所有数据
 *
 *  @return <#return value description#>
 */
-(NSArray *)allModel;

/**
 *  删除一条用户数据
 *
 *
 */
- (void)deleteUserWithId:(NSString *)idStr;



@end
