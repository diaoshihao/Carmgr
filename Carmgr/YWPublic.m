//
//  YWPublic.m
//  Carmgr
//
//  Created by admin on 16/6/20.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "YWPublic.h"
#import "YWLoginViewController.h"

@implementation YWPublic

#pragma mark - MD5加密
+ (NSString *)encryptMD5String:(NSString *)string{
    
    return [string MD5Encryption];
}

+ (void)userOperationInClickAreaID:(NSString *)click_area_id detial:(NSString *)detail {
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *urlStr = [[NSString stringWithFormat:kOPERATION,username,click_area_id,detail,token] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];;
    [YWPublic afPOST:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"useroperation %@",dataDict[@"opt_state"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//POST
+ (void)afPOST:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject: @"text/html"];
    
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

//创建Button
+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString * _Nullable)title imageName:(NSString * _Nullable)imageName {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (imageName != nil) {
        [button setImage:[YWPublic imageNameWithOriginalRender:imageName] forState:UIControlStateNormal];
    }
    
    return button;
}

//图片渲染模式
+ (UIImage *)imageNameWithOriginalRender:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

/**
 *  创建圆形图片
 */
+ (UIImageView *)createCycleImageViewWithFrame:(CGRect)frame image:(NSString *)img_path placeholder:(nonnull NSString *)placeholder {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    [imageView setImageWithURL:[NSURL URLWithString:img_path] placeholderImage:[UIImage imageNamed:placeholder]];
    imageView.layer.cornerRadius = imageView.frame.size.height / 2;
    imageView.clipsToBounds = YES;
    return imageView;
}

+ (UITextField *)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder isSecure:(BOOL)isSecure {
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.placeholder = placeholder;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.secureTextEntry = isSecure;
    textField.backgroundColor = [UIColor whiteColor];
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}

//push登录
+ (void)pushToLogin:(UIViewController *)VC {
    YWLoginViewController *loginVC = [[YWLoginViewController alloc] init];
    loginVC.isFromHome = YES;
    loginVC.fromVC = (BaseViewController *)VC;
    UINavigationController *navigaVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [VC presentViewController:navigaVC animated:YES completion:nil];
}

+ (UIAlertController *)showReLoginAlertViewAt:(UIViewController *)VC {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户不存在或已过期，请注册或登录后刷新页面" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [cancel setValue:[UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0] forKey:@"titleTextColor"];
    
    UIAlertAction *login = [UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        YWLoginViewController *loginVC = [[YWLoginViewController alloc] init];
        loginVC.isFromHome = YES;
        loginVC.fromVC = (BaseViewController *)VC;
        UINavigationController *navigaVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [VC presentViewController:navigaVC animated:YES completion:nil];
    }];
    [login setValue:[UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0] forKey:@"titleTextColor"];
    
    [alertVC addAction:cancel];
    [alertVC addAction:login];
    return alertVC;
}

+ (UIAlertController *)showFaileAlertViewAt:(UIViewController *)VC {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"获取数据失败，请检查网络" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [action setValue:[UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0] forKey:@"titleTextColor"];
    [alertVC addAction:action];
    return alertVC;
}

@end
