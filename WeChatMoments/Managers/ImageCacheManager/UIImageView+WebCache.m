//
//  UIImageView+WebCache.m
//  WeChatMoments
//
//  Created by Owen on 2017/6/5.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "QBWebImageManager.h"
#import "QBCache.h"


@implementation UIImageView (WebCache)
- (void)qb_setImageWithURL:(nullable NSURL *)url
{
    [self qb_setImageWithURL:url placeholderImage:nil];
}

- (void)qb_setImageWithURL:(nullable NSURL *)url
       placeholderImage:(nullable UIImage *)placeholder
{
    if ([url isKindOfClass:[NSString class]])
        url = [NSURL URLWithString:(id)url];
    
    QBWebImageManager* manager = [QBWebImageManager sharedManager];
    
    // get the image from cache
    UIImage *imageFromCache = nil;
    if (manager.cache) {
        imageFromCache = [manager.cache objectForKey:url.absoluteString];
    }
    if (imageFromCache) {
        self.image = imageFromCache;
        NSLog(@"imageFromCache - 获取缓存");
        return;
    }
    NSOperation *operation = manager.operations[url.absoluteString];
    if (operation == nil) {
        operation = [NSBlockOperation blockOperationWithBlock:^{
            
            NSLog(@"image - 开始下载文件 当前线程  %@",[NSThread currentThread]);
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:url.absoluteString]];
            [request setHTTPMethod:@"GET"];
            NSData *data = [NSURLConnection sendSynchronousRequest:request
                                                       returningResponse:nil
                                                                   error:nil];
            // 下载图片
            if (data == nil) {
                // 移除操作
                [manager.operations removeObjectForKey:url.absoluteString];
                return;
            }
            
            UIImage *image = [UIImage imageWithData:data];
            
            // 存到字典中
            [manager.cache setObject:image  withImageData:data forKey:url.absoluteString];
            
            // 回到主线程显示图片
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.image = image;
                NSLog(@"image - 下载成功");
            }];
            // 移除操作
            [manager.operations removeObjectForKey:url.absoluteString];
        }];
        
        [manager.queue addOperation:operation];
        manager.operations[url.absoluteString] = operation;
    }
}
@end
