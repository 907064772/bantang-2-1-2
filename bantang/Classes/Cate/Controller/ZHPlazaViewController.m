//
//  ZHPlazaViewController.m
//  bantang
//
//  Created by MS on 16-1-18.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import "ZHPlazaViewController.h"
#import "ZHCateTableViewCell.h"
#import "MJRefresh.h"
#import "ZHWebViewController.h"
#import "KVNProgress.h"

#define zhcateCell @"ZHCateTableViewCell"

@interface ZHPlazaViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    int _page;
    
}

@end

@implementation ZHPlazaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = [NSMutableArray new];
    [self createTableView];

    
//    注册tableViewcell
    [_tableView registerNib:[UINib nibWithNibName:@"ZHCateTableViewCell" bundle:nil] forCellReuseIdentifier:zhcateCell];
 
    [self loadData];
}
/**
 *  创建tableView
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
    [manager POST:[NSString stringWithFormat:jump_url,self.idStr] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSDictionary *dic = responseObject[@"data"];
        [_dataArr addObjectsFromArray: [ZHListModel objectArrayWithKeyValuesArray:dic[@"post_list"]]];
        
        [_tableView reloadData];
        [KVNProgress dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"网络请求失败:%@",[error description]);
        [KVNProgress showErrorWithStatus:@"网络链接错误"];
    }];
    
    
    
}

#pragma mark - tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHCateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:zhcateCell forIndexPath:indexPath];
    cell.listModel = _dataArr[indexPath.row];
//    点击按钮是跳转界面
    [cell setBuyWebView:^(NSString *urlStr) {
        ZHWebViewController *WebView = [[ZHWebViewController alloc]init];
        WebView.urlStr = urlStr;
        [self.navigationController pushViewController:WebView animated:YES];
        
    }];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZHListModel *listModel = _dataArr[indexPath.row];
    
    
//    计算cell的高度
    return [ZHCateTableViewCell heightForRow:listModel];
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
