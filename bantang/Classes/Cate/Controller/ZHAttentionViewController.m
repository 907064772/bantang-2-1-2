//
//  ZHAttentionViewController.m
//  bantang
//
//  Created by MS on 15-12-29.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import "ZHAttentionViewController.h"
#import "MJExtension.h"
#import "PageTwoCell.h"
#import "ZHListModel.h"
#import "KVNProgress.h"
#define PageTC @"PageTwoCell"

@interface ZHAttentionViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    
    
}

@end

@implementation ZHAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray new];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.317 green:1.000 blue:0.985 alpha:1.000];
    
    //创建tableView
    [self createTableView];

    [_tableView registerNib:[UINib nibWithNibName:@"PageTwoCell" bundle:nil] forCellReuseIdentifier:PageTC];
    
    
    
    
}

/**
 *  加载数据
 */
-(void)loadData{
    
    [KVNProgress showWithStatus:@"loading"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = responseObject[@"data"];
        
        NSMutableArray *tempArr = [NSMutableArray new];
        for (NSDictionary *listDic in dic[@"rec_groups"]) {
            [tempArr addObject:[ZHListModel objectWithKeyValues:listDic]];
        }
        
        [_dataArr addObjectsFromArray:tempArr];
        [_tableView reloadData];
        
        [KVNProgress dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"网络请求失败:%@",[error description]);
        [KVNProgress showErrorWithStatus:@"网络链接错误"];
    }];


    
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



#pragma mark - tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PageTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:PageTC forIndexPath:indexPath];
    cell.listModel = _dataArr[indexPath.row];
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZHListModel *listModel = _dataArr[indexPath.row];
    if (self.showVC) {
        _showVC(listModel.id,listModel.name);
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
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
