//
//  ZHListManager.m
//  bantang
//
//  Created by MS on 16-1-15.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import "ZHListManager.h"
#import "FMDB.h"
#
@interface ZHListManager (){
    //    专门用来操作数据库的类
    FMDatabase *_fmdb;
    NSLock *_lock;
}



@end
@implementation ZHListManager

- (instancetype)init{
    self = [super init];
    if (self) {
        //       数据库路径(必须保证文件夹是存在的)
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/list.db"];
        //        初始化操作数据库的对象
        _fmdb = [[FMDatabase alloc]initWithPath:path];
        //        打开数据库,(如果数据库不存在,就先创建再打开)
        BOOL isOpen = [_fmdb open];
        //        判读打开状态
        if (isOpen) {
            //           create table if not exists , 如果表不存在,就创建一个,(存在就不做任何操作)
            //            userInfo()表名
            //            表名后面的小括号里就是字段信息,任意两个字段用逗号隔开
            //            字段中,第一个单词是字段名,第二个单词是字段类型, primary key 主键 不允许重复,autoincrement 自动增长 从1开始
            NSString *createSql = @"create table if not exists userInfo(id integer primary key autoincrement,idStr text not NULL,title text not NULL,price integer default 0,image blob)";
            //            执行sql语句(增删改,都用executeUpdate方法),在fmdb看来增删改都是更新
            BOOL isCreate = [_fmdb executeUpdate:createSql];
            if (!isCreate) {
                //                如果sql执行失败了.就打印错误信息
                NSLog(@"create = %@",_fmdb.lastErrorMessage);
            }
        }
        
    }
    return self;
}



+(instancetype)defaultManager{
    static ZHListManager *dm = nil;
    @synchronized(self){
        if (!dm) {
            dm = [ZHListManager new];
        }
    }
    return dm;
}
-(void)insertDataWithModel:(ZHListModel *)bm{
    //    插入sql语句
    NSString *insertSql = @"insert into userInfo(idStr,title,price,image) values(?,?,?,?)";
    //    执行sql语句,并补全参数,(参数必须为对象类型)
    BOOL isInsert = [_fmdb executeUpdate:insertSql,bm.id,bm.author.nickname,bm.price,bm.image];
    if (!isInsert) {
        NSLog(@"insert:%@",_fmdb.lastErrorMessage);
    }
    
}

-(void)updateModel:(ZHListModel *)dm forIndex:(NSInteger)index{
    NSString *updateSql = @"update userInfo set idStr=?,title=?,price=?,image=? where id=?";
    BOOL isUpdate =  [_fmdb executeUpdate:updateSql,dm.id,dm.author.nickname,dm.price,dm.image,[NSNumber numberWithInteger:index]];
    if (!isUpdate) {
        NSLog(@"updateModel:%@",_fmdb.lastErrorMessage);
    }
    
    
    
}
-(NSMutableArray *)allModel{
    NSString * selectSql = @"select * from userInfo";
    //    执行查询sql
    FMResultSet * resultSet = [_fmdb executeQuery:selectSql];
    NSMutableArray *tmpArr = [NSMutableArray array];
    while ([resultSet next]) {
        //        遍历查询结果
        ZHListModel *dm = [ZHListModel new];
        dm.id = [resultSet stringForColumn:@"idStr"];
        dm.title = [resultSet stringForColumn:@"title"];
        dm.price = [resultSet stringForColumn:@"price"];
        dm.image = [resultSet dataForColumn:@"image"];
        
        [tmpArr addObject:dm];
    }
    
    return tmpArr;
}


-(void)deleteUserWithId:(NSString *)idStr{
    NSString * query = [NSString stringWithFormat:@"DELETE FROM userInfo WHERE idStr = '%@'",idStr];
    if (![_fmdb executeUpdate:query]) {
        NSLog(@"%@",[_fmdb lastErrorMessage]);
    };
}
@end
