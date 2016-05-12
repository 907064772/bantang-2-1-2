//
//  SearchViewController.h
//  sugar
//
//  Created by MS on 16-1-10.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic,copy)void(^showVC)(int idStr,NSString *title);


@property(nonatomic,copy)NSString  *idStr;
/**
 *  加载数据
 */
-(void)loadData;
@end
