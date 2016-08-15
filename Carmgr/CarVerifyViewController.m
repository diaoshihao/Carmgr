//
//  AddCarInfoViewController.m
//  Carmgr
//
//  Created by admin on 16/7/11.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "CarVerifyViewController.h"
#import <Masonry.h>
#import "AddCarInfoViewController.h"

@interface CarVerifyViewController ()

@property (nonatomic, strong) UIView *firstView;
@property (nonatomic, strong) UIView *secondView;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation CarVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self customLeftItem];
    
    self.scrollView = [self createScrollView];
    
    self.firstView = [self createCommitView:@"行驶证" title:@"上传行驶证"];
    self.secondView = [self createCommitView:@"保险单" title:@"上传保险单"];
    
    [self createLabelAndButton];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

- (void)customLeftItem {
    self.navigationItem.title = @"车辆认证";
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    leftButton.contentMode = UIViewContentModeLeft;
    [leftButton setImage:[UIImage imageNamed:@"后退"] forState:UIControlStateNormal];
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftButton addTarget:self action:@selector(cancelAddCarInfo) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)cancelAddCarInfo {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIScrollView *)createScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height-64);
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    return scrollView;
}

- (UIView *)createCommitView:(NSString *)imageName title:(NSString *)title {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:imageName];
    [view addSubview:imageView];
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    if ([button.titleLabel.text isEqualToString:@"上传行驶证"]) {
        button.tag = 100;
    } else {
        button.tag = 200;
    }
    [button addTarget:self action:@selector(callActionSheet) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    //控件内置大小（根据内容大小）
    CGSize imageSize = imageView.intrinsicContentSize;
    CGSize buttonSize = button.intrinsicContentSize;
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        if (button.tag == 100) {
            make.top.mas_equalTo(15);
        } else {
            make.top.mas_equalTo(self.firstView.mas_bottom).with.offset(15);
        }
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(imageSize.height+buttonSize.height+50);
    }];
    
    [imageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [imageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.centerX.mas_equalTo(view);
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).with.offset(20);
        make.width.mas_equalTo(self.view.bounds.size.width/3);
        //height
        make.centerX.mas_equalTo(view);
    }];
    
    return view;
}

- (void)createLabelAndButton {
    UILabel *tipsLabel = [[UILabel alloc] init];
    tipsLabel.text = @"上传行驶证/保险单确保车辆信息";
    tipsLabel.font = [UIFont systemFontOfSize:14];
    [self.scrollView addSubview:tipsLabel];
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setBackgroundImage:[UIImage imageNamed:@"圆角矩形-1"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(nextStepButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:button];
    
    [tipsLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.secondView.mas_bottom).with.offset(10);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tipsLabel.mas_bottom).with.offset(20);
        make.left.mas_equalTo(self.view).with.offset(20);
        make.right.mas_equalTo(self.view).with.offset(-20);
        make.height.mas_equalTo(44);
    }];
    
}

- (void)callActionSheet {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *fromPhoto = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self LocalPhoto];
    }];
    UIAlertAction *fromCamera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    UIAlertAction *cancal = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:fromPhoto];
    [alertController addAction:fromCamera];
    [alertController addAction:cancal];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)LocalPhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)takePhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)nextStepButtonClick {
    AddCarInfoViewController *addCarInfoVC = [[AddCarInfoViewController alloc] init];
    [self.navigationController pushViewController:addCarInfoVC animated:YES];
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
