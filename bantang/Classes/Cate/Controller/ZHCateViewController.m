//
//  ZHCateViewController.m
//  bantang
//
//  Created by MS on 15-12-28.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import "ZHCateViewController.h"
#import "MJRefresh.h"
#import "ZHElementModel.h"
#import "ZHListModel.h"
#import "UIImageView+WebCache.h"
#import "ZHCateTableViewCell.h"
#import "UIButton+WebCache.h"
#import "ZHUIFactory.h"
#import "Masonry.h"
#import "ZHWebViewController.h"
#import "KVNProgress.h"

#define CATECELL @"cateCell"
@interface ZHCateViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    int _page;
}


@property(nonatomic,strong)NSMutableArray *tableViewDataArr;

@property(nonatomic,strong)NSMutableArray *picDataArr;
@property (strong, nonatomic)  UIButton *bigImageViewBtn;
@property (strong, nonatomic)  UIButton *secondImageViewBtn;
@property (strong, nonatomic)  UIButton *leftImageViewBtn;
@property (strong, nonatomic)  UIButton *rightImageViewBtn;






@property (strong, nonatomic)  UIView *headerView;

@end

@implementation ZHCateViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _picDataArr = [NSMutableArray new];
    _tableViewDataArr = [NSMutableArray new];
    self.view.backgroundColor = [UIColor colorWithRed:0.216 green:1.000 blue:0.230 alpha:1.000];
    
    [self createTableView];
    [self createTopBtn];
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;
        [self loadData];
    }];
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page ++;
        [self loadData];
    }];
    _tableView.footer.hidden = YES;
    [_tableView registerNib:[UINib nibWithNibName:@"ZHCateTableViewCell" bundle:nil] forCellReuseIdentifier:CATECELL];
    
    
    
}


-(void)createTopBtn{

    
    
    _bigImageViewBtn = [ZHUIFactory BunttonWithImageView:UIButtonTypeSystem andFrame:CGRectMake(0, 0, _headerView.width*0.6, _headerView.width*0.6) andTarget:self andAction:@selector(bigImageViewBtnClick:)];
    [_headerView addSubview:_bigImageViewBtn];
    
    _secondImageViewBtn = [ZHUIFactory BunttonWithImageView:UIButtonTypeSystem andFrame:CGRectMake(CGRectGetMaxX(_bigImageViewBtn.frame), 0, _headerView.width * 0.4, _headerView.width * 0.4) andTarget:self andAction:@selector(secondImageViewBtnClick:)];
    [_headerView addSubview:_secondImageViewBtn];
    
    
    _leftImageViewBtn = [ZHUIFactory BunttonWithImageView:UIButtonTypeSystem andFrame:CGRectMake(CGRectGetMaxX(_bigImageViewBtn.frame), CGRectGetMaxY(_secondImageViewBtn.frame), _secondImageViewBtn.width/2, _secondImageViewBtn.width/2) andTarget:self andAction:@selector(leftImageViewBtnClick:)];
    [_headerView addSubview:_leftImageViewBtn];
    
    
    _rightImageViewBtn = [ZHUIFactory BunttonWithImageView:UIButtonTypeSystem andFrame:CGRectMake(CGRectGetMaxX(_leftImageViewBtn.frame), CGRectGetMaxY(_secondImageViewBtn.frame), _secondImageViewBtn.width/2, _secondImageViewBtn.width/2) andTarget:self andAction:@selector(rightImageViewBtnClick:)];
    [_headerView addSubview:_rightImageViewBtn];
    
    
    
}
/**
 *  网络连接完成后设置图片
 */
-(void)setImage{
    for (int i = 0; i<_picDataArr.count; i++) {
        ZHElementModel *element = _picDataArr[i];
        switch (i) {
            case 0:
                [_bigImageViewBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:element.pic1] forState:UIControlStateNormal];
                break;
            case 1:
                [_secondImageViewBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:element.pic1] forState:UIControlStateNormal];
                break;
            case 2:
                [_leftImageViewBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:element.pic1] forState:UIControlStateNormal];
                break;
            case 3:
                [_rightImageViewBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:element.pic1] forState:UIControlStateNormal];
                break;
                
            default:
                break;
        }
    }
}

/**
 *  加载数据
 */
-(void)loadData{
    
    [KVNProgress showWithStatus:@"loading"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSLog(@"listModel:url:%@",[NSString stringWithFormat:self.urlStr,_page]);
    [manager POST:[NSString stringWithFormat:self.urlStr,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic =   responseObject[@"data"];
        if (_page == 0) {
            [_picDataArr removeAllObjects];
            [_tableViewDataArr removeAllObjects];
        }
        NSMutableArray *tempPicArr = [NSMutableArray new];
        for (NSDictionary *picDic in dic[@"element"]) {
            [tempPicArr addObject: [ZHElementModel objectWithKeyValues:picDic]];
            
        }
        [_picDataArr addObjectsFromArray:tempPicArr];
        
        [self setImage];
        
        NSMutableArray *tempTableViewArr = [NSMutableArray new];
        for (NSDictionary *listDic in dic[@"list"]) {
           [tempTableViewArr addObject:[ZHListModel objectWithKeyValues:listDic]];
        }
        [_tableViewDataArr addObjectsFromArray:tempTableViewArr];
        [_tableView.footer endRefreshing];
        [_tableView.header endRefreshing];
        [_tableView reloadData];
        [KVNProgress dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error description]);
        [_tableView.footer endRefreshing];
        [_tableView.header endRefreshing];
        [self.view addSubview: [ZHUIFactory errorImageWithImage:[UIImage imageNamed:@"netError"] andText:@"网络连接错误"]];
        [KVNProgress showErrorWithStatus:@"网络链接错误"];
    }];
    
    
}


/**
 *  创建uitableView
 */
-(void)createTableView{
    _headerView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH * 0.6)];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = _headerView;

    
    [self.view addSubview:_tableView];
    
    
    
}





-(void)refreshData{
//    开始刷新
    [_tableView.header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
    ZHCateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CATECELL forIndexPath:indexPath];

    ZHListModel *listModel = _tableViewDataArr[indexPath.row];
    cell.listModel = listModel;
    [cell setBuyWebView:^(NSString *urlStr) {
        if (self.showWebView) {
            self.showWebView(urlStr);
        }
        
        
    }];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHListModel *listModel = _tableViewDataArr[indexPath.row];
   
    
    
    return [ZHCateTableViewCell heightForRow:listModel];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _tableViewDataArr.count;
}

-(void)bigImageViewBtnClick:(UIButton *)btn{
    NSLog(@"bigImageViewBtnClick");
    
}
-(void)secondImageViewBtnClick:(UIButton *)btn{
    NSLog(@"secondImageViewBtnClick");
}
-(void)leftImageViewBtnClick:(UIButton *)btn{
    NSLog(@"leftImageViewBtnClick");
}
-(void)rightImageViewBtnClick:(UIButton *)btn{
    NSLog(@"rightImageViewBtnClick");
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
