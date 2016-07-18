//
//  YWDataBase.m
//  Carmgr
//
//  Created by admin on 16/7/17.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "YWDataBase.h"

@implementation YWDataBase
{
    //数据库
    FMDatabase *_database;
}

//定义单例对象
#pragma mark -- 单例对象获取,数据库操作
- (id)init
{
    if (self = [super init]) {
        //初始化数据库对象 并打开
        _database = [FMDatabase databaseWithPath:[YWDataBase getDataBasePath]];
        //如果数据库打开失败返回空值
        if (![_database open]) {
            NSLog(@"打开数据库失败");
            return nil;
        }
    }
    //如果数据库打开成功 创建表
    //创建商家数据表
    NSString *storeSql = @"create table if not exists tb_store(tb_id integer primary key autoincrement,merchant_name text,img_path text,mobile text,address text,stars float,service_item text,tags text,total_rate text)";
//    NSString *processSql = @"create table if not exists tb_process(tb_id integer primary key autoincrement,";
    
    BOOL isStore = [_database executeUpdate:storeSql];
    
    if (isStore) {
        NSLog(@"创建表成功！");
    }
    
#if 0
    //创建搜索历史记录表
    NSString *sql = @"create table if not exists tb_home(tb_id integer primary key autoincrement,seachText text)";
    
    //创建购物车表
    NSString *sql2 = @"create table if not exists tb_car(carId integer primary key autoincrement,pdcId text,pdcSID text,img text,selected text,name text,price float,yprice float,allcnt text,qishu text,allneed text,leftneed text)";
    //创建兴趣推荐表
    NSString *sql3 = @"create table if not exists tb_intrest_car(carId integer primary key autoincrement,pdcID text,pdcSID text,img text,selected integer,name text,price float,yprice float,allcnt integer)";
    //创建系统消息表
    NSString *sql4 = @"create table if not exists tb_News(tb_id integer primary key autoincrement,  integer,newTitle text,newTime text,isScanfed integer)";
    
    BOOL is = [_database executeUpdate:sql];
    BOOL is2 = [_database executeUpdate:sql2];
    BOOL is3 = [_database executeUpdate:sql3];
    BOOL is4 = [_database executeUpdate:sql4];
    
    if (is2 && is && is3 && is4) {
        NSLog(@"创建表成功！");
    }
    
#endif
    return self;
}
//获取数据库管理对象单例的方法
+ (YWDataBase *)sharedDataBase
{
    static YWDataBase *database = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        database = [[YWDataBase alloc]init];
    });
    
    return database;
}
//返回数据库的路径
+ (NSString *)getDataBasePath
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    return [path stringByAppendingPathComponent:@"carmgr.db"];
}

//清空数据库
- (BOOL)deleteDatabase {
    NSString *deleteStore = @"delete from tb_store";
    BOOL storeDelete = [_database executeUpdate:deleteStore];
    if (storeDelete) {
        return YES;
    }
    return NO;
}

//关闭数据库
- (void)closeDataBase
{
    if (_database) {
        [_database close];
    }
}

#pragma mark -- 商家Store数据表
//插入数据
- (BOOL)insertStoreWithModel:(StoreModel *)model {
    NSString *insertStore = @"insert into tb_store(merchant_name,img_path,mobile,address,stars,service_item,tags,total_rate) values(?,?,?,?,?,?,?,?)";
    
    BOOL storeInsert = [_database executeUpdate:insertStore,model.merchant_name,model.img_path,model.mobile,model.address,model.stars,model.service_item,model.tags,model.total_rate];
    
    if (storeInsert) {
        NSLog(@"插入成功");
        return YES;
    } else {
        NSLog(@"插入失败:%@,%@,%@,%@,%@,%@,%@,%@",model.merchant_name,model.img_path,model.mobile,model.address,model.stars,model.service_item,model.tags,model.total_rate);
        return NO;
    }
    
    
}

//判断是否存在数据
- (BOOL)isExistsInStore {
    NSString *queryStore = @"select * from tb_store";
    FMResultSet *resultSet = [_database executeQuery:queryStore];
    if (resultSet.next) {
        NSLog(@"exists");
    }
    return resultSet.next;
}

//获取所有数据
- (NSMutableArray *)getAllDataFromStore {
    NSString *getStore = @"select * from tb_store";
    FMResultSet *resultSet = [_database executeQuery:getStore];
    
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    while (resultSet.next) {
        StoreModel *model = [[StoreModel alloc] init];
        model.merchant_name = [resultSet stringForColumn:@"merchant_name"];
        model.img_path = [resultSet stringForColumn:@"img_path"];
        model.mobile = [resultSet stringForColumn:@"mobile"];
        model.address = [resultSet stringForColumn:@"address"];
        model.stars = [resultSet stringForColumn:@"stars"];
        model.service_item = [resultSet stringForColumn:@"service_item"];
        model.tags = [resultSet stringForColumn:@"tags"];
        model.total_rate = [resultSet stringForColumn:@"total_rate"];
        NSLog(@"%@",model.merchant_name);
        [arrM addObject:model];
    }
    return arrM;
}


@end
