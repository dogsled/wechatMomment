//
//  QBUserModel.m
//  WeChatMoments
//
//  Created by Owen on 2017/6/4.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import "QBUserModel.h"

@implementation QBUserModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"profile_image" : @"profile-image"};
}
@end
