//
//  ZHGoodsDetailViewController.m
//  bantang
//
//  Created by MS on 16-1-6.
//  Copyright (c) 2016年 ms. All rights reserved.
//



#import "ZHGoodsDetailViewController.h"
#import "ZHUIFactory.h"
#import "MJRefresh.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "ZHDataModel.h"
#import "ZHListModel.h"
#import "ZHRelationTableViewCell.h"
#import "ZHTopicTableViewCell.h"
#import "ZHHeaderViewTableViewCell.h"
#import "ZHWebViewController.h"
#import "ZHDetailHeaderView.h"
#import "ZHDetailViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UMSocial.h"
#import "KVNProgress.h"
#import "UIImageView+WebCache.h"
#import "DataManager.h"


#define ZHHVTVCell @"ZHHeaderViewTableViewCell"
#define ZHTTVCell @"ZHTopicTableViewCell"
#define ZHRTVCell @"ZHRelationTableViewCell"
#define MARGIN 10
@interface ZHGoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UMSocialUIDelegate>{
    NSMutableArray *_newsInfoArr;
    NSMutableArray *_relationArr;
}
@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation ZHGoodsDetailViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"物品详情";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _newsInfoArr = [NSMutableArray new];
    _relationArr = [NSMutableArray new];
    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
//    创建一个有分组的tableView
    [self createTableView];
    
    _tableView.separatorColor = [UIColor whiteColor];
    
    
    [_tableView registerNib:[UINib nibWithNibName:@"ZHTopicTableViewCell" bundle:nil] forCellReuseIdentifier:ZHTTVCell];
    
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        加载数据
        [self loadData];
    }];
    [_tableView.header beginRefreshing];
    
    
    //    设置导航栏右边为分享按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"share_item_icon" highImageName:@"share_item_icon" target:self action:@selector(shareBtnClick:)];

    
    
    
}

#pragma mark - 友盟分享

-(void)shareBtnClick:(UIBarButtonItem *)bbi{
    if (_newsInfoArr.count == 0) {
        return;
    }
    ZHDataModel *dataModel = _newsInfoArr[0];
    _imageView = [[UIImageView alloc]init];
    NSDictionary *pic = dataModel.product.pic[0];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:pic[@"pic"]]];
    
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"56935b7767e58eb6b50004e0" shareText:[NSString stringWithFormat:@"%@\n%@",dataModel.product.title, dataModel.product.share_url] shareImage:_imageView.image shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,UMShareToDouban,UMShareToEmail,UMShareToSms,UMShareToFacebook,UMShareToTwitter,nil] delegate:self];

    
    
}



//完成后获取友盟数据相应
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response;{
    if (response.responseCode == UMSResponseCodeSuccess) {
        [KVNProgress showSuccessWithStatus:@"分享成功"];
    }
}


/**
 *  加载数据
 */
-(void)loadData{
    
     [KVNProgress showWithStatus:@"loading"];
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    解析上面的相关推荐和相关清单的网络连接
    [manager POST:[NSString stringWithFormat:relation_url,self.idStr] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        


        [_relationArr addObject:[ZHListModel objectWithKeyValues:responseObject[@"data"]]];
        
        [_tableView reloadData];
        [_tableView.header endRefreshing];
        [KVNProgress dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",[error description]);
        [_tableView.header endRefreshing];
        [KVNProgress showErrorWithStatus:@"网络链接错误"];
        
    }];
    
//    头部视图和其他的网络连接
    [manager POST:[NSString stringWithFormat:productNewInfo_url,self.idStr] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_newsInfoArr addObject:[ZHDataModel  objectWithKeyValues:responseObject[@"data"]]];
        
        [_tableView reloadData];
        [_tableView.header endRefreshing];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",[error description]);
        [_tableView.header endRefreshing];
    }];
    
    
}



/**
 *  创建一个的tableView
 */
-(void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
//    减去导航栏和下边工具栏的高度
    self.tableView.height -= 104;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

    
//    设置底部工具栏
    [self createToolBar];
}
/**
 *  设置底部工具栏
 */
-(void)createToolBar{
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), WIDTH, 44)];
    [self.view addSubview:view];
//    评论按钮
    UIButton *commentBtn = [ZHUIFactory BunttonWithImageView:UIButtonTypeCustom andFrame:CGRectMake(0, 0, WIDTH/3, view.height) andTarget:self andAction:@selector(commentClick:)];
    [commentBtn setImage:[UIImage imageNamed:@"btn_product_comment"] forState:UIControlStateNormal];
    [commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    [commentBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [view addSubview:commentBtn];
    
  
    
//    喜欢按钮
    UIButton *likeBtn = [ZHUIFactory BunttonWithImageView:UIButtonTypeCustom andFrame:CGRectMake(CGRectGetMaxX(commentBtn.frame), 0, WIDTH/3, view.height) andTarget:self andAction:@selector(likeClick:)];
    [likeBtn setImage:[UIImage imageNamed:@"btn_product_like"] forState:UIControlStateNormal];
    [likeBtn setImage:[UIImage imageNamed:@"btn_product_like_already"] forState:UIControlStateSelected];
    [likeBtn setTitle:@"喜欢" forState:UIControlStateNormal];
    [likeBtn setTitle:@"取消喜欢" forState:UIControlStateSelected];
    [likeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [likeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [view addSubview:likeBtn];
//    先从数据库中读取所有的单品,看是否有相同的,如果有就让按钮的选中状态为yes,否则正常显示
    NSArray * array = [[DataManager defaultManager] allModel];
    for (ZHDataModel *dm in array) {
        if ([dm.id isEqual: self.idStr]) {
            likeBtn.selected = YES;
        }
    }
    
    
//    购买按钮
    UIButton *buyBtn = [ZHUIFactory BunttonWithImageView:UIButtonTypeCustom andFrame:CGRectMake(CGRectGetMaxX(likeBtn.frame), 0, WIDTH/3, view.height) andTarget:self andAction:@selector(buyClick:)];
    [buyBtn setImage:[UIImage imageNamed:@"btn_product_buy"] forState:UIControlStateNormal];
    [view addSubview:buyBtn];
    
}

#pragma mark - toolbar按钮的回调
/**
 *  评论按钮
 *
 *  @param comment <#comment description#>
 */
-(void)commentClick:(UIButton *)comment{
    NSLog(@"评论");
}

/**
 *  收藏按钮
 *
 *  @param like <#like description#>
 */
-(void)likeClick:(UIButton *)like{
//    切换按钮状态
    like.selected = !like.isSelected;
    ZHDataModel *dm = _newsInfoArr[0];
    dm.title = dm.product.title;
    dm.price = dm.product.price;
    dm.image = UIImagePNGRepresentation(_imageView.image);
//    加入收藏清单
    if (like.selected ) {
         [[DataManager defaultManager] insertDataWithModel:dm];
        [KVNProgress showSuccessWithStatus:@"搜藏单品成功"];
    }else{
//        删除单品
        [[DataManager defaultManager] deleteUserWithId: dm.id];
        [KVNProgress showSuccessWithStatus:@"删除单品成功"];
    }

}
/**
 *  购买按钮
 *
 *  @param buy <#buy description#>
 */
-(void)buyClick:(UIButton *)buy{
    ZHDataModel *dataModel = _newsInfoArr[0];
    
    ZHWebViewController *webView = [[ZHWebViewController alloc]init];
    webView.urlStr = dataModel.product.url;
    [self.navigationController pushViewController:webView animated:YES];
    
}











#pragma mark - tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_relationArr.count>0 && _newsInfoArr.count>0) {
        return 3;
    }
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            ZHHeaderViewTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:ZHHVTVCell];
            if (!cell) {
                cell = [[ZHHeaderViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ZHHVTVCell];
            }
            cell.dataModel = _newsInfoArr[0];
            return  cell;
        }
            
            break;
        case 1:{
            ZHTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZHTTVCell forIndexPath:indexPath];
            ZHListModel *list =  _relationArr[0];
            cell.topic = list.topic;
            [cell setShowDetailVC:^(id str) {
                ZHDetailViewController *detailVC = [[ZHDetailViewController alloc]init];
                detailVC.idStr = str;
                [self.navigationController pushViewController:detailVC animated:YES];
                
            }];
            return  cell;
        }

            break;
        case 2:{
            ZHRelationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZHRTVCell];
            if (!cell) {
                cell = [[ZHRelationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ZHRTVCell];
            }
            cell.product = _relationArr[0];
            
            [cell setShowVC:^(ZHListModel *list) {
                ZHGoodsDetailViewController *goodsVC = [ZHGoodsDetailViewController new];
                goodsVC.idStr = list.id;
                [self.navigationController pushViewController:goodsVC animated:YES];
            }];
            
            return  cell;
        }
            
            break;
            
        default:
            break;
    }
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            ZHDataModel *list =  _newsInfoArr[0];
            CGSize size = [list.product.desc boundingRectWithSize:CGSizeMake(WIDTH, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONTMIN]} context:nil].size;
            
            return WIDTH + 20 + size.height + MARGIN;
        }
            break;
        case 1:{
            
            ZHListModel *list =  _relationArr[0];
            
            if (list.topic.count>0) {
                //              应该按比例算
                return 220 + MARGIN;
            }
            return 0;

        }
            break;
        case 2:{
            
            ZHListModel  *product = _relationArr[0];
            
            return product.product.count * ((WIDTH - 15)/2 + 55) / 2;
        }
             break;
        default:
            break;
    }
    
    return 44;
    
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
