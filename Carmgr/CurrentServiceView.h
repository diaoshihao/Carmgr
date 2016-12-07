//
//  CurrentServiceView.h
//  Carmgr
//
//  Created by admin on 2016/12/5.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentServiceView : UIView

@property (nonatomic, strong) NSString *serviceName;

@property (nonatomic, strong) NSString *merchantName;

@property (nonatomic, strong) NSString *price;

- (void)configView;

@end
