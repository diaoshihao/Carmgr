//
//  Interface.h
//  Carmgr
//
//  Created by admin on 16/6/28.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyNetworker.h"

typedef NS_ENUM(NSUInteger, Request) {
    InterfaceUrl,
    Parameters,
};

@interface Interface : NSObject

NS_ASSUME_NONNULL_BEGIN

//======================地图相关==============================
+ (NSString *)tableid;
+ (NSString *)amapApiKey;
+ (NSArray *)nearbyArround:(NSString *)center;
+ (NSArray *)getmerchantaddress:(NSString *)keywords city:(NSString *)city;
+ (NSArray *)maddress:(NSString *)name address:(NSString *)address type:(NSString *)type service_name:(NSString *)service_name price:(NSString *)price;
//=============================================================

//======================默认账户，用于显示展示性页面=================
+ (NSString *)defaultUsername;
+ (NSString *)defaultPassword;
+ (NSString *)defaultToken;
//==============================================================

+ (NSString *)username;

+ (NSString *)password;

+ (NSString *)token;

+ (NSString *)uuid;

+ (NSString *)url;

//login
+ (NSArray *)applogin:(NSString *)username password:(NSString *)password type:(NSString *)type verf_code:(NSString *)verf_code uuid:(NSString *)uuid;

//register
+ (NSArray *)appregister:(NSString *)username password:(NSString *)password mobile:(NSString *)mobile;

//send verf_code
//type == 0：注册；1：登录；2:找回密码
+ (NSArray *)appsendverfcode:(NSString *)username type:(NSString *)type uuid:(NSString *)uuid;

//check verf_code
+ (NSArray *)appcheckverfcode:(NSString *)username mobile:(NSString *)mobile verf_code:(NSString *)verf_code type:(NSString *)type uuid:(NSString *)uuid;

//appresetpassword
//type default = 2
+ (NSArray *)appresetpassword:(NSString *)username new_password:(NSString *)new_password uuid:(NSString *)uuid verf_code:(NSString *)verf_code type:(NSString *)type;

//appresetusername
+ (NSArray *)appresetusername:(NSString *)username new_username:(NSString *)new_username;

//首页数据===========================================
+ (NSArray *)appgetconfig_key:(NSString *)config_key;

+ (NSArray *)appgetservices;

+ (NSArray *)appgetrecommend;

+ (NSArray *)appgetsecondhandcar;
//首页数据===========================================

//商家列表
+ (NSArray *)appgetmerchantslist_city_filter:(NSString *)city_filter service_filter:(NSString *)service_filter;

//进度
+ (NSArray *)appgetprocess_filter:(NSString *)filter;

//个人资料
+ (NSArray *)appgetprivate;

//添加车辆
+ (NSArray *)appaddcarinfo_car_type:(NSString *)car_type
                               city:(NSString *)city
                     vehicle_number:(NSString *)vehicle_number
                      engine_number:(NSString *)engine_number
                       frame_number:(NSString *)frame_number
                      buy_insu_time:(NSString *)buy_insu_time
                 first_mantain_time:(NSString *)first_mantain_time travel_mileage:(NSString *)travel_mileage
                           comments:(NSString *)comments;

//商家详情
+ (NSArray *)appgetmerchants_name:(NSString *)merchant_name;

//预约服务
+ (NSArray *)appsubscribeservice_id:(NSString *)service_id merchant_id:(NSString *)merchant_id opt_type:(NSString *)opt_type;

//评价
+ (NSArray *)appadvise_text:(NSString *)advise_text;

//用户操作行为统计
+ (NSArray *)apploguseroperation_click_area:(NSString *)click_area detail:(NSString *)detail;

NS_ASSUME_NONNULL_END

//=====================================================================


#define kCARMGR @"http://112.74.13.51:8080/carmgr/"
//登录 参数：username=%@&password=%@&type=%d&verf_code=%@&uuid=%@&version=1.0
#define kLOGIN @"http://112.74.13.51:8080/carmgr/applogin.action?username=%@&password=%@&type=%d&verf_code=%@&uuid=%@&version=1.0"

//注册 参数：username=%@&password=%@&mobile=%@&terminal_os=%@&user_type=%@
//user_type = 0：表示车主用户；1：表示商户
#define kREGISTER @"http://112.74.13.51:8080/carmgr/appregister.action?username=%@&password=%@&mobile=%@&terminal_os=iOS&user_type=%d"

//发送验证码 参数：username=%@&type=%@&uuid=%@&version=1.0
//type == 0：注册；1：登录；2:找回密码
#define kVERIFYCODE @"http://112.74.13.51:8080/carmgr/appsendverfcode.action?username=%@&type=%d&uuid=%@&version=1.0"

//校验验证码 参数：username=%@&mobile=%@&verf_code=%@&type=%d&uuid=%@&version=1.0
#define kCHECKVERFCODE @"http://112.74.13.51:8080/carmgr/appcheckverfcode.action?username=%@&mobile=%@&verf_code=%@&type=%d&uuid=%@&version=1.0"

//设置密码 参数：username=%@&new_password=%@&uuid=%@&verf_code=%@&type=%d&version=1.0
#define kRESETPASSWD @"http://112.74.13.51:8080/carmgr/appresetpassword.action?username=%@&new_password=%@&uuid=%@&verf_code=%@&type=%d&version=1.0"


//重设用户名 参数：username=%@&new_username=%@&token=%@&version=1.0
#define kRESETUSRNAME @"http://112.74.13.51:8080/carmgr/appresetusername.action?username=%@&new_username=%@&token=%@&version=1.0"

//=====================================================================
//动态资源 参数：username=%@&config_key=%@&screen_size=%@&token=%@&version=1.0
#define kCONFIG @"http://112.74.13.51:8080/carmgr/appgetconfig.action?username=%@&config_key=%@&screen_size=%@&token=%@&version=1.0"
//基础业务 参数：username=%@&token=%@&version=1.0
#define kSERVICES @"http://112.74.13.51:8080/carmgr/appgetservices.action?username=%@&token=%@&version=1.0"
//热门推荐
#define kRECOMMEND @"http://112.74.13.51:8080/carmgr/appgetrecommend.action?username=%@&token=%@&version=1.0"
//热门二手 参数：username=%@&token=%@&version=1.0
#define kSECONDHAND @"http://112.74.13.51:8080/carmgr/appgetsecondhandcar.action?username=%@&token=%@&version=1.0"
//=====================================================================
//商家 参数：username=%@&city_filter=%@&service_filter=%@&token=%@&version=1.0
#define kSTORE @"http://112.74.13.51:8080/carmgr/appgetmerchantslist.action?username=%@&city_filter=%@&service_filter=%@&token=%@&version=1.0"
//进度 参数：username=%@&filter=%@&token=%@&version=1.0
#define kPROCESS @"http://112.74.13.51:8080/carmgr/appgetprocess.action?username=%@&filter=%@&token=%@&version=1.0"

//=====================================================================
//个人信息 参数：username=%@&token=%@&version=1.0
#define kPRIVATE @"http://112.74.13.51:8080/carmgr/appgetprivate.action?username=%@&token=%@&version=1.0"
//增加车辆 参数：username=%@&car_type=%@&city=%@&vehicle_number=%@&engine_number=%@&frame_number=%@&buy_insu_time=%@&first_mantain_time=%@&travel_mileage=%@&comments=%@&token=%@&version=1.0
#define kADDCAR @"http://112.74.13.51:8080/carmgr/appaddcarinfo.action?username=%@&car_type=%ld&city=%@&vehicle_number=%@&engine_number=%@&frame_number=%@&buy_insu_time=%@&first_mantain_time=%@&travel_mileage=%@&comments=%@&token=%@&version=1.0"
//=====================================================================
//商户信息 参数：username=%@&merchant_name=%@&token=%@&version=1.0
#define kMERCHANT @"http://112.74.13.51:8080/carmgr/appgetmerchants.action?username=%@&merchant_name=%@&token=%@&version=1.0"

//=====================================================================
//用户评价 参数：username=%@&advise_text=%@&token=%@&version=1.0
#define kADVISE @"http://112.74.13.51:8080/carmgr/appadvise.action?username=%@&advise_text=%@&token=%@&version=1.0"
//用户操作行为 参数：username=%@&click_area_id=%@&detail=%@&token=%@&version=1.0
#define kOPERATION @"http://112.74.13.51:8080/carmgr/apploguseroperation.action?username=%@&click_area_id=%@&detail=%@&token=%@&version=1.0"


@end
