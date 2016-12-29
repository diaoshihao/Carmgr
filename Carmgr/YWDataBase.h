//
//  YWDataBase.h
//  Carmgr
//
//  Created by admin on 16/7/17.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
#import "MerchantModel.h"
#import "ProgressModel.h"
#import "PrivateModel.h"

@interface YWDataBase : NSObject

//获取数据库管理对象单例的方法
+ (YWDataBase *)sharedDataBase;

//返回数据的路径
+ (NSString *)getDataBasePath;

//关闭数据库
- (void)closeDataBase;

//判断是否存在数据
- (BOOL)isExistsDataInTable:(NSString *)table_name;

//清空数据库
- (BOOL)deleteDatabaseFromTable:(NSString *)table_name;


//商家
- (BOOL)insertStoreWithModel:(MerchantModel *)model;

- (NSMutableArray *)getAllDataFromStore;


//进度
- (BOOL)insertProcessWithModel:(ProgressModel *)model;

- (NSMutableArray *)getAllDataFromProcess;


//个人资料
- (BOOL)insertPrivateWithModel:(PrivateModel *)model;

- (NSMutableArray *)getAllDataFromPrivate;


@end
