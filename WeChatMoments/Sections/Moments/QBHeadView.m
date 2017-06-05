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
#import "AppMacro.h"

@implementation QBHeadView

-(instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
#pragma mark - 初始化UI
-(void) initUI
{
    [self setBackgroundColor:[UIColor whiteColor]];
    
    _profileImageView = [UIImageView newAutoLayoutView];
    _profileImageView.backgroundColor = UIColorFromRGB(K576B95Color);
    [_profileImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self addSubview:_profileImageView];

    _avatarImageView = [UIImageView newAutoLayoutView];
    [_avatarImageView setContentMode:UIViewContentModeScaleAspectFill];
    CALayer * layer = [_avatarImageView layer];
    layer.borderColor = [[UIColor whiteColor] CGColor];
    layer.borderWidth = 2.0f;
    //设置边框阴影
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(0, 0);
    layer.shadowOpacity = 1;
    layer.shadowRadius = 1;
    [_avatarImageView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_avatarImageView];
    
    _nickNameLabel = [UILabel newAutoLayoutView];
    _nickNameLabel.font = [UIFont boldSystemFontOfSize:18];
    _nickNameLabel.numberOfLines = 1;
    _nickNameLabel.textAlignment =NSTextAlignmentRight;
    _nickNameLabel.textColor = [UIColor whiteColor];
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
