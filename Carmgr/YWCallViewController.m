//
//  YWCallViewController.m
//  Carmgr
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 YiWuCheBao. All rights reserved.
//

#import "YWCallViewController.h"
#import "YWPublic.h"
#import <Masonry.h>
#import "CallView.h"

@interface YWCallViewController () <UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic, strong) CallView *callView;

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextView *adviseField;
@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation YWCallViewController
{
    UIImageView *background;
    CGFloat width;
}

//弹出框
- (void)showAlertViewTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertVC animated:YES completion:^{
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFireMethod:) userInfo:alertVC repeats:NO];
    }];
    
}

//定时器
- (void)timerFireMethod:(NSTimer *)timer {
    UIAlertController *alertVC = [timer userInfo];
    [alertVC dismissViewControllerAnimated:YES completion:nil];
}

//拨打电话
- (void)callAction:(UIButton *)sender {
    [YWPublic userOperationInClickAreaID:@"4000_2" detial:@"拨打电话"];
    
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel:400-111-9665"]]];
    [self.view addSubview:callWebview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.callView = [[CallView alloc] init];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.contentView];
    
    
    [self initView];
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

//页面布局
- (void)initView {
    width = [UIScreen mainScreen].bounds.size.width;
    background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width*45/64)];
    background.image = [UIImage imageNamed:@"呼叫背景"];
    [self.contentView addSubview:background];
    
    self.textField = [self.callView textField:@"请输入您想办理的业务 如：上牌"];
    self.textField.delegate = self;
    [self.contentView addSubview:self.textField];
    
    UIButton *button = [self.callView button:@"服务预约" target:self action:@selector(service)];
    [self.contentView addSubview:button];
    
    UIButton *callBtn = [self.callView button:@"全国咨询电话 400-111-9665" target:self action:@selector(callAction:)];
    [self.contentView addSubview:callBtn];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"业务流程";
    label.textColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:1];
    [label sizeToFit];
    [self.contentView addSubview:label];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"业务流程"];
    [self.contentView addSubview:imageView];
    
    NSArray *title = @[@"预约服务",@"客服办理",@"完成业务",@"售后跟进"];
    CGFloat labelWidth = width/4;
    UILabel *lastLabel = nil;
    for (NSInteger i = 0; i < 4; i++) {
        UILabel *label = [self.callView label:title[i]];
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(imageView.mas_bottom).with.offset(10);
            if (i == 0) {
                make.left.mas_equalTo(self.view).with.offset(0);
            } else {
                make.left.mas_equalTo(lastLabel.mas_right).with.offset(0);
            }
            make.width.mas_equalTo(labelWidth);
        }];
        lastLabel = label;
    }
    
    UILabel *adviseLab = [self.callView label:@"易务宝正在完善请留下您的宝贵意见"];
    adviseLab.backgroundColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0];
    adviseLab.font = [UIFont systemFontOfSize:14];
    adviseLab.textColor = [UIColor whiteColor];
    adviseLab.layer.cornerRadius = 6;
    adviseLab.clipsToBounds = YES;
    [self.contentView addSubview:adviseLab];
    
    self.adviseField = [[UITextView alloc] init];
    self.adviseField.delegate = self;
    self.adviseField.text = @"在此输入";
    self.adviseField.textColor = [UIColor lightGrayColor];
    self.adviseField.tintColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0];
    self.adviseField.layer.cornerRadius = 6;
    self.adviseField.layer.masksToBounds = YES;
    self.adviseField.layer.borderWidth = 2;
    self.adviseField.layer.borderColor = [UIColor colorWithRed:255.0/256.0 green:167.0/256.0 blue:0.0 alpha:1.0].CGColor;
    [self.contentView addSubview:self.adviseField];
    
    self.commitBtn = [self.callView button:@"点击提交" target:self action:@selector(commit)];
    [self.contentView addSubview:self.commitBtn];
    
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(background.mas_bottom).with.offset(30);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(2*(width-40)/3);
        make.height.mas_equalTo(44);
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textField.mas_top);
        make.left.mas_equalTo(self.textField.mas_right).mas_equalTo(-6);
        make.right.mas_equalTo(self.view).with.offset(-20);
        make.height.mas_equalTo(self.textField);
    }];
    
    [callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(button.mas_bottom).with.offset(30);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(self.view).with.offset(-20);
        make.height.mas_equalTo(button);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(callBtn.mas_bottom).with.offset(30);
        make.left.mas_equalTo(20);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).with.offset(20);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(width*104/750);
    }];
    
    [adviseLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastLabel.mas_bottom).with.offset(30);
        make.left.mas_equalTo(self.view).with.offset(20);
        make.right.mas_equalTo(self.view).with.offset(-20);
        make.height.mas_equalTo(callBtn);
    }];
    
    [self.adviseField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(adviseLab.mas_bottom).with.offset(-10);
        make.left.mas_equalTo(adviseLab.mas_left);
        make.right.mas_equalTo(adviseLab.mas_right);
        make.height.mas_equalTo(width * 200 / 750);
    }];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.adviseField.mas_bottom).with.offset(30);
        make.width.mas_equalTo(width*260/750);
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.commitBtn.mas_bottom).with.offset(30);
    }];
    
}

//预约服务
- (void)service {
    if (self.textField.text.length == 0 || [self.textField.text isEqualToString:@" "]) {
        [self showAlertViewTitle:@"预约失败" message:@"请输入预约服务内容"];
    } else {
        [YWPublic userOperationInClickAreaID:@"4000_1" detial:self.textField.text];
        [self showAlertViewTitle:@"提示" message:@"预约成功"];
    }
}

//提交评价
- (void)commit {
    if (self.adviseField.text.length == 0 || [self.adviseField.text isEqualToString:@" "]) {
        [self showAlertViewTitle:@"提交失败" message:@"请输入内容"];
        return;
    }
    
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *urlStr = [[NSString stringWithFormat:kADVISE,username,self.adviseField.text,token] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [YWPublic afPOST:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dataDict[@"opt_state"] isEqualToString:@"success"]) {
            [self showAlertViewTitle:@"成功" message:@"提交成功，感谢您的支持"];
        } else {
            [self showAlertViewTitle:@"失败" message:@"提交失败，请重试"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showAlertViewTitle:@"错误" message:@"请检查网络或寻求技术支持"];
    }];
}

#pragma mark - textField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self service];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    textView.textColor = [UIColor blackColor];
    if ([textView.text isEqualToString:@"在此输入"]) {
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        textView.text = @"在此输入";
        textView.textColor = [UIColor lightGrayColor];
    }
}

#pragma mark - 键盘的弹出
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    // 获取键盘基本信息（动画时长与键盘高度）
    NSDictionary *userInfo = [aNotification userInfo];
    CGRect rect = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = CGRectGetHeight(rect);
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 修改下边距约束
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.commitBtn.mas_bottom).with.offset(keyboardHeight);
        
    }];
    
    // 更新约束
    [UIView animateWithDuration:keyboardDuration animations:^{
        CGPoint offset = self.scrollView.contentOffset;
        offset.y += keyboardHeight;
        self.scrollView.contentOffset = offset;
        [self.view layoutIfNeeded];
        
    }];
    
}

#pragma mark -  键盘的隐藏
-(void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    // 获取键盘基本信息（动画时长与键盘高度）
    NSDictionary *userInfo = [aNotification userInfo];
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 修改下边距约束
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.commitBtn.mas_bottom).with.offset(30);;
    }];
    
    // 更新约束
    [UIView animateWithDuration:keyboardDuration animations:^{
        
        [self.view layoutIfNeeded];
    }];
    
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
