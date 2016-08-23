//
//  GuideViewController.m
//  Carmgr
//
//  Created by admin on 16/7/29.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "GuideViewController.h"
#import "YWTabBarController.h"
#import <Masonry.h>

@interface GuideViewController () <UIScrollViewDelegate>

@end

@implementation GuideViewController
{
    UIPageControl *pageControl;
    UIScrollView *guidePage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self guidePageScrollView];
}

- (void)guidePageScrollView {
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    guidePage = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:guidePage];
    
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd",i+1]];
        
        if (i == 2) {
            imageView.userInteractionEnabled = YES;
            UIButton *button = [self createButton];
            [imageView addSubview:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(imageView.mas_bottom).with.offset(-height * 300 / 1136);
                make.width.mas_equalTo(width * 400 / 750);
                make.height.mas_equalTo(height*100/1136);
                make.centerX.mas_equalTo(imageView);
            }];
        }
        
        [guidePage addSubview:imageView];
    }
    guidePage.contentSize = CGSizeMake(3 * width, height);
    guidePage.pagingEnabled = YES;
    guidePage.bounces = NO;
    guidePage.showsHorizontalScrollIndicator = NO;
    
    guidePage.delegate = self;
    pageControl = [[UIPageControl alloc] init];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0];
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    [self.view addSubview:pageControl];
    [pageControl bringSubviewToFront:guidePage];
    
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(height-50);
        make.centerX.mas_equalTo(self.view);
    }];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/scrollView.frame.size.width;
    pageControl.currentPage = index;
}

- (UIButton *)createButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor clearColor]];
    [button addTarget:self action:@selector(entryHomePage) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)entryHomePage {
    
    [guidePage removeFromSuperview];
    [pageControl removeFromSuperview];
    
    [UIApplication sharedApplication].delegate.window.rootViewController = [[YWTabBarController alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
