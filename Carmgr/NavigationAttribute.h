//
//  NavigationAttribute.h
//  Carmgr
//
//  Created by admin on 16/6/21.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NavigationAttribute : UIView

- (UINavigationController *)createVCWithClass:(NSString *)className
                                        Title:(NSString *)title
                                        Image:(NSString *)imageName
                                  selectImage:(NSString *)selectImage;

@end
