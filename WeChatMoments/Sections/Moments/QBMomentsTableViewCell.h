//
//  QBMomentsTableViewCell.h
//  WeChatMoments
//
//  Created by Owen on 2017/6/4.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QBShareImgsView;
@interface QBMomentsTableViewCell : UITableViewCell
@property(nonatomic, assign) int imageCount;
@property(nonatomic, strong)  UIImageView * avaterImageView;
@property(nonatomic, strong)  UILabel * nickNameLabel;
@property(nonatomic, strong)  UILabel * contentLabel;
//@property(nonatomic, strong)  UIImageView * shareImageView;
@property(nonatomic, strong)  QBShareImgsView * shareImgsView;

@property(nonatomic, strong)  UILabel * comments;

@end
