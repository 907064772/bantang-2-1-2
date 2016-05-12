//
//  SearchDeatialController.h
//  sugar
//
//  Created by MS on 16-1-11.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"
@interface SearchDeatialController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) SearchModel *sm;
@property(nonatomic,assign) int idStr;

/**
 *  搜索内容
 */
@property(nonatomic,copy)NSString  *keyword;

- (id)initWithAm:(SearchModel *)sm;
/**
 *  解析数据
 *
 *  @param responseObject <#responseObject description#>
 */
-(void)jiexiData:(id )responseObject;


/**
 *  加载搜索数据
 */
-(void)loadSearchData:(NSString *)inputText;
@end


