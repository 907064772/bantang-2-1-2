//
//  ZHProductViewController.m
//  bantang
//
//  Created by MS on 16-1-19.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import "ZHProductViewController.h"
#import "ZHRelationCollectionViewCell.h"
#import "ZHGoodsDetailViewController.h"
#import "KVNProgress.h"
#define product @"ZHRelationCollectionViewCell"
@interface ZHProductViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    UICollectionView *_collection;
    NSMutableArray *_dataArr;
    
}

@end

@implementation ZHProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray new];
    // Do any additional setup after loading the view.
    
    [self createCollection];
    if (self.urlStr) {
        [self loadData];
    }
    
    
}
/**
 *  加载数据
 */
-(void)loadData{
    
    [KVNProgress showWithStatus:@"loading"];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [manger POST:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_dataArr removeAllObjects];
        [_dataArr addObjectsFromArray: [ZHListModel objectArrayWithKeyValuesArray:responseObject[@"data"]]];
        [_collection reloadData];
        if (self.block) {
            self.block();
        }
        [KVNProgress dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"首页product:%@",[error description]);
        [KVNProgress showErrorWithStatus:@"网络链接错误"];
    }];
    
}


/**
 *  创建collection
 */
-(void)createCollection{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collection = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    _collection.height -= 64;
    _collection.dataSource = self;
    _collection.delegate = self;
    _collection.backgroundColor = [UIColor whiteColor];
    
    [_collection registerNib:[UINib nibWithNibName:@"ZHRelationCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:product];
    
    [self.view addSubview:_collection];
    
    
}


#pragma mark - collection的代理方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZHRelationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:product forIndexPath:indexPath];
    
    cell.listModel = _dataArr[indexPath.row];
    
    return  cell;
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  _dataArr.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((WIDTH - 15)/2 , (WIDTH - 15)/2 + 40);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    ZHListModel *listModel = _dataArr[indexPath.row];
    ZHGoodsDetailViewController *goods = [ZHGoodsDetailViewController new];
    goods.idStr = listModel.id;
    goods.title = listModel.title;
    [self.navigationController pushViewController:goods animated:YES];
    
    if (self.showVC) {
        self.showVC(listModel.id);
    }
    
    
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 2, 0, 2);
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
