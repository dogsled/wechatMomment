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
#import "QBShareImgsView.h"

@implementation QBMomentsTableViewCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSString *last = [reuseIdentifier substringFromIndex:reuseIdentifier.length-1];
        _imageCount = [last intValue];
        [self initUI];
    }
    return self;
}

#pragma mark - 自定义

-(void) initUI
{
    _avaterImageView = [UIImageView newAutoLayoutView];
    [_avaterImageView setBackgroundColor:[UIColor grayColor]];
    [self addSubview:_avaterImageView];
    
    _nickNameLabel = [UILabel newAutoLayoutView];
    _nickNameLabel.font = [UIFont boldSystemFontOfSize:15];
    _nickNameLabel.textAlignment =NSTextAlignmentLeft;
    _nickNameLabel.textColor = UIColorFromRGB(0x9B9B9B);
    [self addSubview:_nickNameLabel];
    
    
    _contentLabel = [UILabel newAutoLayoutView];
    _contentLabel.font = [UIFont systemFontOfSize:13];
    _contentLabel.textAlignment =NSTextAlignmentLeft;
    _contentLabel.numberOfLines = 0;
//    _contentLabel.textColor = UIColorFromRGB(0x9B9B9B);
    [self addSubview:_contentLabel];
    
//    _shareImageView = [UIImageView newAutoLayoutView];
//    [self addSubview:_shareImageView];
    
    
    _shareImgsView = [[QBShareImgsView alloc]initImageViewCount:_imageCount];
    [self addSubview:_shareImgsView];

    
    _comments = [UILabel newAutoLayoutView];
    _comments.font = [UIFont systemFontOfSize:13];
    _comments.textAlignment =NSTextAlignmentLeft;
    _comments.numberOfLines = 0;
    [self addSubview:_comments];
    
    [self updateViewConstraints];
    
}
-(void) updateViewConstraints
{
    
    [_avaterImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [_avaterImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [_avaterImageView autoSetDimensionsToSize:CGSizeMake(45, 45)];
    [_avaterImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
    
    [_nickNameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_avaterImageView withOffset:5];
    [_nickNameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avaterImageView withOffset:10];
    [_nickNameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_nickNameLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_contentLabel withOffset:-10];
    
    [_contentLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_nickNameLabel withOffset:10];
    [_contentLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avaterImageView withOffset:10];
    [_contentLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_contentLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_shareImgsView withOffset:-10];
    [_contentLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
    
//    if (_imageCount == 1) {
//        [_shareImageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avaterImageView withOffset:10];
//        [_shareImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLabel withOffset:10];
//        [_shareImageView autoSetDimensionsToSize:CGSizeMake(200, 100)];
//        [_shareImageView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
////        [_shareImageView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_comments withOffset:-10];
//        [_shareImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
//    }
//    [_shareImageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avaterImageView withOffset:10];
//    [_shareImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLabel withOffset:10];
//    [_shareImageView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
//    [_shareImageView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_comments withOffset:-10];
//    [_shareImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
    
    [_shareImgsView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avaterImageView withOffset:10];
    [_shareImgsView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLabel withOffset:10];
    [_shareImgsView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_shareImgsView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_comments withOffset:-10];
    [_shareImgsView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
    
    [_comments autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_shareImgsView withOffset:10];
    [_comments autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avaterImageView withOffset:10];
    [_comments autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [_comments autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
   
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
