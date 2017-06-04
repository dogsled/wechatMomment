//
//  QBShareImgsView.m
//  WeChatMoments
//
//  Created by Owen on 2017/6/4.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import "QBShareImgsView.h"
#import "PureLayout.h"
#import "UtilsMacro.h"

@implementation QBShareImgsView

-(instancetype) initImageViewCount:(int)count
{
    if (self = [super init]) {
        _imageViewCount = count;
        [self initUI];
    }
    return self;
}
#pragma mark - 自定义

-(void) initUI
{
    if (_imageViewCount == 1) {
        _imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, AUTOSIZESCALE(400), AUTOSIZESCALE(200))];
        _imageview1.contentMode = UIViewContentModeScaleAspectFill;
        _imageview1.backgroundColor = [UIColor grayColor];
        [self addSubview:_imageview1];
    }
}

@end
