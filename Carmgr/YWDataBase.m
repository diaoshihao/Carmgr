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
        } else {
            //如果数据库打开成功 创建表
            //创建商家数据表
            NSString *storeSql = @"create table if not exists tb_store(tb_id integer primary key autoincrement,img_path text,merchant_name text,stars text,service_item text,mobile text,merchant_introduce text,province text,city text,area text,road text,distance text)";
            NSString *processSql = @"create table if not exists tb_process(tb_id integer primary key autoincrement,img_path text,merchant_account text,merchant_name text,order_id text,order_state text,order_time text,order_type text,service_name text)";
            
            NSString *privateSql = @"create table if not exists tb_private(tb_id  integer primary key autoincrement,username text,avatar text,score text,sex text,city text,money text,order_total_size text,order_topay_size text,order_touse_size text,order_process_size text,order_completed_size text)";
            
            BOOL isStore = [_database executeUpdate:storeSql];
            BOOL isProcess = [_database executeUpdate:processSql];
            BOOL isPrivate = [_database executeUpdate:privateSql];
            
            if (isStore && isProcess && isPrivate) {
                
            } else {
                NSLog(@"创建表失败！");
            }
        }
    }
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
- (BOOL)deleteDatabaseFromTable:(NSString *)table_name {
    NSString *deleteStore = [NSString stringWithFormat:@"delete from %@",table_name];
    BOOL storeDelete = [_database executeUpdate:deleteStore];
    if (storeDelete) {
        return YES;
    }
    return NO;
}

//判断是否存在数据
- (BOOL)isExistsDataInTable:(NSString *)table_name {
    NSString *queryStore = [NSString stringWithFormat:@"select * from %@",table_name];
    FMResultSet *resultSet = [_database executeQuery:queryStore];
    
    return resultSet.next;
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
    NSString *insertStore = @"insert into tb_store(img_path,merchant_name,stars,service_item,mobile,merchant_introduce,province,city,area,road,distance) values(?,?,?,?,?,?,?,?,?,?,?)";
    
    BOOL storeInsert = [_database executeUpdate:insertStore,model.img_path,model.merchant_name,model.stars,model.service_item,model.mobile,model.merchant_introduce,model.province,model.city,model.area,model.road,model.distance];
    
    if (storeInsert) {
        return YES;
    }
    return NO;
}

//获取所有数据
- (NSMutableArray *)getAllDataFromStore {
    NSString *getStore = @"select * from tb_store";
    FMResultSet *resultSet = [_database executeQuery:getStore];
    
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    while (resultSet.next) {
        StoreModel *model = [[StoreModel alloc] init];
        
        model.img_path = [resultSet stringForColumn:@"img_path"];
        model.merchant_name = [resultSet stringForColumn:@"merchant_name"];
        model.stars = [resultSet stringForColumn:@"stars"];
        model.service_item = [resultSet stringForColumn:@"service_item"];
        model.mobile = [resultSet stringForColumn:@"mobile"];
        model.merchant_introduce = [resultSet stringForColumn:@"merchant_introduce"];
        model.province = [resultSet stringForColumn:@"province"];
        model.city = [resultSet stringForColumn:@"city"];
        model.area = [resultSet stringForColumn:@"area"];
        model.road = [resultSet stringForColumn:@"road"];
        model.distance = [resultSet stringForColumn:@"distance"];
        
        [arrM addObject:model];
    }
    return arrM;
}

#pragma mark -- 进度process数据表
//插入数据
- (BOOL)insertProcessWithModel:(ProgressModel *)model {
    NSString *insertProcess = @"insert into tb_process(img_path,merchant_account,merchant_name,order_id,order_state,order_time,order_type,service_name) values(?,?,?,?,?,?,?,?)";
    
    BOOL processInsert = [_database executeUpdate:insertProcess,model.img_path,model.merchant_account,model.merchant_name,model.order_id,model.order_state,model.order_time,model.order_type,model.service_name];
    
    if (processInsert) {
        return YES;
    }
    return NO;
}

//获取所有数据
- (NSMutableArray *)getAllDataFromProcess {
    NSString *getProcess = @"select * from tb_process";
    FMResultSet *resultSet = [_database executeQuery:getProcess];
    
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    while (resultSet.next) {
        ProgressModel *model = [[ProgressModel alloc] init];
        model.img_path = [resultSet stringForColumn:@"img_path"];
        model.merchant_account = [resultSet stringForColumn:@"merchant_account"];
        model.merchant_name = [resultSet stringForColumn:@"merchant_name"];
        model.order_id = [resultSet stringForColumn:@"order_id"];
        model.order_state = [resultSet stringForColumn:@"order_state"];
        model.order_time = [resultSet stringForColumn:@"order_time"];
        model.order_type = [resultSet stringForColumn:@"order_type"];
        model.service_name = [resultSet stringForColumn:@"service_name"];
        [arrM addObject:model];
    }
    return arrM;
}

#pragma mark -- 个人资料Private数据表
//插入数据
- (BOOL)insertPrivateWithModel:(PrivateModel *)model {
    NSString *insertPrivate = @"insert into tb_private(username,avatar,score,sex,city,money,order_total_size,order_topay_size,order_touse_size,order_process_size,order_completed_size) values(?,?,?,?,?,?,?,?,?,?,?)";
    
    BOOL privateInsert = [_database executeUpdate:insertPrivate,model.username,model.avatar,model.score,model.sex,model.city,model.money,model.order_total_size,model.order_topay_size,model.order_touse_size,model.order_process_size,model.order_completed_size];
    
    if (privateInsert) {
        return YES;
    }
    return NO;
}

//获取所有数据
- (NSMutableArray *)getAllDataFromPrivate {
    NSString *getPrivate = @"select * from tb_private";
    FMResultSet *resultSet = [_database executeQuery:getPrivate];
    
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    while (resultSet.next) {
        PrivateModel *model = [[PrivateModel alloc] init];
        
        model.username = [resultSet stringForColumn:@"username"];
        model.avatar = [resultSet stringForColumn:@"avatar"];
        model.score = [resultSet stringForColumn:@"score"];
        model.sex = [resultSet stringForColumn:@"sex"];
        model.city = [resultSet stringForColumn:@"city"];
        model.money = [resultSet stringForColumn:@"money"];
        model.order_total_size = [resultSet stringForColumn:@"order_total_size"];
        model.order_topay_size = [resultSet stringForColumn:@"order_topay_size"];
        model.order_touse_size = [resultSet stringForColumn:@"order_touse_size"];
        model.order_process_size = [resultSet stringForColumn:@"order_process_size"];
        model.order_completed_size = [resultSet stringForColumn:@"order_completed_size"];
        
        [arrM addObject:model];
    }
    return arrM;
}

@end
