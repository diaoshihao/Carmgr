//
//  AddressPickerController.h
//  MerchantCarmgr
//
//  Created by admin on 16/9/20.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "CustomBarViewController.h"

typedef void(^returnAddress)(NSArray *address);

@interface AddressPickerController : CustomBarViewController

@property (nonatomic, copy) returnAddress block;

@end
