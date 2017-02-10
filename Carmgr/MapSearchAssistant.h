//
//  MapSearchAssistant.h
//  Carmgr
//
//  Created by admin on 2017/2/9.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapSearchKit/AMapSearchKit.h>

typedef void(^CloudPOIsBlock)(NSArray *POIs);

@interface MapSearchAssistant : NSObject

@property (nonatomic, strong) AMapSearchAPI *mapSearch;

@property (nonatomic, strong) NSString *tableID;

@property (nonatomic, assign) CLLocationCoordinate2D center;

@property (nonatomic, strong) NSString *keywords;

@property (nonatomic, copy) CloudPOIsBlock cloudPOIsBlock;

- (void)startMapSearchAround;

- (void)cloudPOIsDidLoad:(CloudPOIsBlock)cloudPOIsBlock;

@end
