//
//  QBShareImgsView.h
//  WeChatMoments
//
//  Created by Owen on 2017/6/4.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QBShareImgsView : UIView

@property(nonatomic, strong) NSArray * imagesArr;
@property(nonatomic, strong) UIImageView * imageview1;
@property(nonatomic, strong) UIImageView * imageview2;
@property(nonatomic, strong) UIImageView * imageview3;
@property(nonatomic, strong) UIImageView * imageview4;
@property(nonatomic, strong) UIImageView * imageview5;
@property(nonatomic, strong) UIImageView * imageview6;
@property(nonatomic, strong) UIImageView * imageview7;
@property(nonatomic, strong) UIImageView * imageview8;
@property(nonatomic, strong) UIImageView * imageview9;


-(instancetype) initImageUrls:(NSArray*)imageArr;
@end
