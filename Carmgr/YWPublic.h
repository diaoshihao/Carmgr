//
//  YWPublic.h
//  Carmgr
//
//  Created by admin on 16/6/20.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//
/// @系统名称   易务车宝1.0 iPhone
/// @模块名称   公共模块
/// @文件名称   YWPublic.h
/// @功能说明   提供公用接口
///
/// @软件版本    1.0.0.0
/// @开发人员    diao shihao
/// @开发时间    2016-06-20
///
/// @修改记录：  最初版本
//
/////////////////////////////////////////////////////////////



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "Interface.h"
#import "CityChooseViewController.h"
#import "NSString+MD5.h"//MD5加密
#import "RegularTools.h"//正则表达式
#import "YWDataBase.h"//数据库
#import "MJRefresh.h"

@interface YWPublic : NSObject

NS_ASSUME_NONNULL_BEGIN

//MD5加密
+ (NSString *)encryptMD5String:(NSString *)string;

//button
+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString * _Nullable)title imageName:(NSString * _Nullable)imageName;

//图片渲染模式
+ (UIImage *)imageNameWithOriginalRender:(NSString *)imageName;

//创建圆形图片
+ (UIImageView *)createCycleImageViewWithFrame:(CGRect)frame image:(NSString *)imageName;

//textfield
+ (UITextField *)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder isSecure:(BOOL)isSecure;

+ (UIAlertController *)showAlertViewAt:(UIViewController *)VC title:(NSString *)title message:(NSString *)message ;


+ (void)afPOST:(NSString *)URLString
    parameters:(nullable id)parameters
       success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
NS_ASSUME_NONNULL_END

@end
