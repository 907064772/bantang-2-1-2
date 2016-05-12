//
//  SearchDeatialController.m
//  sugar
//
//  Created by MS on 16-1-11.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "SearchDeatialController.h"
#import "UIBarButtonItem+Extension.h"
#import "ZHBannerModel.h"
#import "SearchCateCell.h"
#import "AFNetworking.h"
#import "NSObject+MJKeyValue.h"
#import "UIImageView+WebCache.h"
#import "NetAPI.h"
#import "KVNProgress.h"
#import "ZHGoodsDetailViewController.h"

@interface SearchDeatialController () <UITableViewDelegate,UITableViewDataSource> {
    
    NSMutableArray *_dataArr;
}

@end

@implementation SearchDeatialController

- (id)initWithAm:(SearchModel *)sm {
    self = [super init];
    if (self) {
        self.sm = sm;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [[NSMutableArray alloc]init];
    
    [self loadData];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"topic_back_icon" highImageName:@"topic_back_icon" target:self action:@selector(leftClick:)];
    [_tableView  registerNib:[UINib nibWithNibName:@"SearchCateCell" bundle:nil] forCellReuseIdentifier:@"aaa"];
}

/**
 *  返回按钮
 */
- (void)leftClick:(UIBarButtonItem *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadData {
    
    [KVNProgress showWithStatus:@"loading"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:searchDetail_url,self.idStr] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self jiexiData:responseObject];
        [KVNProgress dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"网络请求失败");
        [KVNProgress showErrorWithStatus:@"网络链接错误"];
    }];
}
/**
 *  解析数据
 */
-(void)jiexiData:(id )responseObject{
    NSDictionary *dic = responseObject[@"data"];
    
    NSMutableArray *tempArr = [NSMutableArray new];
    for (NSDictionary *listDic in dic[@"list"]) {
        [tempArr addObject:[ZHBannerModel  objectWithKeyValues:listDic]];
    }
    
    [_dataArr addObjectsFromArray:tempArr];
    [_tableView reloadData];
}

-(void)loadSearchData:(NSString *)inputText{
    [KVNProgress showWithStatus:@"loading"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:search_list_url,inputText] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_dataArr removeAllObjects];
        [_dataArr addObjectsFromArray:[ZHBannerModel  objectArrayWithKeyValuesArray:responseObject[@"data"]]];
        [_tableView reloadData];
        
        [KVNProgress dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error description]);
        [KVNProgress showErrorWithStatus:@"网络错误"];
        
    }];
    
}


#pragma mark -tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchCateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaa" forIndexPath:indexPath];
    ZHBannerModel *am = _dataArr[indexPath.row];
    [cell.bigImage sd_setImageWithURL:[NSURL URLWithString:am.pic]];
    cell.nameLabel.text = am.title;
    cell.priceLabel.text = [NSString stringWithFormat:@"¥%@",am.price];
    cell.contentLabel.text = am.desc;
    cell.likeLabel.text =[NSString stringWithFormat:@"%@人推荐",am.likes];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZHBannerModel *banner = _dataArr[indexPath.row];
    ZHGoodsDetailViewController *goodsVC = [ZHGoodsDetailViewController new];
    goodsVC.idStr = banner.id;
    [self.navigationController pushViewController:goodsVC animated:YES];
    
}





@end
