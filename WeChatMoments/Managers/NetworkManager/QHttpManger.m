//
//  QHttpManger.m
//  WeChatMoments
//
//  Created by Owen on 2017/6/3.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import "QHttpManger.h"

@implementation QHttpManger


+(void) GET:(NSString*)urlStr
    success:(SuccessBlock)success
    failure:(FailureBlock)failure
{
  
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    //发送请求
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        int code = 1;// [[responseObject objectForKey:@"code"] intValue];
        if(success)
        {
            success(code, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure)
            failure(error);

    }];
 
}
@end
