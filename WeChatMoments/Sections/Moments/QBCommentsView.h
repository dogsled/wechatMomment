//
//  QBCommentsView.h
//  WeChatMoments
//
//  Created by Owen on 2017/6/4.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYText.h"

@interface QBCommentsView : UIView

@property(nonatomic, strong) NSArray * commentsArr;
@property(nonatomic, strong) NSMutableArray<YYLabel*> * commentsLabelArr;

-(instancetype)initWithCommentArr:(NSArray*)commentsArr;
@end
