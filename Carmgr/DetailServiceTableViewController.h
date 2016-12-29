//
//  DetailServiceTableViewController.h
//  Carmgr
//
//  Created by admin on 2016/12/28.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ServiceContentHeightBlock)(CGFloat height);

@interface DetailServiceTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, assign) BOOL lookMore;

@property (nonatomic, copy) ServiceContentHeightBlock contentBlock;

- (void)contentHeightReturn:(ServiceContentHeightBlock)contentBlock;

@end
