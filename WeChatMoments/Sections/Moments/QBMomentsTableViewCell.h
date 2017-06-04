//
//  QBMomentsTableViewCell.h
//  WeChatMoments
//
//  Created by Owen on 2017/6/4.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QBTweetsModel.h"

@class QBShareImgsView,QBCommentsView;
@interface QBMomentsTableViewCell : UITableViewCell

@property(nonatomic, strong)  QBTweetsModel * tweetsModel;
@property(nonatomic, strong)  UIImageView * avaterImageView;
@property(nonatomic, strong)  UILabel * nickNameLabel;
@property(nonatomic, strong)  UILabel * contentLabel;
@property(nonatomic, strong)  QBShareImgsView * shareImgsView;

@property(nonatomic, strong)  QBCommentsView * commentsView;

-(instancetype) initWithModel:(QBTweetsModel *) tweetsModel;
-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(QBTweetsModel *) tweetsModel;
@end
