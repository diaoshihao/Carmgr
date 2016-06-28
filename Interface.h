//
//  Interface.h
//  Carmgr
//
//  Created by admin on 16/6/28.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Interface : NSObject

//登录 参数：username=%@&password=%@&version=1.0
#define kLOGIN @"http://112.74.13.51:8080/carmgr/applogin"

//注册 参数：username=%@&password=%@&mobile=%@
#define kREGISTER @"http://112.74.13.51:8080/carmgr/appregister"

//找回密码 手机快捷登录 切换城市 扫一扫 


@end
