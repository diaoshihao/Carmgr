//
//  Interface.m
//  Carmgr
//
//  Created by admin on 16/6/28.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "Interface.h"

@implementation Interface

+ (NSString *)amapApiKey {
    return @"e69025b7664fa7cb60f866e6f0117be7";
}

+ (NSString *)tableid {
    return @"5851feb0afdf520ea8f630b7";
}

+ (NSString *)webApiKey {
    return @"22f36167e71062f0c9fb395241be52ff";
}

+ (NSArray *)nearbyArround:(NSString *)center {
    NSString *url = @"http://yuntuapi.amap.com/nearby/around";
    NSDictionary *param = @{@"key":[Interface webApiKey],
                            @"center":center};
    return @[url, param];
}

+ (NSArray *)getmerchantaddress:(NSString *)keywords city:(NSString *)city {
    NSString *url = @"http://yuntuapi.amap.com/datasearch/local";
    NSDictionary *param = @{@"key":[Interface webApiKey],
                           @"tableid":[Interface tableid],
                           @"keywords":keywords,
                           @"city":city};
    return @[url, param];
}

+ (NSArray *)maddress:(NSString *)name address:(NSString *)address type:(NSString *)type service_name:(NSString *)service_name price:(NSString *)price {
    NSString *url = @"http://yuntuapi.amap.com/datamanage/data/create";
    NSDictionary *data = @{@"_name":name,
                           @"_address":address,
                           @"service_type":type,
                           @"service_name":service_name,
                           @"price":price};
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions error:&parseError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *param = @{@"key":[Interface webApiKey],
                            @"tableid":[Interface tableid],
                            @"loctype":@"2",
                            @"data":jsonString
                            };
    return @[url, param];
}

+ (NSString *)defaultUsername {
    return @"15014150833";
}
+ (NSString *)defaultPassword {
    return @"12345678";
}
+ (NSString *)defaultToken {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"defaultToken"];
}

+ (NSString *)appVersion {
    NSString *key = (NSString *)kCFBundleVersionKey;
    // 从Info.plist中取出版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    NSLog(@"version---%@---",version);
    return @"1.0";
}

+ (NSString *)username {
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    if (username != nil) {
        return username;
    }
    return [Interface defaultUsername];
}

+ (NSString *)password {
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    if (password != nil) {
        return password;
    }
    return [Interface defaultPassword];
}

+ (NSString *)token {
    if ([[Interface username] isEqualToString:@"15014150833"]) {
        return [Interface defaultToken];
    }
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

+ (NSString *)utf8String:(NSString *)string {
    return [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)unicode2ISO88591:(NSString *)string {
    NSStringEncoding enc =      CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
    return [NSString stringWithCString:[string UTF8String] encoding:enc];
}

+ (NSArray *)appsendverfcode:(NSString *)username
                        uuid:(NSString *)uuid {
    NSString *url = [NSString stringWithFormat:@"%@appsendverfcode.action",[Interface url]];
    NSDictionary *param = @{@"username":username,
                            @"type":@"0",
                            @"uuid":uuid,
                            @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)applogin:(NSString *)username
             password:(NSString *)password
                 type:(NSString *)type
            verf_code:(NSString *)verf_code
                 uuid:(NSString *)uuid {
    
    NSString *url = [NSString stringWithFormat:@"%@applogin.action",[Interface url]];
    NSDictionary *param = @{@"username":username,
                            @"password":password,
                            @"type":type,
                            @"verf_code":verf_code,
                            @"uuid":uuid,
                            @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)appregister:(NSString *)username
                password:(NSString *)password
                  mobile:(NSString *)mobile {
    NSString *url = [NSString stringWithFormat:@"%@appregister.action",[Interface url]];
    NSString *terminal_os = @"iOS";
    NSDictionary *param = @{@"username":username,
                            @"password":password,
                            @"mobile":mobile,
                            @"terminal_os":terminal_os,
                            @"user_type":@"0"};
    return @[url,param];
}

+ (NSArray *)appcheckverfcode:(NSString *)username
                       mobile:(NSString *)mobile
                    verf_code:(NSString *)verf_code
                         type:(NSString *)type
                         uuid:(NSString *)uuid {
    NSString *url = [NSString stringWithFormat:@"%@appcheckverfcode.action",[Interface url]];
    NSDictionary *param = @{@"username":username,
                            @"mobile":mobile,
                            @"verf_code":verf_code,
                            @"type":type,
                            @"uuid":uuid,
                            @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)appresetpassword:(NSString *)username
                 new_password:(NSString *)new_password
                         uuid:(NSString *)uuid
                    verf_code:(NSString *)verf_code
                         type:(NSString *)type {
    NSString *url = [NSString stringWithFormat:@"%@appresetpassword.action",[Interface url]];
    NSDictionary *param = @{@"username":username,
                            @"new_password":new_password,
                            @"uuid":uuid,
                            @"verf_code":verf_code,
                            @"type":@"2",
                            @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)appresetusername:(NSString *)username
                 new_username:(NSString *)new_username {
    NSString *url = [NSString stringWithFormat:@"%@appresetusername.action",[Interface url]];
    NSDictionary *param = @{@"username":username,
                            @"new_username":new_username,
                            @"token":[Interface token],
                            @"version":[Interface appVersion]};
    return @[url,param];
}

///////////////////////////////////////////////////////////////////////
+ (NSArray *)appgetconfig_key:(NSString *)config_key {
    NSString *url = [NSString stringWithFormat:@"%@appgetconfig.action",[Interface url]];
    NSString *screen_size = [NSString stringWithFormat:@"%.0lfx%.0lf",[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height];
    NSDictionary *param = @{@"username":[Interface username],
                            @"config_key":config_key,
                            @"screen_size":screen_size,
                            @"token":[Interface token],
                            @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)appgetservices {
    NSString *url = [NSString stringWithFormat:@"%@appgetservices.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username],
                            @"token":[Interface token],
                            @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)appgetrecommend {
    NSString *url = [NSString stringWithFormat:@"%@appgetrecommend.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username],
                            @"token":[Interface token],
                            @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)appgetsecondhandcar {
    NSString *url = [NSString stringWithFormat:@"%@appgetsecondhandcar.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username],
                            @"token":[Interface token],
                            @"version":[Interface appVersion]};
    return @[url,param];
}

///////////////////////////////////////////////////////////////////////
+ (NSArray *)appgetmerchantslist_city_filter:(NSString *)city_filter
                              service_filter:(NSString *)service_filter {
    NSString *url = [NSString stringWithFormat:@"%@appgetmerchantslist.action",[Interface url]];
    //city_filter 如果城市名后带有 市 字，删除之
    NSString *city_name = [[NSMutableString stringWithString:city_filter] stringByReplacingOccurrencesOfString:@"市" withString:@""];
    NSDictionary *param = @{@"username":[Interface username],
                            //设置unicode utf-8
                            @"city_filter":[Interface unicode2ISO88591:city_name],
                            @"service_filter":[Interface unicode2ISO88591:service_filter],
                            @"token":[Interface token],
                            @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)appgetprocess_filter:(NSString *)filter {
    NSString *url = [NSString stringWithFormat:@"%@appgetprocess.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username],
                            //设置unicode ISO88591
                            @"filter":[Interface unicode2ISO88591:filter],
                            @"token":[Interface token],
                            @"version":[Interface appVersion]};
    return @[url,param];
}

///////////////////////////////////////////////////////////////////////
+ (NSArray *)appgetprivate {
    NSString *url = [NSString stringWithFormat:@"%@appgetprivate.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username],
                            @"token":[Interface token],
                            @"version":[Interface appVersion]};
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
    NSDictionary *param = @{@"username":[Interface username],
                            @"car_type":car_type,
                            @"city":city,
                            @"vehicle_number":vehicle_number,
                            @"engine_number":engine_number,
                            @"frame_number":frame_number,
                            @"buy_insu_time":buy_insu_time,
                            @"first_mantain_time":first_mantain_time,
                            @"travel_mileage":travel_mileage,
                            @"comments":comments,
                            @"token":[Interface token],
                            @"version":[Interface appVersion]};
    return @[url,param];
}

///////////////////////////////////////////////////////////////////////

+ (NSArray *)appgetmerchants_name:(NSString *)merchant_name {
    NSString *url = [NSString stringWithFormat:@"%@appgetmerchants.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username],
                            @"merchant_name":merchant_name,
                            @"token":[Interface token],
                            @"version":[Interface appVersion]};
    return @[url,param];
}

///////////////////////////////////////////////////////////////////////
+ (NSArray *)appadvise_text:(NSString *)advise_text {
    NSString *url = [NSString stringWithFormat:@"%@appgetmerchants.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username],
                            @"advise_text":advise_text,
                            @"token":[Interface token],
                            @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)apploguseroperation_click_area:(NSString *)click_area detail:(NSString *)detail {
    NSString *url = [NSString stringWithFormat:@"%@appgetmerchantslist.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username],
                            @"click_area":click_area,
                            @"detail":detail,
                            @"token":[Interface token],
                            @"version":[Interface appVersion]};
    return @[url,param];
}

@end
