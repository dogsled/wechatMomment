//
//  AppMacro.h
//  WeChatMoments
//
//  Created by Owen on 2017/6/4.
//  Copyright © 2017年 Owen. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h


#define KUSER_INFO_PATH(user)   [@"http://thoughtworks-ios.herokuapp.com/user/" stringByAppendingString:user]
#define KTWEETS_PATH(user)      [NSString stringWithFormat:@"http://thoughtworks-ios.herokuapp.com/user/%@/tweets" ,user]



#define KEDEDEDColor 0xEDEDED
#define K576B95Color 0x576B95
#define KE6E6E4Color 0xE6E6E4
#define KF3F3F5Color 0xF3F3F5
#define K333237Color 0x333237

#endif /* AppMacro_h */
