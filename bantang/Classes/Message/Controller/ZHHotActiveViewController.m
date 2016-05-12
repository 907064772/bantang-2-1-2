//
//  ZHHotActiveViewController.m
//  bantang
//
//  Created by MS on 16-1-18.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import "ZHHotActiveViewController.h"
#import "ZHListModel.h"
#import "ZHCateTableViewCell.h"
#import "KVNProgress.h"

#define  zhcateCell @"ZHCateTableViewCell"
@interface ZHHotActiveViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSMutableArray *_dataArr;
}

@end

@implementation ZHHotActiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray new];
    // Do any additional setup after loading the view.
    
    [self createTableView];
    [_tableView registerNib:[UINib nibWithNibName:@"ZHCateTableViewCell" bundle:nil] forCellReuseIdentifier:zhcateCell];
    
    [self loadData];
}
/**
 * 创tableView
 */
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _tableView.height -= 64;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}
/**
 *  加载数据
 */
-(void)loadData{
    [KVNProgress showWithStatus:@"loading"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (![_type isEqualToString:@"post_list_tag"]) {
        _urlStr = [NSString stringWithFormat:plaza_btn_url,_extend];
    }else {
        _urlStr = [NSString stringWithFormat:plaza_yijia_url,_extend];
    }
    [manager POST:_urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = responseObject[@"data"];
        
        NSMutableArray *tempArr = [NSMutableArray new];
        for (NSDictionary *listDic in dic[@"list"]) {
            [tempArr addObject:[ZHListModel objectWithKeyValues:listDic]];
        }
        [_dataArr addObjectsFromArray:tempArr];
        [_tableView reloadData];
        [KVNProgress dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"网络请求失败");
        [KVNProgress showErrorWithStatus:@"网络连接错误"];
    }];

    
}


#pragma mark - tableView的代理方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHCateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:zhcateCell forIndexPath:indexPath];
    ZHListModel *listModel = _dataArr[indexPath.row];
    
    cell.listModel = listModel;
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHListModel *listModel = _dataArr[indexPath.row];
    //    计算cell的高度
    return [ZHCateTableViewCell heightForRow:listModel];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
