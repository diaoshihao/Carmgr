//
//  ClassifyScrollView.h
//  Carmgr
//
//  Created by admin on 2016/12/5.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

//block
typedef void(^SelectService)(NSString *selectedService);

//delegate
@protocol ClassifyScrollViewDelegate <NSObject>

- (void)didSelectedCurrentService:(NSString *)currentService;

@end

@interface ClassifyScrollView : UIScrollView

@property (nonatomic, strong) NSArray *services;

@property (nonatomic, strong) id<ClassifyScrollViewDelegate> classifyDelegate;

@property (nonatomic, strong) NSString *currentService;

@property (nonatomic, copy) SelectService selectService;

- (instancetype)initWithDelegate:(id)delegate;

- (void)didSelectedCurrentService:(SelectService)seleted;

@end
