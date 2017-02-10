//
//  RateTableViewController.h
//  Carmgr
//
//  Created by admin on 2016/12/29.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^RateContentHeightBlock)(CGFloat height);

@interface RateTableViewController : UITableViewController

//@property (nonatomic, assign) CGFloat contentHeight;

//@property (nonatomic, assign) BOOL lookMore;

@property (nonatomic, strong) NSArray *dataArr;

//@property (nonatomic, copy) RateContentHeightBlock contentBlock;

//- (void)contentHeightReturn:(RateContentHeightBlock)contentBlock;

@end
