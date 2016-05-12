//
//  ZHHeaderView.m
//  bantang
//
//  Created by MS on 15-12-31.
//  Copyright (c) 2015年 ms. All rights reserved.
//

#import "ZHHeaderView.h"

@interface ZHHeaderView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)NSArray *fileArr;

@end


@implementation ZHHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dataArr = @[@"新的粉丝",@"新的评论",@"新的喜欢",@"新的奖励",@"新的通知"];
        _fileArr = @[@"icon_message_user",@"icon_message_comment",@"icon_message_like",@"icon_message_reward",@"icon_message_notification"];
        self.frame = frame;
        self.delegate = self;
        self.dataSource = self;
        
        

    }
    return self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:FONTMIN];
        cell.textLabel.textColor = [UIColor lightGrayColor];
        
    }
    
    cell.imageView.image = [UIImage imageNamed:_fileArr[indexPath.row]];
    cell.textLabel.text = _dataArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArr.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.showVC) {
        self.showVC();
        
    }
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
