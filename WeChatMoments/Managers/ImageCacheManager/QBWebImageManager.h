//
//  QBWebImageManager.h
//  WeChatMoments
//
//  Created by Owen on 2017/6/5.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QBCache.h"

@interface QBWebImageManager : NSObject

@property (nonatomic, strong) NSMutableDictionary *operations;
@property (nonatomic, assign) NSTimeInterval timeout;
@property (nonatomic, strong) QBCache *cache;
@property (nonatomic, strong) NSOperationQueue *queue;

- (instancetype)initWithCache:(QBCache *)cache queue:(NSOperationQueue *)queue NS_DESIGNATED_INITIALIZER;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
+ (instancetype)sharedManager;
@end
