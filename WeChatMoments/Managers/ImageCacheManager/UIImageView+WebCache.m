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
    if ([url isKindOfClass:[NSString class]]) url = [NSURL URLWithString:(id)url];
    QBWebImageManager* manager = [QBWebImageManager sharedManager];
    
    // get the image from memory as quickly as possible
    UIImage *imageFromMemory = nil;
    if (manager.cache) {
        imageFromMemory = [manager.cache objectForKey:url.absoluteString];
    }
    if (imageFromMemory) {
        self.image = imageFromMemory;
        return;
    }
    NSOperation *operation = manager.operations[url.absoluteString];
    if (operation == nil) { // 这张图片暂时没有下载任务
        operation = [NSBlockOperation blockOperationWithBlock:^{
            // 下载图片
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url.absoluteString]];
            // 数据加载失败
            if (data == nil) {
                // 移除操作
                [manager.operations removeObjectForKey:url.absoluteString];
                return;
            }
            
            UIImage *image = [UIImage imageWithData:data];
            
            // 存到字典中
            [manager.cache setObject:image forKey:url.absoluteString];
            
            // 回到主线程显示图片
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
               self.image = imageFromMemory;
            }];
            // 移除操作
            [manager.operations removeObjectForKey:url.absoluteString];
        }];
        
        // 添加到队列中
        [manager.queue addOperation:operation];
        
        // 存放到字典中
        manager.operations[url.absoluteString] = operation;
    }
    
}
@end
