//
//  LoadHomeData.h
//  Carmgr
//
//  Created by admin on 2016/11/24.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, Config_Key) {
    Config_ZY0001,
    Config_ZY0002,
    Config_ZY0003,
    Config_ZY0004,
    Config_ZY0005,
};

@protocol HomeDataSource <NSObject>

- (void)loadConfig_key:(Config_Key)config_key data:(NSArray *)data;

- (void)loadServices:(NSArray *)services;

- (void)loadSecondHand:(NSArray *)secondHand;

- (void)requestAllDone;

- (void)loadSuccess;

- (void)loadFailed;

@end

@interface HomeDataLoader : NSObject

@property (nonatomic, weak) id<HomeDataSource> dataSource;

@property (nonatomic, assign) BOOL dataDidLoad;
@property (nonatomic, assign) BOOL dataLoadFailed;


- (void)loadData;


@end
