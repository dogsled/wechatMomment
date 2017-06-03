//
//  QHttpManger.h
//  WeChatMoments
//
//  Created by Owen on 2017/6/3.
//  Copyright © 2017年 Owen. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^SuccessBlock) (int resultCode, id responseObject);
typedef void (^FailureBlock) (NSError *error);

@interface QHttpManger : NSObject



/**
 http get 请求

 @param urlStr 请求地址
 @param success 成功回调block
 @param failure 失败回调block
 */
+(void) GET:(NSString*)urlStr
    success:(SuccessBlock)success
    failure:(FailureBlock)failure;
@end
