//
//  QBWebImageManager.m
//  WeChatMoments
//
//  Created by Owen on 2017/6/5.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import "QBWebImageManager.h"

@implementation QBWebImageManager

+ (instancetype)sharedManager {
    static QBWebImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        QBCache *cache = [[QBCache alloc]init];
        NSOperationQueue *queue = [NSOperationQueue new];
        if ([queue respondsToSelector:@selector(setQualityOfService:)]) {
            queue.qualityOfService = NSQualityOfServiceBackground;
        }
        queue.maxConcurrentOperationCount = 10;
        manager = [[self alloc] initWithCache:cache queue:queue];
    });
    return manager;
}

- (instancetype)init {
    return [self initWithCache:nil queue:nil];
}


- (instancetype)initWithCache:(QBCache *)cache queue:(NSOperationQueue *)queue{
    self = [super init];
    if (!self) return nil;
    _cache = cache;
    _queue = queue;
    return self;
}

- (NSMutableDictionary *)operations
{
    if (!_operations) {
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;
}
@end
