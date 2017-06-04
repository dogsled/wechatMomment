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
//    if (_imageViewCount == 1) {
//       
//        [self addSubview:self.imageview1];
//    }
//    else if (_imageViewCount == 2)
//    {
//       
//        [self addSubview:_imageview1];
//        [self addSubview:_imageview2];
//  
//    }
//    else if (_imageViewCount == 3)
//    {
//        
//        [self addSubview:_imageview1];
//        [self addSubview:_imageview2];
//        [self addSubview:_imageview3];
//    }
//    else if (_imageViewCount == 4)
//    {
//        [self addSubview:_imageview1];
//        [self addSubview:_imageview2];
//        [self addSubview:_imageview3];
//        [self addSubview:_imageview4];
//    }
//    else if (_imageViewCount == 5)
//    {
//        [self addSubview:_imageview1];
//        [self addSubview:_imageview2];
//        [self addSubview:_imageview3];
//        [self addSubview:_imageview4];
//        [self addSubview:_imageview5];
//    }
//    else if (_imageViewCount == 6)
//    {
//        [self addSubview:_imageview1];
//        [self addSubview:_imageview2];
//        [self addSubview:_imageview3];
//        [self addSubview:_imageview4];
//        [self addSubview:_imageview5];
//        [self addSubview:_imageview6];
//    }
//    else if (_imageViewCount == 7)
//    {
//        [self addSubview:_imageview1];
//        [self addSubview:_imageview2];
//        [self addSubview:_imageview3];
//        [self addSubview:_imageview4];
//        [self addSubview:_imageview5];
//        [self addSubview:_imageview6];
//        [self addSubview:_imageview7];
//    }
//    else if (_imageViewCount == 8)
//    {
//        [self addSubview:_imageview1];
//        [self addSubview:_imageview2];
//        [self addSubview:_imageview3];
//        [self addSubview:_imageview4];
//        [self addSubview:_imageview5];
//        [self addSubview:_imageview6];
//        [self addSubview:_imageview7];
//        [self addSubview:_imageview8];
//    }
//    else if (_imageViewCount == 9)
//    {
//        [self addSubview:_imageview1];
//        [self addSubview:_imageview2];
//        [self addSubview:_imageview3];
//        [self addSubview:_imageview4];
//        [self addSubview:_imageview5];
//        [self addSubview:_imageview6];
//        [self addSubview:_imageview7];
//        [self addSubview:_imageview9];
//    }
    
   
    [self updateViewConstraints];
}

-(void)updateViewConstraints
{
    if (_imageViewCount == 1) {
        [self.imageview1 autoSetDimensionsToSize:CGSizeMake(200, 100)];
        [self.imageview1 autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [self.imageview1 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.imageview1 autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    }
    else if (_imageViewCount == 2) {
     
        [self setView1Constraints];
        [self setView2Constraints];
    }
    else if (_imageViewCount == 3) {
        [self setView1Constraints];
        [self setView2Constraints];
        [self setView3Constraints];
    }
    else if (_imageViewCount == 4) {
        [self setView1Constraints];
        [self setView2Constraints];
        [self setView3Constraints];
        [self setView4Constraints];
    }
    else if (_imageViewCount == 5) {
        [self setView1Constraints];
        [self setView2Constraints];
        [self setView3Constraints];
        [self setView4Constraints];
        [self setView5Constraints];
    }
    else if (_imageViewCount == 6) {
        [self setView1Constraints];
        [self setView2Constraints];
        [self setView3Constraints];
        [self setView4Constraints];
        [self setView5Constraints];
        [self setView6Constraints];
    }
    else if (_imageViewCount == 7) {
        [self setView1Constraints];
        [self setView2Constraints];
        [self setView3Constraints];
        [self setView4Constraints];
        [self setView5Constraints];
        [self setView6Constraints];
        [self setView7Constraints];
    }
    else if (_imageViewCount == 8) {
        [self setView1Constraints];
        [self setView2Constraints];
        [self setView3Constraints];
        [self setView4Constraints];
        [self setView5Constraints];
        [self setView6Constraints];
        [self setView7Constraints];
        [self setView8Constraints];
    }
    else if (_imageViewCount == 9) {
        [self setView1Constraints];
        [self setView2Constraints];
        [self setView3Constraints];
        [self setView4Constraints];
        [self setView5Constraints];
        [self setView6Constraints];
        [self setView7Constraints];
        [self setView8Constraints];
        [self setView9Constraints];
    }
}

-(void)setView1Constraints
{
    [self.imageview1 autoSetDimensionsToSize:CGSizeMake(AUTOSIZESCALE(135), AUTOSIZESCALE(135))];
    [self.imageview1 autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.imageview1 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.imageview1 autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
}

-(void)setView2Constraints
{
    [self.imageview2 autoSetDimensionsToSize:CGSizeMake(AUTOSIZESCALE(135), AUTOSIZESCALE(135))];
    [self.imageview2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_imageview1 withOffset:AUTOSIZESCALE(10)];
    [self.imageview2 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_imageview1 withOffset:0];
    [self.imageview2 autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
}

-(void)setView3Constraints
{
    [self.imageview3 autoSetDimensionsToSize:CGSizeMake(AUTOSIZESCALE(135), AUTOSIZESCALE(135))];
    [self.imageview3 autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    if (_imageViewCount == 4) {
        [self.imageview3 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imageview1 withOffset:5];
        [self.imageview3 autoAlignAxis:ALAxisVertical toSameAxisOfView:_imageview1 withOffset:0];
    }
    else{
        [self.imageview3 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_imageview2 withOffset:5];
        [self.imageview3 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_imageview2 withOffset:0];
    }
}

-(void)setView4Constraints
{
    [self.imageview4 autoSetDimensionsToSize:CGSizeMake(AUTOSIZESCALE(135), AUTOSIZESCALE(135))];
    [self.imageview4 autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    if (_imageViewCount == 4) {
        [self.imageview4 autoAlignAxis:ALAxisVertical toSameAxisOfView:_imageview2 withOffset:0];
        [self.imageview4 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_imageview3 withOffset:0];
    }
    else{
        [self.imageview4 autoPinEdge:ALEdgeLeft toEdge:ALEdgeBottom ofView:_imageview1 withOffset:5];
//        [self.imageview4 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_imageview1];
        [self.imageview4 autoAlignAxis:ALAxisVertical toSameAxisOfView:_imageview1 withOffset:0];
    }
}
-(void)setView5Constraints
{
    [self.imageview5 autoSetDimensionsToSize:CGSizeMake(AUTOSIZESCALE(135), AUTOSIZESCALE(135))];
    [self.imageview5 autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.imageview5 autoAlignAxis:ALAxisVertical toSameAxisOfView:_imageview2 withOffset:0];
    [self.imageview5 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_imageview2 withOffset:0];
    
}

-(void)setView6Constraints
{
    [self.imageview6 autoSetDimensionsToSize:CGSizeMake(AUTOSIZESCALE(135), AUTOSIZESCALE(135))];
    [self.imageview6 autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.imageview6 autoAlignAxis:ALAxisVertical toSameAxisOfView:_imageview3 withOffset:0];
    [self.imageview6 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_imageview5 withOffset:0];
    
}


-(void)setView7Constraints
{
    [self.imageview7 autoSetDimensionsToSize:CGSizeMake(AUTOSIZESCALE(135), AUTOSIZESCALE(135))];
    [self.imageview7 autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.imageview7 autoPinEdge:ALEdgeLeft toEdge:ALEdgeBottom ofView:_imageview1 withOffset:5];
    [self.imageview7 autoAlignAxis:ALAxisVertical toSameAxisOfView:_imageview1 withOffset:0];
    
}

-(void)setView8Constraints
{
    [self.imageview8 autoSetDimensionsToSize:CGSizeMake(AUTOSIZESCALE(135), AUTOSIZESCALE(135))];
    [self.imageview8 autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.imageview8 autoAlignAxis:ALAxisVertical toSameAxisOfView:_imageview5 withOffset:0];
    [self.imageview8 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_imageview7 withOffset:0];
    
}

-(void)setView9Constraints
{
    [self.imageview9 autoSetDimensionsToSize:CGSizeMake(AUTOSIZESCALE(135), AUTOSIZESCALE(135))];
    [self.imageview9 autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.imageview9 autoAlignAxis:ALAxisVertical toSameAxisOfView:_imageview6 withOffset:0];
    [self.imageview9 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_imageview7 withOffset:0];
    
}

- (UIImageView *)imageview1
{
    if (!_imageview1) {
        UIImageView *imageview1 = [UIImageView newAutoLayoutView];
        imageview1.contentMode = UIViewContentModeScaleAspectFill;
        imageview1.backgroundColor = [UIColor grayColor];
        imageview1.clipsToBounds = YES;
        [self addSubview:imageview1];
        _imageview1 = imageview1;
    }
    return _imageview1;
}
- (UIImageView *)imageview2
{
    if (!_imageview2) {
        UIImageView *imageview2 = [UIImageView newAutoLayoutView];
        imageview2.contentMode = UIViewContentModeScaleAspectFill;
        imageview2.backgroundColor = [UIColor grayColor];
        imageview2.clipsToBounds = YES;
        [self addSubview:imageview2];
        _imageview2 = imageview2;
    }
    return _imageview2;
}
- (UIImageView *)imageview3
{
    if (!_imageview3) {
        UIImageView *imageview3 = [UIImageView newAutoLayoutView];
        imageview3.contentMode = UIViewContentModeScaleAspectFill;
        imageview3.backgroundColor = [UIColor grayColor];
        imageview3.clipsToBounds = YES;
        [self addSubview:imageview3];
        _imageview3 = imageview3;
    }
    return _imageview3;
}
- (UIImageView *)imageview4
{
    if (!_imageview4) {
        UIImageView *imageview4 = [UIImageView newAutoLayoutView];
        imageview4.contentMode = UIViewContentModeScaleAspectFill;
        imageview4.backgroundColor = [UIColor grayColor];
        imageview4.clipsToBounds = YES;
        [self addSubview:imageview4];
        _imageview4 = imageview4;
    }
    return _imageview4;
}
- (UIImageView *)imageview5
{
    if (!_imageview5) {
        UIImageView *imageview5 = [UIImageView newAutoLayoutView];
        imageview5.contentMode = UIViewContentModeScaleAspectFill;
        imageview5.backgroundColor = [UIColor grayColor];
        imageview5.clipsToBounds = YES;
        [self addSubview:imageview5];
        _imageview5 = imageview5;
    }
    return _imageview5;
}

- (UIImageView *)imageview6
{
    if (!_imageview6) {
        UIImageView *imageview6 = [UIImageView newAutoLayoutView];
        imageview6.contentMode = UIViewContentModeScaleAspectFill;
        imageview6.backgroundColor = [UIColor grayColor];
        imageview6.clipsToBounds = YES;
        [self addSubview:imageview6];
        _imageview6 = imageview6;
    }
    return _imageview6;
}
- (UIImageView *)imageview7
{
    if (!_imageview7) {
        UIImageView *imageview7 = [UIImageView newAutoLayoutView];
        imageview7.contentMode = UIViewContentModeScaleAspectFill;
        imageview7.backgroundColor = [UIColor grayColor];
        imageview7.clipsToBounds = YES;
        [self addSubview:imageview7];
        _imageview7 = imageview7;
    }
    return _imageview7;
}
- (UIImageView *)imageview8
{
    if (!_imageview8) {
        UIImageView *imageview8 = [UIImageView newAutoLayoutView];
        imageview8.contentMode = UIViewContentModeScaleAspectFill;
        imageview8.backgroundColor = [UIColor grayColor];
        imageview8.clipsToBounds = YES;
        [self addSubview:imageview8];
        _imageview8 = imageview8;
    }
    return _imageview8;
}
- (UIImageView *)imageview9
{
    if (!_imageview9) {
        UIImageView *imageview9 = [UIImageView newAutoLayoutView];
        imageview9.contentMode = UIViewContentModeScaleAspectFill;
        imageview9.backgroundColor = [UIColor grayColor];
        imageview9.clipsToBounds = YES;
        [self addSubview:imageview9];
        _imageview9 = imageview9;
    }
    return _imageview9;
}

@end
