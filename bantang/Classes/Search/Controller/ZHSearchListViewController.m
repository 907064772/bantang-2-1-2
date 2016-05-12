//
//  ZHSearchListViewController.m
//  bantang
//
//  Created by MS on 16-1-12.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import "ZHSearchListViewController.h"
#import "ZHSearchListCollectionViewCell.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "ZHBannerModel.h"
#define ZHSLCVCell @"ZHSearchListCollectionViewCell"
@interface ZHSearchListViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray *dataArr;


@end

@implementation ZHSearchListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray new];
    // Do any additional setup after loading the view.
    
    
    
    //创建collectionView
    [self createCollectionView];
    
}
/**
 *  加载数据
 */
-(void)loadData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:self.idStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary *dic in responseObject[@"data"]) {
            
            [_dataArr addObject:[ZHBannerModel objectWithKeyValues:dic]];

            
        }
        [self.collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error description]);
        
    }];
    
}



/**
 *  创建集合视图
 */
-(void)createCollectionView{
    
    CGFloat margin = (WIDTH - 65*3)/4;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(65, 125);
    flowLayout.minimumLineSpacing = margin;
    flowLayout.minimumInteritemSpacing = margin;
    flowLayout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZHSearchListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ZHSLCVCell];
    
    
    
    
}



#pragma mark - collectionView代理方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZHSearchListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZHSLCVCell forIndexPath:indexPath];
    cell.bm = _dataArr[indexPath.row];
    
    
    return cell;
    
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ZHBannerModel *banner = _dataArr[indexPath.row];
    if (self.showVC) {
        self.showVC(banner.id,banner.name);
    }
    
    
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
