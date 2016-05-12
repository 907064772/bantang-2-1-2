//
//  ZHMessageViewController.m
//  bantang
//
//  Created by MS on 15-12-28.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import "ZHMessageViewController.h"
#import "ZHHeaderView.h"
#import "ZHElementModel.h"
#import "MJRefresh.h"
#import "ZHMessageTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ZHMessageDetailViewController.h"
#import "ZHHotActiveViewController.h"

#define MESSAGECELL @"MessageTableViewCell"
@interface ZHMessageViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    ZHHeaderView *_headeTableView;
}

@property(nonatomic,strong)UIView *headerView;

@property(nonatomic,strong)NSMutableArray *dataArr;




@end

@implementation ZHMessageViewController

- (void)viewDidLoad {
    _dataArr = [NSMutableArray new];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTableView];
    
    
    [_tableView registerNib:[UINib nibWithNibName:@"ZHMessageTableViewCell" bundle:nil] forCellReuseIdentifier:MESSAGECELL];
    

    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    [_tableView.header beginRefreshing];
    
}
/**
 *  加载数据
 */
-(void)loadData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:latest_url,arc4random()%5] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
#warning 只解析了element,没有解析消息
        NSDictionary *dataDic = responseObject[@"data"];
        for (NSDictionary *elementDic in dataDic[@"topic"]) {
            [_dataArr addObject:[ZHElementModel objectWithKeyValues:elementDic]];
            
        }
        
        [_tableView.header endRefreshing];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_tableView.header endRefreshing];
        NSLog(@"%@",[error description]);
    }];
    
    
}

/**
 *  创建头视图
 */
-(void)createHeaderView{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 220)];
    _tableView.tableHeaderView = _headerView;
    
    _headeTableView = [[ZHHeaderView alloc]initWithFrame:_headerView.frame];
    
    
    __weak ZHMessageViewController *weakSelf = self;
    [_headeTableView setShowVC:^{
        ZHMessageDetailViewController *message = [ZHMessageDetailViewController new];
        [weakSelf.navigationController pushViewController:message animated:YES];
    }];
    
    [_headerView addSubview:_headeTableView];
    
}

/**
 *  创建tableView
 */
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self createHeaderView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MESSAGECELL forIndexPath:indexPath];
    ZHElementModel *element = _dataArr[indexPath.row];
    cell.elementModel = element;
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
//    ZHHotActiveViewController *hot = [ZHHotActiveViewController new];
//    ZHElementModel *element = _dataArr[indexPath.row];
//    hot.title = element.title;
//    hot.type = element.type;
//    hot.extend = element.extend;
//    [self.navigationController pushViewController:hot animated:YES];
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"热门活动";
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
