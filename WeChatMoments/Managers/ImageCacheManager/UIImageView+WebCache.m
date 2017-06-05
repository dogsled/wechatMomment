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
        return;
    }
    if (placeholder) {
        self.image = placeholder;
    }
    NSOperation *operation = manager.operations[url.absoluteString];
    if (operation == nil) {
        operation = [NSBlockOperation blockOperationWithBlock:^{
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:url.absoluteString]];
            [request setHTTPMethod:@"GET"];
            NSData *data = [NSURLConnection sendSynchronousRequest:request
                                                       returningResponse:nil
                                                                   error:nil];
        
            if (data == nil) {
                [manager.operations removeObjectForKey:url.absoluteString];
                return;
            }
            
            UIImage *image = [UIImage imageWithData:data];
            if (image == nil) {
                return;
            }
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.image = image;
            }];
            // 存到字典中
            [manager.cache setObject:image  withImageData:data forKey:url.absoluteString];
            // 移除操作
            [manager.operations removeObjectForKey:url.absoluteString];
        }];
        
        [manager.queue addOperation:operation];
        manager.operations[url.absoluteString] = operation;
    }
}
@end
