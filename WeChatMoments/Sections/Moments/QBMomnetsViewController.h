//
//  QBMomnetsViewController.h
//  WeChatMoments
//
//  Created by Owen on 2017/6/4.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QBUserModel.h"

@interface QBMomnetsViewController : UIViewController

@property(nonatomic, strong) UITableView * tableView;
@property(nonatomic, strong) NSArray * tweetsArr;
@property(nonatomic, strong) QBUserModel * persion;

@end
