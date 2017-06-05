//
//  QBCache.h
//  WeChatMoments
//
//  Created by Owen on 2017/6/5.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QBMemCache.h"
#import "QBDiskCache.h"

@interface QBCache : NSObject

/** The name of the cache, readonly. */
@property (copy, readonly) NSString *name;

@property (strong, readonly) QBMemCache *memoryCache;
@property (strong, readonly) QBDiskCache *diskCache;

- (instancetype)init;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
+ (instancetype)sharedCache;

- (BOOL)containsObjectForKey:(NSString *)key;
- (void)containsObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key, BOOL contains))block;

- (UIImage *)objectForKey:(NSString *)key;
- (void)objectForKey:(NSString *)key withBlock:(void(^)(NSString *key, UIImage * object))block;

- (void)setObject:(UIImage *)object withImageData:(NSData*)data forKey:(NSString *)key;
- (void)setObject:(UIImage *)object withImageData:(NSData*)data forKey:(NSString *)key withBlock:(void(^)(void))block;

- (void)removeObjectForKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key))block;

- (void)removeAllObjects;
- (void)removeAllObjectsWithBlock:(void(^)(void))block;



@end
