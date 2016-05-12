//
//  ZHRecommendTableViewController.m
//  bantang
//
//  Created by MS on 16-1-6.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import "ZHRecommendTableViewController.h"
#import "ZHCateTableViewCell.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "ZHListModel.h"
#import "ZHElementModel.h"
#import "ZHWebViewController.h"
#import "KVNProgress.h"
#define ZHRECOMMENED @"ZHCateTableViewCell"
@interface ZHRecommendTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *tableViewDataArr ;
@property(nonatomic,strong)UIButton *detailBtn;

@end

@implementation ZHRecommendTableViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        _tableViewDataArr = [NSMutableArray new];
        _product = [NSMutableArray new];
        _dataModel = [NSMutableArray new];
        self.title = @"用户推荐";
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    设置tableView
    [self createTableView];
//    创建头视图
    [self createHeaderView];
    
//    给头视图设置frame
    [self setHeaderViewItem:_dataModel[0]];
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        加载数据
        [self loadData];
    }];
    
    
    [_tableView registerNib:[UINib nibWithNibName:@"ZHCateTableViewCell" bundle:nil] forCellReuseIdentifier:ZHRECOMMENED];
    
    
    
}
/**
 *  加载数据
 */
-(void)loadData{
    
    [KVNProgress showWithStatus:@"loading"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

   
    [manager POST:[NSString stringWithFormat:recommend_url,self.idStr] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic =   responseObject[@"data"];
        [_tableViewDataArr removeAllObjects];
        
        NSMutableArray *tempTableViewArr = [NSMutableArray new];
        for (NSDictionary *listDic in dic[@"list"]) {
            [tempTableViewArr addObject:[ZHListModel objectWithKeyValues:listDic]];
        }
        [_tableViewDataArr addObjectsFromArray:tempTableViewArr];
        [_tableView.header endRefreshing];
        [_tableView reloadData];
        [KVNProgress dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error description]);
        [_tableView.header endRefreshing];
        [KVNProgress showErrorWithStatus:@"网络链接错误"];
    }];
    
    
}

/**
 *  设置tableView
 */
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

}

#pragma mark - tableView的代理方法

/**
 *  返回cellSection
 *
 *  @param tableView <#tableView description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataModel.count;
}

/**
 *  返回cellRow
 *
 *  @param tableView <#tableView description#>
 *  @param section   <#section description#>
 *
 *  @return <#return value description#>
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableViewDataArr.count;
    
}

/**
 *  设置tableViewcell
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZHCateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZHRECOMMENED forIndexPath:indexPath];
    cell.listModel = _tableViewDataArr[indexPath.row];
    [cell setBuyWebView:^(NSString *urlStr) {
        ZHWebViewController *webView = [ZHWebViewController new];
        webView.urlStr = urlStr;
        [self.navigationController pushViewController:webView animated:YES];
    }];
    
    return cell;
    
}

/**
 *  返回tableViewcell的高度
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHListModel *listModel = _tableViewDataArr[indexPath.row];
    
    return [ZHCateTableViewCell heightForRow:listModel];
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _detailBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _detailBtn.frame = CGRectMake(0, CGRectGetMaxY(self.descLabel.frame)+5, WIDTH, 50);
    [_detailBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_detailBtn setTitle:@"点击返回买买精选" forState:UIControlStateNormal];
    _detailBtn.backgroundColor = [UIColor colorWithWhite:0.928 alpha:1.000];
    [_detailBtn addTarget:self action:@selector(detailBtnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return _detailBtn;
    
}

-(void)detailBtnBtnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
    
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
