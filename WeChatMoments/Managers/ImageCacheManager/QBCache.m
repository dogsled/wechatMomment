//
//  QBCache.m
//  WeChatMoments
//
//  Created by Owen on 2017/6/5.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import "QBCache.h"

@implementation QBCache
#pragma mark Public
/**
 *  单例类的初始化方法
 */
//+ (instancetype)sharedCache {
//    static QBCache *cache = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        cache = [[self alloc] init];
//    });
//    return cache;
//}

- (instancetype)init {
    //在调用父类init之前先初始化一个内存缓存跟磁盘缓存
    _memoryCache = [[QBMemCache alloc] init];
    _diskCache = [[QBDiskCache alloc] init];//生成磁盘缓存
    if (!_memoryCache || !_diskCache) return nil;//如果有任意一个初始化失败,返回nil
    self = [super init];
    
    return self;
}


- (BOOL)containsObjectForKey:(NSString *)key {
    return [_memoryCache containsObjectForKey:key] || [_diskCache containsObjectForKey:key];
}
- (void)containsObjectForKey:(NSString *)key withBlock:(void (^)(NSString *key, BOOL contains))block {
    if (!block) return;
    
    if ([_memoryCache containsObjectForKey:key]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            block(key, YES);
        });
    } else  {
        [_diskCache containsObjectForKey:key withBlock:block];
    }
}

- (UIImage *)objectForKey:(NSString *)key {
    UIImage * object = [_memoryCache objectForKey:key];
    if (!object) {
        object = [_diskCache objectForKey:key];
        if (object) {
            [_memoryCache setObject:object forKey:key];
        }
    }
    return object;
}

- (void)objectForKey:(NSString *)key withBlock:(void (^)(NSString *key, id<NSCoding> object))block {
    if (!block) return;
    UIImage * object = [_memoryCache objectForKey:key];
    if (object) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            block(key, object);
        });
    } else {
        [_diskCache objectForKey:key withBlock:block];
    }
}

- (void)setObject:(UIImage *)object withImageData:(NSData*)data forKey:(NSString *)key {
    if (object) {
         [_memoryCache setObject:object forKey:key];
    }
    if (data) {
        [_diskCache setObject:data forKey:key];
    }
    
}

- (void)setObject:(UIImage *)object withImageData:(NSData*)data forKey:(NSString *)key withBlock:(void (^)(void))block {
    if (object) {
        [_memoryCache setObject:object forKey:key];
    }
    if (data) {
        [_diskCache setObject:data forKey:key withBlock:block];
    }
}

- (void)removeObjectForKey:(NSString *)key {
    [_memoryCache removeObjectForKey:key];
    [_diskCache removeObjectForKey:key];
}

- (void)removeObjectForKey:(NSString *)key withBlock:(void (^)(NSString *key))block {
    [_memoryCache removeObjectForKey:key];
    [_diskCache removeObjectForKey:key withBlock:block];
}

- (void)removeAllObjects {
    [_memoryCache removeAllObjects];
    [_diskCache removeAllObjects];
}

- (void)removeAllObjectsWithBlock:(void(^)(void))block {
    [_memoryCache removeAllObjects];
    [_diskCache removeAllObjectsWithBlock:block];
}

- (NSString *)description {
    if (_name) return [NSString stringWithFormat:@"<%@: %p> (%@)", self.class, self, _name];
    else return [NSString stringWithFormat:@"<%@: %p>", self.class, self];
}
@end
