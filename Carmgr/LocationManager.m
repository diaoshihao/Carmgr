//
//  LocationManager.m
//  MerchantCarmgr
//
//  Created by admin on 16/9/21.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

- (CLLocationManager *)locationManager {
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}

- (void)starLocation {
    self.locationManager.delegate = self;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 100.0f;
    [self.locationManager startUpdatingLocation];
}

- (void)locationCompletion:(locationSuccess)success faile:(locationFaile)faile {
    self.successBlock = success;
    self.faileBlock = faile;
}

- (void)geocoder:(CLLocation *)location {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error || placemarks.count == 0) {
            self.faileBlock(error);
        } else {
            NSDictionary *addressDict = placemarks.firstObject.addressDictionary;
            self.successBlock(addressDict[@"City"]);
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [manager stopUpdatingLocation];
    [self geocoder:locations.lastObject];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    self.faileBlock(error);
}

- (void)locationSuccess:(locationSuccess)block {
    self.successBlock = block;
}

- (void)locationFaile:(locationFaile)block {
    self.faileBlock = block;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
