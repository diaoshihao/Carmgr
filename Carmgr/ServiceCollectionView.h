//
//  ServiceCollectionView.h
//  Carmgr
//
//  Created by admin on 2016/11/24.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ServiceModel;

typedef void(^DidSelectItem)(ServiceModel *model);

@interface ServiceCollectionView : UIView

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, copy) DidSelectItem didSelectItem;

- (void)reloadData;

@end
