//
//  QBTweetsModel.h
//  WeChatMoments
//
//  Created by Owen on 2017/6/4.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QBUserModel, QBCommentsModel;

@interface QBTweetsModel : NSObject

@property(nonatomic, copy) NSString * content;
@property(nonatomic, strong) NSArray * images;
@property(nonatomic, strong) QBUserModel * sender;
@property(nonatomic, strong) NSArray<QBCommentsModel *> * comments;
@end
