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
#import "UIKit+AFNetworking.h"
#import "QBMomentsTableViewCell.h"
#import "QBShareImgsView.h"

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
    _tableView.estimatedRowHeight = 150;  //  随便设个不那么离谱的值
    _tableView.rowHeight = UITableViewAutomaticDimension;
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

    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    

    
    
    
}

-(void)initData
{
    _currentUser = @"jsmith";
    _tweetsArr = [NSMutableArray array];
    
    //接口测试
    NSString * url = KUSER_INFO_PATH(_currentUser);
    [QHttpManger GET:url success:^(int resultCode, id responseObject) {
        _persion = [QBUserModel yy_modelWithJSON:responseObject];
        
        QBHeadView * headerView = (QBHeadView*) _tableView.tableHeaderView;
        [headerView.avatarImageView setImageWithURL:[NSURL URLWithString:_persion.avatar]];
        [headerView.profileImageView setImageWithURL:[NSURL URLWithString:_persion.profile_image]];
        [headerView.nickNameLabel setText:_persion.nick];
        
        NSLog(@"person is %@", _persion.description);
        
    } failure:^(NSError *error) {
        ;
    }];
  
    
    [QHttpManger GET:KTWEETS_PATH(_currentUser) success:^(int resultCode, id responseObject) {
       NSArray*  tempTweetsArr = [[NSArray yy_modelArrayWithClass:[QBTweetsModel class] json:responseObject] mutableCopy];
        for (QBTweetsModel *model in tempTweetsArr) {
            if (model.content  || model.images.count != 0) {
                [_tweetsArr addObject:model];
            }
//             [_tweetsArr addObject:model];
        }
        NSLog(@"person is %@", _tweetsArr);
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        ;
    }];
}


#pragma mark - 实现代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tweetsArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QBTweetsModel * tweetsModel = [_tweetsArr objectAtIndex:indexPath.row];
    NSString* QBMomentsCellID = [NSString stringWithFormat:@"QBMomentsCellID_%lu", (unsigned long)tweetsModel.images.count];
    
    QBMomentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QBMomentsCellID];
    if (!cell) {
        cell = [[QBMomentsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QBMomentsCellID];
    }
    
    [cell.avaterImageView setImageWithURL:[NSURL URLWithString:tweetsModel.sender.avatar]];
    [cell.nickNameLabel setText:tweetsModel.sender.nick];
    [cell.contentLabel setText:tweetsModel.content];
    
    if (tweetsModel.images.count==1) {
        NSDictionary *dicImage = tweetsModel.images.firstObject;
        [cell.shareImgsView.imageview1 setImageWithURL:[NSURL URLWithString:[dicImage objectForKey:@"url"]]];
    }
    else if (tweetsModel.images.count==2) {
        NSDictionary *dicImage = tweetsModel.images.firstObject;
        
        
        [cell.shareImgsView.imageview1 setImageWithURL:[NSURL URLWithString:[dicImage objectForKey:@"url"]]];
        [cell.shareImgsView.imageview2 setImageWithURL:[NSURL URLWithString:[tweetsModel.images[1] objectForKey:@"url"]]];
    }
    else if (tweetsModel.images.count==3) {
        NSDictionary *dicImage = tweetsModel.images.firstObject;
        
        
        [cell.shareImgsView.imageview1 setImageWithURL:[NSURL URLWithString:[dicImage objectForKey:@"url"]]];
        [cell.shareImgsView.imageview2 setImageWithURL:[NSURL URLWithString:[tweetsModel.images[1] objectForKey:@"url"]]];
        [cell.shareImgsView.imageview3 setImageWithURL:[NSURL URLWithString:[tweetsModel.images[2] objectForKey:@"url"]]];
    }
    else if(tweetsModel.images.count == 4)
    {
        NSDictionary *dicImage = tweetsModel.images.firstObject;
        [cell.shareImgsView.imageview1 setImageWithURL:[NSURL URLWithString:[dicImage objectForKey:@"url"]]];
        [cell.shareImgsView.imageview2 setImageWithURL:[NSURL URLWithString:[tweetsModel.images[1] objectForKey:@"url"]]];
        [cell.shareImgsView.imageview3 setImageWithURL:[NSURL URLWithString:[tweetsModel.images[2] objectForKey:@"url"]]];
        [cell.shareImgsView.imageview4 setImageWithURL:[NSURL URLWithString:[tweetsModel.images[3] objectForKey:@"url"]]];
    }
    else
    {
        [cell.shareImgsView.imageview1 setImage:nil];
    }
//    if (tweetsModel.images.count>0) {
//        NSDictionary *dicImage = tweetsModel.images.firstObject;
//        [cell.shareImageView setImageWithURL:[NSURL URLWithString:[dicImage objectForKey:@"url"]]];
//    }
//    else
//    {
//        [cell.shareImageView setImage:nil];
//    }
    
    NSString * comment;
    if (tweetsModel.comments.count>0) {
        for (QBCommentsModel *commentModel in tweetsModel.comments) {
            comment = commentModel.sender.nick;
            comment = [comment stringByAppendingString:@":"];
            comment = [comment stringByAppendingString:commentModel.content];
            comment = [comment stringByAppendingString:@"\n"];
            
            comment = [comment stringByAppendingString:commentModel.sender.nick];
            comment = [comment stringByAppendingString:@":"];
            comment = [comment stringByAppendingString:commentModel.content];
            comment = [comment stringByAppendingString:@"\n"];
        }
        [cell.comments setText:comment];
    }
    
    
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
