//
//  CurrentServiceScrollView.h
//  Carmgr
//
//  Created by admin on 2016/12/5.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentServiceScrollView : UIScrollView

@property (nonatomic, strong) NSArray *nearbyServices;

- (void)reloadData;

@end
