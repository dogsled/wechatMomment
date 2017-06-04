//
//  QBHeadView.m
//  WeChatMoments
//
//  Created by Owen on 2017/6/4.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import "QBHeadView.h"
#import "PureLayout.h"
#import "UtilsMacro.h"

@implementation QBHeadView

-(instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
#pragma mark - 自定义

-(void) initUI
{
    _profileImageView = [UIImageView newAutoLayoutView];
    _profileImageView.backgroundColor = [UIColor blackColor];
    [_profileImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self addSubview:_profileImageView];

    _avatarImageView = [UIImageView newAutoLayoutView];
    [_avatarImageView setContentMode:UIViewContentModeScaleAspectFill];
    CALayer * layer = [_avatarImageView layer];
    layer.borderColor = [[UIColor whiteColor] CGColor];
    layer.borderWidth = 2.0f;
    
    layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
    layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    layer.shadowOpacity = 1;//不透明度
    layer.shadowRadius = 1;//半径
    [_avatarImageView setBackgroundColor:[UIColor greenColor]];
    [self addSubview:_avatarImageView];
    
    _nickNameLabel = [UILabel newAutoLayoutView];
    _nickNameLabel.font = [UIFont boldSystemFontOfSize:18];
    _nickNameLabel.numberOfLines = 1;
    _nickNameLabel.textAlignment =NSTextAlignmentRight;
    _nickNameLabel.textColor = [UIColor whiteColor];
    _nickNameLabel.text = @"jsom";
    [self addSubview:_nickNameLabel];
   
    
    
    [self updateViewConstraints];
}

-(void)updateViewConstraints
{
    [_profileImageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_profileImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_profileImageView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_profileImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:35];
    
    [_avatarImageView autoSetDimensionsToSize:CGSizeMake(75, 75)];
    [_avatarImageView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_avatarImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    
    
    [_nickNameLabel autoSetDimensionsToSize:CGSizeMake(100, 45)];
    [_nickNameLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_avatarImageView withOffset:-20];
    [_nickNameLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_profileImageView];
    
}

@end
