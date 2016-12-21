//
//  MapViewController.h
//  Carmgr
//
//  Created by admin on 2016/12/15.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocation.h>

//周边搜索结果
typedef void(^AroundSearch)(NSArray *aroundData);

//当前定位经纬度（持续定位）
typedef void(^UpdatingLocation)(CLLocationCoordinate2D record);

@interface MapViewController : UIViewController

@property (nonatomic, copy) UpdatingLocation locationBlock;

@property (nonatomic, copy) AroundSearch aroundSearch;

@property (nonatomic, strong) NSString *tableID;

- (void)updatingLocation:(UpdatingLocation)location;

- (void)startAroundSearch:(NSString *)keywords center:(CLLocationCoordinate2D)record;

- (void)dataDidLoad:(AroundSearch)aroundData;

@end
