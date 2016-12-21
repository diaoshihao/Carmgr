//
//  AddressManager.h
//  Carmgr
//
//  Created by admin on 2016/12/21.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressManager : NSObject

+ (instancetype)manager;

//all
- (NSArray<NSDictionary *> *)allAddressDict;

//province
- (NSDictionary *)provinceDictFromProvince:(NSString *)province;

//abbreviation
- (NSString *)abbreviationFromProvince:(NSString *)province;

//id
- (NSString *)idcodeFromProvince:(NSString *)province;
- (NSString *)idcodeFromCity:(NSString *)city;
- (NSString *)idcodeFromArea:(NSString *)area;

//city dicts in province
- (NSArray<NSDictionary *> *)cityDictsFromProvince:(NSString *)province;

//city list in province
- (NSArray<NSString *> *)cityListFromProvince:(NSString *)province;

//area dicts in city in province
- (NSArray<NSDictionary *> *)areaDictsFromCity:(NSString *)city province:(NSString *)province;

//area list in city in province
- (NSArray<NSString *> *)areaListFromCity:(NSString *)city province:(NSString *)province;



@end
