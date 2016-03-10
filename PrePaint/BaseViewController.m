//
//  BaseViewController.m
//  PrePaint
//
//  Created by Xi Zhang on 3/7/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationOptions];
    [self loadInitialVC];
    // Do any additional setup after loading the view from its nib.
}


-(void)setupNavigationOptions
{
    [self.toolsButton setResponseDelegate:self];
    [self.toolsButton setButtonType:PPNavationOptionTypeTools];
    [self.toolsButton setIsSelected:YES];
    
    [self.neededButton setResponseDelegate:self];
    [self.neededButton setButtonType:PPNavationOptionTypeNeeded];
    [self.neededButton setIsSelected:NO];
    
    [self.getItButton setResponseDelegate:self];
    [self.getItButton setButtonType:PPNavationOptionTypeGetIt];
    [self.getItButton setIsSelected:NO];
    
    [self.wishlistButton setResponseDelegate:self];
    [self.wishlistButton setButtonType:PPNavationOptionTypeWishList];
    [self.wishlistButton setIsSelected:NO];
    
}

-(void)loadInitialVC
{
    FourTreasuresViewController *ftVC = [[FourTreasuresViewController alloc] init];
    CGRect frame = [self.contentView bounds];
    [ftVC.view setFrame:frame];
    [self.contentView addSubview:ftVC.view];
    self.fourTreasuresVC = ftVC;
}

//options delegate
-(void)optionSelected:(PPNavigationOptionsView*)optionView
{
    if (optionView == self.toolsButton) {
        [self.toolsButton setIsSelected:YES];
        [self.neededButton setIsSelected:NO];
        [self.getItButton setIsSelected:NO];
        [self.wishlistButton setIsSelected:NO];
    }
    else if (optionView == self.neededButton) {
        [self.toolsButton setIsSelected:NO];
        [self.neededButton setIsSelected:YES];
        [self.getItButton setIsSelected:NO];
        [self.wishlistButton setIsSelected:NO];
    }
    else if (optionView == self.getItButton) {
        [self.toolsButton setIsSelected:NO];
        [self.neededButton setIsSelected:NO];
        [self.getItButton setIsSelected:YES];
        [self.wishlistButton setIsSelected:NO];
    }
    else if (optionView == self.wishlistButton) {
        [self.toolsButton setIsSelected:NO];
        [self.neededButton setIsSelected:NO];
        [self.getItButton setIsSelected:NO];
        [self.wishlistButton setIsSelected:YES];
    }
}


-(void)dealloc
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return YES; 
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
