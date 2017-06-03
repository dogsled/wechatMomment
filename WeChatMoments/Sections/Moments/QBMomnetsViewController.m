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

@interface QBMomnetsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, copy) NSString * currentUser;

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
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    _tableView.tableHeaderView =
    
//    [self.view addSubview:_tableView];
    
}

-(void)initData
{
    _currentUser = @"jsmith";
    
    //接口测试
//    NSString * url = KUSER_INFO_PATH(_currentUser);
//    [QHttpManger GET:url success:^(int resultCode, id responseObject) {
//        QBUserModel * person = [QBUserModel yy_modelWithJSON:responseObject];
//        
//        NSLog(@"person is %@", person.description);
//        
//    } failure:^(NSError *error) {
//        ;
//    }];
  
    
//    [QHttpManger GET:KTWEETS_PATH(_currentUser); success:^(int resultCode, id responseObject) {
//        _tweetsArr = [NSArray yy_modelArrayWithClass:[QBTweetsModel class] json:responseObject];
//        NSLog(@"person is %@", _tweetsArr);
//    } failure:^(NSError *error) {
//        ;
//    }];
}


#pragma mark - 实现代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
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
