//
//  AddressManager.m
//  Carmgr
//
//  Created by admin on 2016/12/21.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "AddressManager.h"

@implementation AddressManager

+ (instancetype)manager {
    static AddressManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (NSArray<NSDictionary *> *)allAddressDict {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"citydata" ofType:@"plist"];
    NSArray *provinces = [NSArray arrayWithContentsOfFile:filePath];
    return provinces;
}

- (NSDictionary *)provinceDictFromProvince:(NSString *)province {
    for (NSDictionary *provinceDict in [self allAddressDict]) {
        if ([provinceDict[@"provinceName"] isEqualToString:province]) {
            return provinceDict;
        }
    }
    return nil;
}

- (NSString *)abbreviationFromProvince:(NSString *)province {
    NSDictionary *provinceDict = [self provinceDictFromProvince:province];
    return provinceDict[@"name"];
}

- (NSArray<NSDictionary *> *)cityDictsFromProvince:(NSString *)province {
    NSDictionary * provinceDict = [self provinceDictFromProvince:province];
    NSArray *cityItems = provinceDict[@"citylist"];
    return cityItems;
}

- (NSArray<NSString *> *)cityListFromProvince:(NSString *)province {
    NSArray *cityItems = [self cityDictsFromProvince:province];
    NSMutableArray *citylist = [NSMutableArray arrayWithCapacity:cityItems.count];
    for (NSDictionary *item in cityItems) {
        [citylist addObject:item[@"cityName"]];
    }
    return citylist;
}

- (NSArray<NSDictionary *> *)areaDictsFromCity:(NSString *)city province:(NSString *)province {
    NSArray *cityItems = [self cityDictsFromProvince:province];
    for (NSDictionary *cityDict in cityItems) {
        if ([cityDict[@"cityName"] hasPrefix:city]) {
            NSArray *areaItems = cityDict[@"arealist"];
            NSMutableArray *areaDicts = [NSMutableArray arrayWithCapacity:areaItems.count];
            for (NSDictionary *dict in areaItems) {
                [areaDicts addObject:dict];
            }
            return areaDicts;
        }
    }
    return nil;
}

- (NSArray<NSString *> *)areaListFromCity:(NSString *)city province:(NSString *)province {
    NSArray *areaDicts = [self areaDictsFromCity:city province:province];
    NSMutableArray *areaList = [NSMutableArray arrayWithCapacity:areaDicts.count];
    for (NSDictionary *dict in areaDicts) {
        [areaList addObject:dict[@"areaName"]];
    }
    return areaList;
}

@end
