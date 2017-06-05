//
//  QBMomentsTableViewCell.m
//  WeChatMoments
//
//  Created by Owen on 2017/6/4.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import "QBMomentsTableViewCell.h"
#import "PureLayout.h"
#import "UtilsMacro.h"
#import "AppMacro.h"
#import "QBShareImgsView.h"
#import "QBCommentsView.h"

@implementation QBMomentsTableViewCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier withModel:(QBTweetsModel *) tweetsModel
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         _tweetsModel = tweetsModel;
        [self initUI];
    }
    return self;
}

-(instancetype) initWithModel:(QBTweetsModel *) tweetsModel
{
    if (self = [super init]) {
        _tweetsModel = tweetsModel;
        [self initUI];
    }
    return self;
}
#pragma mark - 初始化UI

-(void) initUI
{
    _avaterImageView = [UIImageView newAutoLayoutView];
    [_avaterImageView setBackgroundColor:[UIColor grayColor]];
    [self addSubview:_avaterImageView];
    
    _nickNameLabel = [UILabel newAutoLayoutView];
    _nickNameLabel.font = [UIFont boldSystemFontOfSize:16];
    _nickNameLabel.textAlignment =NSTextAlignmentLeft;
    _nickNameLabel.textColor = UIColorFromRGB(K576B95Color);
    [self addSubview:_nickNameLabel];
    
    
    _contentLabel = [UILabel newAutoLayoutView];
    _contentLabel.font = [UIFont systemFontOfSize:16];
    _contentLabel.textAlignment =NSTextAlignmentLeft;
    _contentLabel.numberOfLines = 0;
    [self addSubview:_contentLabel];
    
    
    NSMutableArray * imgsArr = [NSMutableArray array];
    for (NSDictionary *dic in _tweetsModel.images) {
        [imgsArr addObject:[dic objectForKey:@"url"]];
    }
    _shareImgsView = [[QBShareImgsView alloc]initImageUrls:imgsArr];
    [self addSubview:_shareImgsView];


    
    _commentsView = [[QBCommentsView alloc]initWithCommentArr:_tweetsModel.comments];
    [self addSubview:_commentsView];
    
    [self updateViewConstraints];
    
}
-(void) updateViewConstraints
{
    
    [_avaterImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [_avaterImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_avaterImageView autoSetDimensionsToSize:CGSizeMake(45, 45)];
    [_avaterImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
    
    [_nickNameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_avaterImageView withOffset:2];
    [_nickNameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avaterImageView withOffset:10];
    [_nickNameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_nickNameLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_contentLabel withOffset:-10];
    
    [_contentLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_nickNameLabel withOffset:10];
    [_contentLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avaterImageView withOffset:10];
    [_contentLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_contentLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_shareImgsView withOffset:-10];
    [_contentLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
    
    
    [_shareImgsView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avaterImageView withOffset:10];
    [_shareImgsView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLabel withOffset:10];
    [_shareImgsView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_shareImgsView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_commentsView withOffset:-10];
    [_shareImgsView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
    
    
    [_commentsView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_shareImgsView withOffset:10];
    [_commentsView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avaterImageView withOffset:10];
    [_commentsView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [_commentsView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_commentsView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];

}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
