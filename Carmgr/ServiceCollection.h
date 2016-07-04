//
//  ServiceCollection.h
//  Carmgr
//
//  Created by admin on 16/7/1.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ServiceCollection : NSObject 

@property (nonatomic, strong) NSArray      *imageArr;
@property (nonatomic, strong) NSArray      *titleArr;

@property (nonatomic, strong) UIViewController *VC; //用于跳转界面


- (void)createServiceCollectionViewAtSuperView:(UIView *)superView;

@end
