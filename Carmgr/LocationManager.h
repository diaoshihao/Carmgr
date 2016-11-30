//
//  LocationManager.h
//  MerchantCarmgr
//
//  Created by admin on 16/9/21.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^locationSuccess)(NSString *location);
typedef void(^locationFaile)(NSError *error);

@interface LocationManager : UIView <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, copy) locationSuccess successBlock;

@property (nonatomic, copy) locationFaile faileBlock;

- (void)starLocation;

- (void)locationCompletion:(locationSuccess)success faile:(locationFaile)faile;

- (void)locationSuccess:(locationSuccess)block;

- (void)locationFaile:(locationFaile)block;

@end
