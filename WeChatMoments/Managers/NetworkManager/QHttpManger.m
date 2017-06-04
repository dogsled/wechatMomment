//
//  QHttpManger.m
//  WeChatMoments
//
//  Created by Owen on 2017/6/3.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import "QHttpManger.h"
#import "SVProgressHUD.h"

@implementation QHttpManger


+(void) GET:(NSString*)urlStr
    success:(SuccessBlock)success
    failure:(FailureBlock)failure
{
  
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    
    //发送请求
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        int statusCode  = (int)response.statusCode;
        if (statusCode != 200) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请求异常，错误状态码为：%d, 请将问题反馈以便及时解决", statusCode]];
        }
        
        if(success)
        {
            success(statusCode, responseObject);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure)
            failure(error);

    }];
 
}
@end
