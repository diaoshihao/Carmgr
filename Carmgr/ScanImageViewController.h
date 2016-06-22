//
//  ScanImageViewController.h
//  二维码生成与扫描
//
//  Created by 周鑫 on 15/11/7.
//  Copyright © 2015年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScanImageView<NSObject>

- (void)reportScanResult:(NSString *)result;

@end

@interface ScanImageViewController : UIViewController

@property (nonatomic,weak)id <ScanImageView>delegate;//代理方法传递数据


@end
