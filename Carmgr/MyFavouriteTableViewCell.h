//
//  MyFavouriteTableViewCell.h
//  Carmgr
//
//  Created by admin on 2016/12/12.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CollectionAction) {
    CollectionActionCancel,
    CollectionActionAppoint,
    CollectionActionShare,
};

typedef void(^CollectionClick)(CollectionAction action);

@interface MyFavouriteTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *serviceName;
@property (nonatomic, strong) UILabel *merchantName;
@property (nonatomic, strong) UILabel *price;

@property (nonatomic, copy) CollectionClick collectionClick;

- (void)collectionAction:(CollectionClick)click;

@end
