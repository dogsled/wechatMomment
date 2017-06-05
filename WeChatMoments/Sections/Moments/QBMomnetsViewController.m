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
#import "QBCommentsModel.h"
#import "YYModel.h"
#import "QBTweetsModel.h"
#import "MJRefresh.h"
#import "PureLayout.h"
#import "QBHeadView.h"
#import "QBMomentsTableViewCell.h"
#import "QBShareImgsView.h"
#import "QBCommentsView.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"


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

    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    [self setTitle:@"朋友圈"];
    
    _tableView = [UITableView newAutoLayoutView];
    _tableView.estimatedRowHeight = 100;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.delegate = self;
    _tableView.dataSource = self;


    _tableView.tableHeaderView = [[QBHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 350)];
    _tableView.contentInset = UIEdgeInsetsMake(-100, 0, 0, 0);
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
   
    //pull to refresh
    __block typeof(self) weakSelf = self;
    [_tableView addLegendHeaderWithRefreshingBlock:^{
       
        [weakSelf getTweetsFromRemote];
        
    }];
    
    [_tableView addLegendFooterWithRefreshingBlock:^{
        [weakSelf getMoreTweets];
    }];
    
    [self updateViewConstraints];
}

-(void)updateViewConstraints
{
    [super updateViewConstraints];

    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    
}

-(void)initData
{
    _currentUser = @"jsmith";

    //getuser profile
    NSString * url = KUSER_INFO_PATH(_currentUser);
    [QHttpManger GET:url success:^(int resultCode, id responseObject) {
        
        if (resultCode == 200) {
            _persion = [QBUserModel yy_modelWithJSON:responseObject];
            
            QBHeadView * headerView = (QBHeadView*) _tableView.tableHeaderView;
            [headerView.avatarImageView qb_setImageWithURL:[NSURL URLWithString:_persion.avatar]];
            [headerView.profileImageView qb_setImageWithURL:[NSURL URLWithString:_persion.profile_image]];
            [headerView.nickNameLabel setText:_persion.nick];
        }
    } failure:^(NSError *error) {
       [SVProgressHUD showErrorWithStatus:@"数据加载失败,请稍后再试"];
    }];

    [self getTweetsFromRemote];
}

-(void)getTweetsFromRemote
{
    _tweetsArr = [NSMutableArray array];
    _allTweetsArr = [NSMutableArray array];
    [QHttpManger GET:KTWEETS_PATH(_currentUser) success:^(int resultCode, id responseObject) {
        if (resultCode == 200) {
            
            NSArray*  tempTweetsArr = [[NSArray yy_modelArrayWithClass:[QBTweetsModel class] json:responseObject] mutableCopy];
            for (QBTweetsModel *model in tempTweetsArr) {
                if (model.content  || model.images.count != 0) {
                    [_allTweetsArr addObject:model];
                    if(_tweetsArr.count <= 5)
                    {
                        [_tweetsArr addObject:model];
                    }
                }
            }
            [_tableView reloadData];
            [_tableView.header endRefreshing];
        }
    } failure:^(NSError *error) {
//        [_tableView reloadData];
        [SVProgressHUD showErrorWithStatus:@"数据加载失败,请稍后再试"];
    }];
}
-(void)getMoreTweets
{
    if (_tweetsArr && _allTweetsArr) {
        //数据加载完成
        if (_tweetsArr.count == _allTweetsArr.count) {
            _tableView.footer.state = MJRefreshFooterStateNoMoreData;
        }
        else
        {
            //通过逻辑模拟分页
            NSArray *temp;
            NSMutableArray* tempIndexPathArr = [NSMutableArray array];
            NSUInteger stepCount;
            if(_allTweetsArr.count - _tweetsArr.count >=5  ) {
                stepCount = 5;
            }
            else
            {
                stepCount = _allTweetsArr.count - _tweetsArr.count;
            }
            
            temp =  [_allTweetsArr subarrayWithRange:NSMakeRange(_tweetsArr.count-1, stepCount)];//截取元素
            
            for (int i=0; i<stepCount; i++) {
                [tempIndexPathArr addObject:[NSIndexPath indexPathForRow:_tweetsArr.count+i inSection:0]];
            }
            [_tweetsArr addObjectsFromArray:temp];
            
           [self.tableView beginUpdates];
           [_tableView insertRowsAtIndexPaths:tempIndexPathArr withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
        }
        
    }
    
    [_tableView.footer endRefreshing];
}
#pragma mark - 实现代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tweetsArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QBTweetsModel * tweetsModel = [_tweetsArr objectAtIndex:indexPath.row];
    
//    QBMomentsTableViewCell *cell =[[QBMomentsTableViewCell alloc]initWithModel:tweetsModel];
    
    
    NSString* QBMomentsCellID = [NSString stringWithFormat:@"QBMomentsCellID_%lu", (unsigned long)tweetsModel.images.count];
    QBMomentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QBMomentsCellID];
    if (!cell) {
        cell = [[QBMomentsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QBMomentsCellID withModel:tweetsModel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    
    [cell.avaterImageView qb_setImageWithURL:[NSURL URLWithString:tweetsModel.sender.avatar]];
    [cell.nickNameLabel setText:tweetsModel.sender.nick];
    [cell.contentLabel setText:tweetsModel.content];
   
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
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
