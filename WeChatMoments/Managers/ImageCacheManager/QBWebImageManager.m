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
    //这里很好的遵循了苹果规范,初始化的时候先调用父类,同时初始化了_cache,_queue,_timeout,_header这些属性
    _cache = cache;
    _queue = queue;
    _timeout = 15.0;
//    _headers = @{ @"Accept" : @"image/webp,image/*;q=0.8" };
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
