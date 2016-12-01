//
//  AddressPickerController.h
//  MerchantCarmgr
//
//  Created by admin on 16/9/20.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "SecondaryViewController.h"

typedef void(^returnAddress)(NSArray *address);

@interface AddressPickerController : SecondaryViewController

@property (nonatomic, copy) returnAddress block;

- (void)selectedAddress:(returnAddress)address;

@end
