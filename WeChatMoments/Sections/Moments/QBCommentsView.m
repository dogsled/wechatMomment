//
//  QBCommentsView.m
//  WeChatMoments
//
//  Created by Owen on 2017/6/4.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import "QBCommentsView.h"
#import "AppMacro.h"
#import "UtilsMacro.h"
#import "QBCommentsModel.h"
#import "QBUserModel.h"
#import "Purelayout.h"

@implementation QBCommentsView
-(instancetype)initWithCommentArr:(NSArray*)commentsArr
{
    if (self = [super init]) {
        _commentsArr = commentsArr;
        [self setBackgroundColor:UIColorFromRGB(KF3F3F5Color)];
        [self initUI];
    }
    return self;
}

#pragma mark - 自定义

-(void) initUI
{
    _commentsLabelArr = [NSMutableArray array];
    
    for (QBCommentsModel *commentsmodel in _commentsArr) {
        NSString*  comment = commentsmodel.sender.nick;
        comment = [comment stringByAppendingString:@":"];
        NSRange  markRange = NSMakeRange(0, comment.length);
        comment = [comment stringByAppendingString:commentsmodel.content];

        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:comment];
        
        text.yy_font = [UIFont systemFontOfSize:13];
        text.yy_color = [UIColor blackColor];
        [text yy_setColor:UIColorFromRGB(K576B95Color) range:markRange];
        text.yy_lineSpacing = 0;
        
        YYLabel *label = [YYLabel newAutoLayoutView];
        [self addSubview:label];
        label.attributedText = text;
        
        [_commentsLabelArr addObject:label];

    }
    [self updateViewConstraints];
}
-(void)updateViewConstraints
{
    for (int i = 0 ; i< _commentsLabelArr.count; i++) {
        YYLabel *label = [_commentsLabelArr objectAtIndex:i];
        if (i == 0 ) {
            [label autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        }
        else
        {
            UIView * topLable = [_commentsLabelArr objectAtIndex:i-1];
            [label autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:topLable withOffset:10];
        }
        [label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        [label autoSetDimension:ALDimensionHeight toSize:13];
        [label autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
    }
}
@end
