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

@interface YWDataBase : NSObject

//获取数据库管理对象单例的方法
+ (YWDataBase *)sharedDataBase;

//返回数据的路径
+ (NSString *)getDataBasePath;

//关闭数据库
- (void)closeDataBase;

//清空数据库
- (BOOL)deleteDatabase;


- (BOOL)insertStoreWithModel:(StoreModel *)model;

- (BOOL)isExistsInStore;

- (NSMutableArray *)getAllDataFromStore;


@end
