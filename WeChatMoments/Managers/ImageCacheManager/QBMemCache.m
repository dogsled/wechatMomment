//
//  QBMemCache.m
//  WeChatMoments
//
//  Created by Owen on 2017/6/5.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import "QBMemCache.h"

@implementation QBMemCache

- (nonnull instancetype)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeAllObjects) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}


-(BOOL)containsObjectForKey:(id)key
{
    if ((UIImage*)[self objectForKey:key]==nil) {
        return YES;
    }
    return NO;
}

@end
