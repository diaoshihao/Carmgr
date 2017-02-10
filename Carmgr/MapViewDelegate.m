//
//  MapViewDelegate.m
//  Carmgr
//
//  Created by admin on 2017/2/9.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "MapViewDelegate.h"
#import "POIAnnotation.h"
#import "CustomAnnotationView.h"
#import "LocationAnnotationView.h"

@interface MapViewDelegate()

@property (nonatomic, strong) LocationAnnotationView *locationAnnotationView;

@property (nonatomic, assign) CLLocationCoordinate2D location;

@end

@implementation MapViewDelegate

//定位图标指示方向
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    /* 自定义userLocation对应的annotationView. */
    /*
    if ([annotation isKindOfClass:[MAUserLocation class]])
    {
        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[LocationAnnotationView alloc] initWithAnnotation:annotation
                                                                reuseIdentifier:userLocationStyleReuseIndetifier];
        }
        
        annotationView.image = [UIImage imageNamed:@"userPosition"];
        annotationView.canShowCallout = YES;
        self.locationAnnotationView = (LocationAnnotationView *)annotationView;
        
        return annotationView;
        
        //地图标注view
    } else
        */
        if ([annotation isKindOfClass:[POIAnnotation class]]) {
        
        static NSString *poiAnnotationStyle = @"poiAnnotation";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:poiAnnotationStyle];
        
        if (annotationView == nil) {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:poiAnnotationStyle];
        }
        POIAnnotation *poi = (POIAnnotation *)annotation;
        
        annotationView.frame = CGRectMake(0, 0, 60, 60);
        //        [annotationView setCenterOffset:CGPointMake(0, annotationView.frame.size.height/2)];
        
        annotationView.merchantImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:poi.poi.images.firstObject.preurl]]];
        
        return annotationView;
    }
    
    return nil;
}

//单击地图收起键盘
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (self.currentBlock) {
        self.currentBlock(-1);
    }
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
    if ([view isKindOfClass:[CustomAnnotationView class]]) {
        NSInteger index = [self.annotations indexOfObject:view.annotation];
        if (self.currentBlock) {
            self.currentBlock(index);
        }
    }
}

- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view {
    
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
//    if (!updatingLocation && _locationAnnotationView != nil)
//    {
//        [UIView animateWithDuration:0.1 animations:^{
//            _locationAnnotationView.rotateDegree = userLocation.heading.magneticHeading;
//        }];
//    }
    
    if (self.location.latitude != userLocation.coordinate.latitude || self.location.longitude != userLocation.coordinate.longitude) {
        self.location = userLocation.coordinate;
        
        //返回当前经纬度回调
        if (self.locationBlock) {
            self.locationBlock(self.location);
        }
    }
}

//移动地图
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction {
    //用户移动地图
    if (wasUserAction) {
        if (self.moveMapBlock) {
            self.moveMapBlock(mapView.centerCoordinate);
        }
    }
}

#pragma mark - Block
- (void)locationDidUpdating:(LocationUpdatingBlock)locationBlock {
    self.locationBlock = locationBlock;
}

- (void)userDidMoveMapView:(UserMoveMapBlock)moveMapBlock {
    self.moveMapBlock = moveMapBlock;
}

- (void)currentAnnotationView:(CurrentAnnotationBlock)currentBlock {
    self.currentBlock = currentBlock;
}

@end
