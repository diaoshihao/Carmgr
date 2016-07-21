//
//  YWDataBase.h
//  Carmgr
//
//  Created by admin on 16/7/17.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
#import "StoreModel.h"
#import "ProgressModel.h"

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


- (BOOL)insertStoreWithModel:(StoreModel *)model;

- (NSMutableArray *)getAllDataFromStore;


- (BOOL)insertProcessWithModel:(ProgressModel *)model;

- (NSMutableArray *)getAllDataFromProcess;


@end
