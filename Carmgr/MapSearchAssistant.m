//
//  MapSearchAssistant.m
//  Carmgr
//
//  Created by admin on 2017/2/9.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "MapSearchAssistant.h"

@interface MapSearchAssistant() <AMapSearchDelegate>

@property (nonatomic, strong) AMapCloudPOIAroundSearchRequest *searchRequest;

@end

@implementation MapSearchAssistant

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configMapSearch];
    }
    return self;
}

- (void)setTableID:(NSString *)tableID {
    _tableID = tableID;
    self.searchRequest.tableID = tableID;
}

- (void)configMapSearch {
    self.mapSearch = [[AMapSearchAPI alloc] init];
    self.mapSearch.delegate = self;
    
    self.searchRequest = [[AMapCloudPOIAroundSearchRequest alloc] init];
}

- (void)startMapSearchAround {
    AMapGeoPoint *centerPoint = [AMapGeoPoint locationWithLatitude:self.center.latitude longitude:self.center.longitude];
    self.searchRequest.center = centerPoint;
    self.searchRequest.keywords = self.keywords;
    
    [self.mapSearch AMapCloudPOIAroundSearch:self.searchRequest];
}

- (void)onCloudSearchDone:(AMapCloudSearchBaseRequest *)request response:(AMapCloudPOISearchResponse *)response {
    if (self.cloudPOIsBlock) {
        self.cloudPOIsBlock(response.POIs);
    }
}

- (void)cloudPOIsDidLoad:(CloudPOIsBlock)cloudPOIsBlock {
    self.cloudPOIsBlock = cloudPOIsBlock;
}

@end
