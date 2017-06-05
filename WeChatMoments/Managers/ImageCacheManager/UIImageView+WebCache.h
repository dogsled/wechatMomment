//
//  UIImageView+WebCache.h
//  WeChatMoments
//
//  Created by Owen on 2017/6/5.
//  Copyright © 2017年 Owen. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIImageView (WebCache)

- (void)qb_setImageWithURL:(nullable NSURL *)url;

- (void)qb_setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder;

@end
