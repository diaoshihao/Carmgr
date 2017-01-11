//
//  DetailServiceTableViewController.h
//  Carmgr
//
//  Created by admin on 2016/12/28.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailServiceModel.h"

//返回高度的回调
typedef void(^ServiceContentHeightBlock)(CGFloat height);

//返回service_id回调
typedef void(^SubscribeServiceBlock)(DetailServiceModel *model);

@interface DetailServiceTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, assign) BOOL lookMore;

@property (nonatomic, copy) ServiceContentHeightBlock contentBlock;

@property (nonatomic, copy) SubscribeServiceBlock subscribe;


- (void)contentHeightReturn:(ServiceContentHeightBlock)contentBlock;

- (void)subscribeService_id:(SubscribeServiceBlock)subscribe;

@end
