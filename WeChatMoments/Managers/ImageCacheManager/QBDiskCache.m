//
//  QBDiskCache.m
//  WeChatMoments
//
//  Created by Owen on 2017/6/5.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import "QBDiskCache.h"
#import <CommonCrypto/CommonDigest.h>

@implementation QBDiskCache{
    NSFileManager *_fileManager;
}

- (instancetype)init {
      return [self initWithPath:@"default_QBCahce"];
}
- (instancetype)initWithPath:(NSString *)path{
    self = [super init];
    if (!self) return nil;
    
    _ioQueue = dispatch_queue_create("com.idoqi.QBDiskCache", DISPATCH_QUEUE_SERIAL);
    _diskCachePath = [self makeDiskCachePath:path];
    
    dispatch_sync(_ioQueue, ^{
        _fileManager = [NSFileManager new];
    });

    _countLimit = NSUIntegerMax;
    _costLimit = NSUIntegerMax;
    return self;
}

/**
 判断本地缓存是否包含key

 @param key image URLStr
 @return 是否包含
 */
- (BOOL)containsObjectForKey:(NSString *)key
{
    NSString *cachePathForKey = [self defaultCachePathForKey:key];
    return [_fileManager fileExistsAtPath:cachePathForKey];
}
- (void)containsObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key, BOOL contains))block
{
    dispatch_async(_ioQueue, ^{
        BOOL exists = [_fileManager fileExistsAtPath:[self defaultCachePathForKey:key]];
        if (!exists) {
            exists = [_fileManager fileExistsAtPath:[self defaultCachePathForKey:key].stringByDeletingPathExtension];
        }
        if (block) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(key, exists);
            });
        }
    });
}

- (UIImage *)objectForKey:(NSString *)key
{
    NSData *data = [self diskImageDataBySearchingAllPathsForKey:key];
    if (data) {
        UIImage *image = [[UIImage alloc] initWithData:data];
//        image = [self scaledImageForKey:key image:image];
//        if (shouldDecompressImages) {
//            image = [UIImage decodedImageWithImage:image];
//        }
        return image;
    }
    else {
        return nil;
    }

}
- (void)objectForKey:(NSString *)key withBlock:(void(^)(NSString *key, UIImage * object))block
{
    dispatch_async(self.ioQueue, ^{
        UIImage *image =  [self objectForKey:key];
        if (block) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(key, image);
            });
        }
    });
}

- (void)setObject:(NSData *)object forKey:(NSString *)key
{
    if (!object || !key) {
        return;
    }
    
    if (![_fileManager fileExistsAtPath:_diskCachePath]) {
        [_fileManager createDirectoryAtPath:_diskCachePath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    // get cache Path for image key
    NSString *cachePathForKey = [self defaultCachePathForKey:key];
    [_fileManager createFileAtPath:cachePathForKey contents:object attributes:nil];

}
- (void)setObject:(NSData *)object forKey:(NSString *)key withBlock:(void(^)(void))block;
{
    dispatch_async(self.ioQueue, ^{
        [self setObject:object forKey:key];
        
        if (block) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block();
            });
        }
    });

}
- (void)removeObjectForKey:(NSString *)key
{
    [_fileManager removeItemAtPath:[self defaultCachePathForKey:key] error:nil];
}

- (void)removeObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key))block
{
    dispatch_async(self.ioQueue, ^{
        [_fileManager removeItemAtPath:[self defaultCachePathForKey:key] error:nil];
        
        if (block) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(key);
            });
        }
    });
}

- (void)removeAllObjects
{
    [_fileManager removeItemAtPath:self.diskCachePath error:nil];
    [_fileManager createDirectoryAtPath:self.diskCachePath
            withIntermediateDirectories:YES
                             attributes:nil
                                  error:NULL];

}
- (void)removeAllObjectsWithBlock:(void(^)(void))block
{
    dispatch_async(self.ioQueue, ^{
        [_fileManager removeItemAtPath:self.diskCachePath error:nil];
        [_fileManager createDirectoryAtPath:self.diskCachePath
                withIntermediateDirectories:YES
                                 attributes:nil
                                      error:NULL];
        
        if (block) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block();
            });
        }
    });
}

#pragma mark - 工具方法
- (nullable NSString *)cachePathForKey:(nullable NSString *)key inPath:(nonnull NSString *)path {
    NSString *filename = [self cachedFileNameForKey:key];
    return [path stringByAppendingPathComponent:filename];
}
- (nullable NSString *)defaultCachePathForKey:(nullable NSString *)key {
    return [self cachePathForKey:key inPath:self.diskCachePath];
}

- (nullable NSString *)makeDiskCachePath:(nonnull NSString*)fullNamespace {
    NSArray<NSString *> *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:fullNamespace];
}
- (nullable NSString *)cachedFileNameForKey:(nullable NSString *)key {
    const char *str = key.UTF8String;
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%@",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10],
                          r[11], r[12], r[13], r[14], r[15], [key.pathExtension isEqualToString:@""] ? @"" : [NSString stringWithFormat:@".%@", key.pathExtension]];
    
    return filename;
}

- (nullable NSData *)diskImageDataBySearchingAllPathsForKey:(nullable NSString *)key {
    NSString *defaultPath = [self defaultCachePathForKey:key];
    NSData *data = [NSData dataWithContentsOfFile:defaultPath];
    if (data) {
        return data;
    }
    data = [NSData dataWithContentsOfFile:defaultPath.stringByDeletingPathExtension];
    if (data) {
        return data;
    }
    return nil;
}


- (NSUInteger)getSize {
    __block NSUInteger size = 0;
    dispatch_sync(self.ioQueue, ^{
        NSDirectoryEnumerator *fileEnumerator = [_fileManager enumeratorAtPath:self.diskCachePath];
        for (NSString *fileName in fileEnumerator) {
            NSString *filePath = [self.diskCachePath stringByAppendingPathComponent:fileName];
            NSDictionary<NSString *, id> *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
            size += [attrs fileSize];
        }
    });
    return size;
}

- (NSUInteger)getDiskCount {
    __block NSUInteger count = 0;
    dispatch_sync(self.ioQueue, ^{
        NSDirectoryEnumerator *fileEnumerator = [_fileManager enumeratorAtPath:self.diskCachePath];
        count = fileEnumerator.allObjects.count;
    });
    return count;
}



@end
