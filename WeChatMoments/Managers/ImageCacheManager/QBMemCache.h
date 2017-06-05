//
//  QBMemCache.h
//  WeChatMoments
//
//  Created by Owen on 2017/6/5.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QBMemCache : NSCache

- (BOOL)containsObjectForKey:(id)key;

@end
