//
//  QBMomnetsViewController.m
//  WeChatMoments
//
//  Created by Owen on 2017/6/4.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import "QBMomnetsViewController.h"
#import "UtilsMacro.h"
#import "AppMacro.h"
#import "QHttpManger.h"
#import "QBUserModel.h"
#import "YYModel.h"
#import "QBTweetsModel.h"
#import "MJRefresh.h"
#import "PureLayout.h"
#import "QBHeadView.h"
#import "UIKit+AFNetworking.h"

@interface QBMomnetsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, copy) NSString * currentUser;
@property(nonatomic, strong) UIImageView * avatarView;
@end

@implementation QBMomnetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 初始化

-(void)initUI
{
//    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _tableView = [UITableView newAutoLayoutView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
//    _headView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400)];


    
    _tableView.tableHeaderView = [[QBHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400)];
//    _tableView.tableHeaderView.backgroundColor = [UIColor redColor];
    _tableView.contentInset = UIEdgeInsetsMake(-100, 0, 0, 0);
    _tableView.tableFooterView = [UIView new];

   [_tableView addLegendHeaderWithRefreshingBlock:^{
       
   }];
    
    [self.view addSubview:_tableView];
    
    [self updateViewConstraints];
}

-(void)updateViewConstraints
{
    [super updateViewConstraints];
    
//    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    

    
    
    
}

-(void)initData
{
    _currentUser = @"jsmith";
    
    //接口测试
    NSString * url = KUSER_INFO_PATH(_currentUser);
    [QHttpManger GET:url success:^(int resultCode, id responseObject) {
        _persion = [QBUserModel yy_modelWithJSON:responseObject];
        QBHeadView * headerView = (QBHeadView*) _tableView.tableHeaderView;
        [headerView.avatarImageView setImageWithURL:[NSURL URLWithString:_persion.avatar]];
        [headerView.profileImageView setImageWithURL:[NSURL URLWithString:_persion.profile_image]];
        NSLog(@"person is %@", _persion.description);
        
    } failure:^(NSError *error) {
        ;
    }];
  
    
//    [QHttpManger GET:KTWEETS_PATH(_currentUser) success:^(int resultCode, id responseObject) {
//        _tweetsArr = [NSArray yy_modelArrayWithClass:[QBTweetsModel class] json:responseObject];
//        NSLog(@"person is %@", _tweetsArr);
//    } failure:^(NSError *error) {
//        ;
//    }];
}


#pragma mark - 实现代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"testcell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"testcell"];
    }
    cell.textLabel.text = @"XD_下拉刷新测试";
    return cell;
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
