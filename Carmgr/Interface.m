//
//  Interface.m
//  Carmgr
//
//  Created by admin on 16/6/28.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "Interface.h"

@implementation Interface

+ (NSString *)appVersion {
    NSString *key = (NSString *)kCFBundleVersionKey;
    // 从Info.plist中取出版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    NSLog(@"version---%@---",version);
    return @"1.1.0";
}

+ (NSString *)username {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
}

+ (NSString *)token {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
}

+ (NSString *)uuid {
    NSString *uuid = [[NSUUID UUID] UUIDString];
    return uuid;
}

+ (NSString *)url {
    return @"http://112.74.13.51:8080/carmgr/";
}

+ (NSString *)action {
    return @".action";
}

+ (NSArray *)appsendverfcode:(NSString *)username uuid:(NSString *)uuid {
    NSString *url = [NSString stringWithFormat:@"%@appsendverfcode.action",[Interface url]];
    NSDictionary *param = @{@"username":username, @"type":@"0", @"uuid":uuid, @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)applogin:(NSString *)username password:(NSString *)password type:(NSString *)type verf_code:(NSString *)verf_code uuid:(NSString *)uuid {
    NSString *url = [NSString stringWithFormat:@"%@applogin.action",[Interface url]];
    NSDictionary *param = @{@"username":username, @"password":password, @"type":type, @"verf_code":verf_code, @"uuid":uuid, @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)appregister:(NSString *)username password:(NSString *)password mobile:(NSString *)mobile {
    NSString *url = [NSString stringWithFormat:@"%@appregister.action",[Interface url]];
    NSString *terminal_os = @"iOS";
    NSDictionary *param = @{@"username":username, @"password":password, @"mobile":mobile, @"terminal_os":terminal_os, @"user_type":@"0"};
    return @[url,param];
}

+ (NSArray *)appcheckverfcode:(NSString *)username mobile:(NSString *)mobile verf_code:(NSString *)verf_code type:(NSString *)type uuid:(NSString *)uuid {
    NSString *url = [NSString stringWithFormat:@"%@appcheckverfcode.action",[Interface url]];
    NSDictionary *param = @{@"username":username, @"mobile":mobile, @"verf_code":verf_code, @"type":type, @"uuid":uuid, @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)appresetpassword:(NSString *)username new_password:(NSString *)new_password uuid:(NSString *)uuid verf_code:(NSString *)verf_code type:(NSString *)type {
    NSString *url = [NSString stringWithFormat:@"%@appresetpassword.action",[Interface url]];
    NSDictionary *param = @{@"username":username, @"new_password":new_password, @"uuid":uuid, @"verf_code":verf_code, @"type":@"2", @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)appresetusername:(NSString *)username new_username:(NSString *)new_username {
    NSString *url = [NSString stringWithFormat:@"%@appresetusername.action",[Interface url]];
    NSDictionary *param = @{@"username":username, @"new_username":new_username, @"token":[Interface token], @"version":[Interface appVersion]};
    return @[url,param];
}

///////////////////////////////////////////////////////////////////////
+ (NSArray *)appgetconfig_key:(NSString *)config_key {
    NSString *url = [NSString stringWithFormat:@"%@appgetconfig.action",[Interface url]];
    NSString *screen_size = [NSString stringWithFormat:@"%.0lfx%.0lf",[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height];
    NSDictionary *param = @{@"username":[Interface username], @"config_key":config_key, @"screen_size":screen_size, @"token":[Interface token], @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)appgetservices {
    NSString *url = [NSString stringWithFormat:@"%@appgetservices.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username], @"token":[Interface token], @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)appgetrecommend {
    NSString *url = [NSString stringWithFormat:@"%@appgetrecommend.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username], @"token":[Interface token], @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)appgetsecondhandcar {
    NSString *url = [NSString stringWithFormat:@"%@appgetsecondhandcar.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username], @"token":[Interface token], @"version":[Interface appVersion]};
    return @[url,param];
}

///////////////////////////////////////////////////////////////////////
+ (NSArray *)appgetmerchantslist_city_filter:(NSString *)city_filter service_filter:(NSString *)service_filter {
    NSString *url = [NSString stringWithFormat:@"%@appgetmerchantslist.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username], @"city_filter":city_filter, @"service_filter":service_filter, @"token":[Interface token], @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)appgetprocess_filter:(NSString *)filter {
    NSString *url = [NSString stringWithFormat:@"%@appgetprocess.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username], @"filter":filter, @"token":[Interface token], @"version":[Interface appVersion]};
    return @[url,param];
}

///////////////////////////////////////////////////////////////////////
+ (NSArray *)appgetprivate {
    NSString *url = [NSString stringWithFormat:@"%@appgetprivate.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username], @"token":[Interface token], @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)appaddcarinfo_car_type:(NSString *)car_type
                               city:(NSString *)city
                     vehicle_number:(NSString *)vehicle_number
                      engine_number:(NSString *)engine_number
                       frame_number:(NSString *)frame_number
                      buy_insu_time:(NSString *)buy_insu_time
                 first_mantain_time:(NSString *)first_mantain_time travel_mileage:(NSString *)travel_mileage
                           comments:(NSString *)comments {
    NSString *url = [NSString stringWithFormat:@"%@appaddcarinfo.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username], @"car_type":car_type, @"city":city, @"vehicle_number":vehicle_number,@"engine_number":engine_number,@"frame_number":frame_number,@"buy_insu_time":buy_insu_time, @"first_mantain_time":first_mantain_time, @"travel_mileage":travel_mileage, @"comments":comments, @"token":[Interface token], @"version":[Interface appVersion]};
    return @[url,param];
}

///////////////////////////////////////////////////////////////////////

+ (NSArray *)appgetmerchants_name:(NSString *)merchant_name {
    NSString *url = [NSString stringWithFormat:@"%@appgetmerchants.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username], @"merchant_name":merchant_name, @"token":[Interface token], @"version":[Interface appVersion]};
    return @[url,param];
}

///////////////////////////////////////////////////////////////////////
+ (NSArray *)appadvise_text:(NSString *)advise_text {
    NSString *url = [NSString stringWithFormat:@"%@appgetmerchants.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username], @"advise_text":advise_text, @"token":[Interface token], @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)apploguseroperation_click_area:(NSString *)click_area detail:(NSString *)detail {
    NSString *url = [NSString stringWithFormat:@"%@appgetmerchantslist.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username], @"click_area":click_area, @"detail":detail, @"token":[Interface token], @"version":[Interface appVersion]};
    return @[url,param];
}

@end
