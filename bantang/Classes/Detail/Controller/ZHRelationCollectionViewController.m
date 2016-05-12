//
//  ZHRelationCollectionViewController.m
//  bantang
//
//  Created by MS on 16-1-8.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import "ZHRelationCollectionViewController.h"
#import "ZHRelationCollectionViewCell.h"
#import "Masonry.h"
#import "ZHBaseModel.h"


#define ZHRCVCell @"ZHRelationCollectionViewCell"
@interface ZHRelationCollectionViewController ()<UICollectionViewDelegateFlowLayout>

@end

@implementation ZHRelationCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    _favorite = NO;
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    self.collectionView.height -= 64;
    
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZHRelationCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ZHRCVCell];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notify) name:@"reloadData" object:nil];
    
}

-(void)notify{
    [self.collectionView reloadData];
}



#pragma mark <UICollectionViewDataSource>



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
   
    
    ZHRelationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZHRCVCell forIndexPath:indexPath];
    if (_favorite == YES) {
        ZHListModel * listModel = _listModelArray[indexPath.row];
        cell.topicIV.image  = [UIImage imageWithData:listModel.image];
        cell.titleLabel.text = listModel.title;
        cell.priceLabel.text = listModel.price;
//        cell.likeBtn.titleLabel = listModel.likes;
        return cell;
    }
    cell.listModel = _product.product[indexPath.row];
    return  cell;
    
}


/**
 *  返回每组元素的数量
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_favorite == YES) {
        return _listModelArray.count;
    }
    return _product.product.count;
}


/**
 *  设置上左下右间隔,
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 2, 0, 2);
}




-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    取出点击后的数据传给cell,cell 在传递给控制器进行跳转
    ZHListModel *list = _product.product[indexPath.row];
    if (self.block) {
        self.block(list);
    }
    
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((WIDTH - 15)/2 , (WIDTH - 15)/2 + 40);
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



#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking

*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
