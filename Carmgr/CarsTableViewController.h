//
//  CarsTableViewController.h
//  Carmgr
//
//  Created by admin on 2017/1/10.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectCarBlock)(NSString *car);

@interface CarsTableViewController : UITableViewController

@property (nonatomic, copy) SelectCarBlock selectBlock;

- (void)didSelectCar:(SelectCarBlock)selectBlock;

@end
