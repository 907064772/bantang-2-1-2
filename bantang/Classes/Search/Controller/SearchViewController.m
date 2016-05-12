//
//  SearchViewController.m
//  sugar
//
//  Created by MS on 16-1-10.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "SearchViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "AFNetworking.h"
#import "NetAPI.h"
#import "SearchModel.h"
#import "MJExtension.h"
#import "SearchCell.h"
#import "UIImageView+WebCache.h"
#import "SearchDeatialController.h"

@interface SearchViewController () <UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)NSMutableArray *leftArr;
@end

@implementation SearchViewController {
    
    NSMutableArray *_leftArr;
    NSMutableArray *_rightArr;
    NSInteger _selectTableIndex;
}

- (NSMutableArray *)leftArr
{
    if (!_leftArr) {
        _leftArr = [[NSMutableArray alloc] init];
    }
    return _leftArr;
}

/**
 *  默认左右加载第一页
 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    刷新视图上的图标
    [self.collectionView reloadData];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"aaa"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SearchCell" bundle:nil] forCellWithReuseIdentifier:@"aaa"];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"topic_back_icon" highImageName:@"topic_back_icon" target:self action:@selector(leftClick:)];
    
    
    
    
}

/**
 *  返回按钮
 */
- (void)leftClick:(UIBarButtonItem *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  加载数据
 */
-(void)loadData{
    
    AFHTTPRequestOperationManager*manager = [AFHTTPRequestOperationManager manager];
    [manager POST:self.idStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *data = responseObject[@"data"];
        [self.leftArr addObjectsFromArray:[SearchModel objectArrayWithKeyValuesArray:data]];
        [self.tableView reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSInteger selectedIndex = 0;
            
            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
            [self.tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            
        });
        [self.collectionView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",[error description]);
    }];
}

#pragma mark -tableView实现方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.leftArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaa" forIndexPath:indexPath];
    SearchModel *sm = self.leftArr[indexPath.row];
    cell.textLabel.text = sm.name;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = [UIColor colorWithRed:0.854 green:0.876 blue:0.886 alpha:1.000];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    [cell.textLabel setTextColor:[UIColor colorWithWhite:0.406 alpha:1.000]];
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    [cell.textLabel setFont:[UIFont systemFontOfSize:13]];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _selectTableIndex = indexPath.row;
    [self.collectionView reloadData];
}

#pragma mark -collection实现方法
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"aaa" forIndexPath:indexPath];
    SearchModel *sm = self.leftArr[_selectTableIndex];
    
    SearchModel *search = sm.subclass[indexPath.row];
    [cell.icon sd_setImageWithURL:[NSURL URLWithString:search.icon]];
    cell.nameLabel.text = search.name;
    return cell;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.leftArr.count > 0) {
        SearchModel *model = self.leftArr[_selectTableIndex];
        return model.subclass.count;
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (([UIScreen mainScreen].bounds.size.width-100)-50)/3;
    return CGSizeMake(width, width+25);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return  UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchModel *sm = self.leftArr[_selectTableIndex];
    SearchModel *search = sm.subclass[indexPath.row];
    if (self.showVC) {
        self.showVC(search.id,search.name);
    }
    
    
    

}


@end
