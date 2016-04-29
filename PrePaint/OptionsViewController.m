//
//  OptionsViewController.m
//  PrePaint
//
//  Created by Jing Tang on 4/25/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import "OptionsViewController.h"
#import "BaseViewController.h"

//选择页

@interface OptionsViewController ()

@end

@implementation OptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

//用户点STEP 1 文房四宝按钮后调用
- (IBAction)learnButtonAction:(id)sender {
    BaseViewController *baseVC = [[BaseViewController alloc] init];
    [baseVC setIntialVCTag:0];
    [self.navigationController pushViewController:baseVC animated:YES];
}

//用户点STEP 2 STYLE按钮后调用
- (IBAction)exampleButtonAction:(id)sender {
    BaseViewController *baseVC = [[BaseViewController alloc] init];
    [baseVC setIntialVCTag:1];
    [self.navigationController pushViewController:baseVC animated:YES];
}

//用户点STEP 3 GET IT按钮后调用
- (IBAction)getToolButtonAction:(id)sender {
    BaseViewController *baseVC = [[BaseViewController alloc] init];
    [baseVC setIntialVCTag:2];
    [self.navigationController pushViewController:baseVC animated:YES];
}
@end
