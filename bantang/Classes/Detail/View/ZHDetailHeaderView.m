//
//  ZHHeaderView.m
//  bantang
//
//  Created by MS on 16-1-7.
//  Copyright (c) 2016年 ms. All rights reserved.
//

#import "ZHDetailHeaderView.h"
#import "SDCycleScrollView.h"
@interface ZHDetailHeaderView ()<SDCycleScrollViewDelegate>


@property(nonatomic,strong)UILabel *descLabel;

@property(nonatomic,strong)SDCycleScrollView *topScrollView;


@end




@implementation ZHDetailHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        创建头部ImageView
        [self createImageView];
//        创建价格label
        [self createPrice];
//        创建描述
        [self createDesc];
        
    }
    return self;
}
/**
 *  创建图片
 */
-(void)createImageView{
    SDCycleScrollView * topScrollView = [[SDCycleScrollView alloc]initWithFrame:self.frame];
    topScrollView.delegate = self;
    [topScrollView setBackgroundColor:[UIColor clearColor]];
    topScrollView.dotColor = [UIColor whiteColor];
    topScrollView.placeholderImage = [UIImage imageNamed:@"default_user_loading_icon"];
    topScrollView.autoScrollTimeInterval = 2.0;
    self.topScrollView = topScrollView;
    [self addSubview: topScrollView];
}
/**
 *  创建价格label
 */
-(void)createPrice{
    self.price = [[UILabel alloc]init];
    self.price.textAlignment = NSTextAlignmentCenter;
    self.price.textColor = [UIColor redColor];
    [self addSubview:self.price];
    
}

-(void)setImages:(NSArray *)images{
    _images = images;
    self.topScrollView.imageURLStringsGroup = _images;
    
    [self setNeedsLayout];
    
}


-(void)setDesc:(NSString *)desc{
    
    _desc = [desc copy];
    _descLabel.text = _desc;
//     重新布局
    [self setNeedsLayout];
    
    
}


-(void)createDesc{
    self.descLabel = [[UILabel alloc]init];
    self.descLabel.textColor = [UIColor lightGrayColor];
    self.descLabel.font = [UIFont systemFontOfSize:FONTMIN];
    self.descLabel.numberOfLines = 0;
    self.descLabel.text = _desc;
    [self addSubview:self.descLabel];
    
}

/**
 *  布局子视图
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    self.topScrollView.frame = CGRectMake(0, 0,  self.width, self.width);
    self.price.frame = CGRectMake(0, CGRectGetMaxY(self.topScrollView .frame), self.width, 20);
    self.descLabel.frame = CGRectMake(0, CGRectGetMaxY(self.price.frame), self.width, 20);
//    动态计算label 的高
    CGSize size = [_desc boundingRectWithSize:CGSizeMake(WIDTH, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:FONTMIN]} context:nil].size;
    self.descLabel.height = size.height;
 
    _height = CGRectGetMaxY(self.descLabel.frame);
    
}



- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    NSLog(@"点击了图片");
    
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
