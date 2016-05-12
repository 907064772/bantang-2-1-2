//
//  ZHSubViewController.m
//  bantang
//
//  Created by MS on 15-12-28.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import "ZHSubViewController.h"
#import "MJRefresh.h"
#import "ZHTopPicCell.h"
#import "NetAPI.h"
#import "ZHTopicModel.h"
#import "MJExtension.h"
#import "ZHElementModel.h"
#import "ZHBtnScrollView.h"
#import "ZHDetailViewController.h"
#define TOPPICCELL @"toppic"
@interface ZHSubViewController ()<UITableViewDelegate,UITableViewDataSource>{
    int _page;
}
/**
 *  数据源
 */
@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,strong)NSMutableArray *entryArr;


@end

@implementation ZHSubViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArr = [NSMutableArray new];
        _entryArr = [NSMutableArray new];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
 
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.


    
    
    
    [self createTableView];
    [self.tableView  registerNib:[UINib nibWithNibName:@"ZHTopPicCell" bundle:nil] forCellReuseIdentifier:TOPPICCELL];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;
        [self loadData];
    }];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page += 1;
        [self loadData];
    }];
    self.tableView.footer.hidden = YES;

    
}
/**
 *  进入刷新状态
 */
-(void)refreshData{
    [self.tableView.header beginRefreshing];
}



/**
 *  创建tableView
 */
-(void)createTableView{
    //    设置tableView的frame
    CGRect frame = self.view.bounds;
    self.view.y = 230;
    frame.size.height -= 49+40+64;
    self.tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    
}

/**
 *  开始网络请求
 */
-(void)loadData{

    AFHTTPRequestOperationManager*manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:self.urlStr,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        网络请求成功开始解析数据
        NSDictionary *data = responseObject[@"data"];
        //        先让数组中移除所有的元素,在进行下拉刷新
        if (_page == 0) {
            [_dataArr removeAllObjects];
        }
        NSMutableArray *tempArr = [NSMutableArray new];
        for (NSDictionary *dic in data[@"topic"]) {
             ZHTopicModel *top = [ZHTopicModel objectWithKeyValues:dic];
            [tempArr addObject:top];
        }
        [_dataArr addObjectsFromArray:tempArr];
        NSMutableArray *entrTempArr = [NSMutableArray new];
        for (NSDictionary *entryDic in data[@"entry_list"]) {
            [entrTempArr addObject:  [ZHElementModel objectWithKeyValues:entryDic]];
        }
        [_entryArr addObjectsFromArray:entrTempArr];

        
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",[error description]);
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHTopPicCell *cell = [tableView dequeueReusableCellWithIdentifier:TOPPICCELL forIndexPath:indexPath];
    ZHTopicModel *top = _dataArr[indexPath.row];
    
    cell.topic = top;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZHTopicModel *top = _dataArr[indexPath.row];
    ZHDetailViewController *detail = [ZHDetailViewController new];
    detail.idStr = top.id;
//    这里跳转控制器的功能要放在上一个主控制器里面
    
    if (self.showSubViews) {
        self.showSubViews(detail);
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [ZHTopPicCell heightForRow];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
