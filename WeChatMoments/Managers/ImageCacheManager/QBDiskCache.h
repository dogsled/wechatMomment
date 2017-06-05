//
//  QBDiskCache.h
//  WeChatMoments
//
//  Created by Owen on 2017/6/5.
//  Copyright © 2017年 Owen. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface QBDiskCache : NSObject

@property (copy) NSString *name;
@property (readonly) NSString *diskCachePath;

#pragma mark - Limit

@property (assign) NSUInteger countLimit;
@property (assign) NSUInteger costLimit;
@property (assign) NSTimeInterval ageLimit;
@property (assign) NSUInteger freeDiskSpaceLimit;
@property (assign) NSTimeInterval autoTrimInterval;

@property (nonatomic) dispatch_queue_t ioQueue;

- (instancetype)init;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithPath:(NSString *)path;

- (BOOL)containsObjectForKey:(NSString *)key;
- (void)containsObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key, BOOL contains))block;

- (UIImage *)objectForKey:(NSString *)key;
- (void)objectForKey:(NSString *)key withBlock:(void(^)(NSString *key, UIImage *  object))block;

- (void)setObject:(NSData *)object forKey:(NSString *)key;
- (void)setObject:(NSData *)object forKey:(NSString *)key withBlock:(void(^)(void))block;

- (void)removeObjectForKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key))block;

- (void)removeAllObjects;
- (void)removeAllObjectsWithBlock:(void(^)(void))block;

@end
