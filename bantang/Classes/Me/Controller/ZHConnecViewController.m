//
//  ZHConnecViewController.m
//  bantang
//
//  Created by MS on 16-1-19.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import "ZHConnecViewController.h"
#import "ZHListManager.h"
#import "ZHListModel.h"
#import "ZHProductViewController.h"
#import "ZHRelationCollectionViewController.h"
@interface ZHConnecViewController (){
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    ZHRelationCollectionViewController *Relation;
}

@end

@implementation ZHConnecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//
    _dataArr = [[ZHListManager defaultManager]allModel];
//    [self createTableView];
    UICollectionViewLayout *layout = [[UICollectionViewLayout alloc]init];
   
    Relation = [[ZHRelationCollectionViewController alloc]initWithCollectionViewLayout:layout];
    
    [self.view addSubview:Relation.view];
    Relation.favorite = YES;
    Relation.listModelArray = _dataArr;

}
/**
 *  创建tableView
 */

-(void)loadData{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadData" object:nil];
    _dataArr = [[ZHListManager defaultManager]allModel];
    Relation.listModelArray = _dataArr;
    [Relation.collectionView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"12312312312312");
    [Relation.view removeFromSuperview];
    UICollectionViewLayout *layout = [[UICollectionViewLayout alloc]init];
    _dataArr = [[ZHListManager defaultManager]allModel];
    Relation = [[ZHRelationCollectionViewController alloc]initWithCollectionViewLayout:layout];
     Relation.listModelArray = _dataArr;
    [self.view addSubview:Relation.view];
    Relation.favorite = YES;
   
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"sdfalksadfjalsd");
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
