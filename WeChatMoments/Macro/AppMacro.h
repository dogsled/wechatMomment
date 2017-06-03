//
//  AppMacro.h
//  WeChatMoments
//
//  Created by Owen on 2017/6/4.
//  Copyright © 2017年 Owen. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h


#define KUSER_INFO_PATH(user) [@"http://thoughtworks-ios.herokuapp.com/user/" stringByAppendingString:user]
#define KTWEETS_PATH(user) [NSString stringWithFormat:@"http://thoughtworks-ios.herokuapp.com/user/%@/tweets" ,user]

#endif /* AppMacro_h */
