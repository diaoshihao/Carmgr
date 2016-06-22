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

@interface YWPublic : NSObject

+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName;

+ (UIImage *)imageNameWithOriginalRender:(NSString *)imageName;

@end
