//
//  ForHelpTableViewController.m
//  Carmgr
//
//  Created by admin on 2017/2/8.
//  Copyright © 2017年 YiWuCheBao. All rights reserved.
//

#import "ForHelpTableViewController.h"
#import "TextViewTableViewCell.h"
#import "TextFieldTableViewCell.h"

@interface ForHelpTableViewController ()

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) NSArray *placeholders;

@end

@implementation ForHelpTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[TextFieldTableViewCell class] forCellReuseIdentifier:@"TextFieldTableViewCell"];
    [self.tableView registerClass:[TextViewTableViewCell class] forCellReuseIdentifier:@"TextViewTableViewCell"];
    
    self.titleArr = @[@"我想",@"描述",@"赏金"];
    self.placeholders = @[@"我需要别人帮助我什么",@"说一说具体的求助信息，清楚明确的描述更容易获得帮助",@"我愿意支付多少报酬给帮助者"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 9.99;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.titleArr.count;
    } else if (section == 1) {
        return 1;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1) {
        return 88;
    } else {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row != 1) {
            TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextFieldTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (indexPath.row == 2) {
                cell.titleLabel.font = [UIFont systemFontOfSize:14];
            }
            cell.titleLabel.text = self.titleArr[indexPath.row];
            cell.describeTextField.placeholder = self.placeholders[indexPath.row];
            return cell;
            
        } else {
            TextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextViewTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.titleLabel.text = self.titleArr[indexPath.row];
            cell.describeTextView.placeholder = self.placeholders[indexPath.row];
            return cell;
        }
    } else if (indexPath.section == 1) {
        TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextFieldTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.titleLabel.text = @"我在";
        cell.describeTextField.text = self.placeholders[indexPath.row];
        cell.describeTextField.enabled = NO;
        return cell;
    } else {
        return nil;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
