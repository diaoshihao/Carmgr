//
//  Interface.h
//  Carmgr
//
//  Created by admin on 16/6/28.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Interface : NSObject
#define kCARMGR @"http://112.74.13.51:8080/carmgr/"

//登录 参数：username=%@&password=%@&version=1.0
#define kLOGIN @"http://112.74.13.51:8080/carmgr/applogin"

//注册 参数：username=%@&password=%@&mobile=%@&terminal_os=%@&user_type=%@
//user_type = 0：表示车主用户；1：表示商户
#define kREGISTER @"http://112.74.13.51:8080/carmgr/appregister"

//验证码 参数：参数：username=%@&type=%@&version=1.0
//type == 0：注册；1：登录；2:找回密码
#define kVERIFYCODE @"http://112.74.13.51:8080/carmgr/appsendverfcode"

//找回密码 手机快捷登录 切换城市 扫一扫 
#define kFINDPASSWD @"http://112.74.13.51:8080/carmgr/appfindpassword"

//重设密码
#define kRESETPASSWD @"http://112.74.13.51:8080/carmgr/appresetpassword"

//重设用户名
#define kRESETUSRNAME @"http://112.74.13.51:8080/carmgr/appresetusername"

//====================================================================

//基础业务 参数：username=%@&version=1.0
#define kSERVICES @"http://112.74.13.51:8080/carmgr/appgetservices"

//热门推荐
#define kRECOMMEND @"http://112.74.13.51:8080/carmgr/appgetrecommend"

//热门二手 参数：username=%@&version=1.0
#define kSECONDHAND @"http://112.74.13.51:8080/carmgr/appgetsecondhandcar"


@end
