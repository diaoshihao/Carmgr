//
//  SingleLocation.h
//  Carmgr
//
//  Created by admin on 2016/12/15.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>

typedef void(^LocationComplete)(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error);

@interface SingleLocation : NSObject <AMapLocationManagerDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;

@property (nonatomic, copy) LocationComplete completeBlock;

- (void)locationComplete:(LocationComplete)complete;

@end
