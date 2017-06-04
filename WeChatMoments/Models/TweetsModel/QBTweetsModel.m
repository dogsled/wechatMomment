//
//  QBTweetsModel.m
//  WeChatMoments
//
//  Created by Owen on 2017/6/4.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import "QBTweetsModel.h"
#import "QBCommentsModel.h"


@implementation QBTweetsModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"comments":[QBCommentsModel class]};
}
@end
