//
//  MyNetworker.m
//  MerchantCarmgr
//
//  Created by admin on 2016/11/10.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "MyNetworker.h"

@implementation MyNetworker


+ (NSURLSessionTask *)POST:(NSString *)URL parameters:(NSDictionary *)parameters success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure {
    //不设置👇，参数无法传到服务器，为null(已在PPNetworkHelper的初始化中修改)
//    [PPNetworkHelper setRequestSerializer:PPRequestSerializerHTTP];
    
    return [PPNetworkHelper POST:URL parameters:parameters success:success failure:failure];
}

+ (NSURLSessionTask *)POST:(NSString *)URL parameters:(NSDictionary *)parameters responseCache:(HttpRequestCache)responseCache success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure {
    return [PPNetworkHelper POST:URL parameters:parameters responseCache:responseCache success:success failure:failure];
}

+ (NSURLSessionTask *)uploadWithURL:(NSString *)URL parameters:(NSDictionary *)parameters images:(NSArray<UIImage *> *)images name:(NSString *)name fileName:(NSArray<NSString *> *)fileName mimeType:(NSString *)mimeType progress:(HttpProgress)progress success:(HttpRequestSuccess)success failure:(HttpRequestFailed)failure {
    
    return [PPNetworkHelper uploadWithURL:URL parameters:parameters images:images name:name fileName:fileName mimeType:mimeType progress:progress success:success failure:failure];
}

@end
