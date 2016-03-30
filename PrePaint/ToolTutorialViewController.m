//
//  ToolTutorialViewController.m
//  PrePaint
//
//  Created by Xi Zhang on 3/29/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import "ToolTutorialViewController.h"

@interface ToolTutorialViewController ()

@end

@implementation ToolTutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.stepView.layer setCornerRadius:self.stepView.frame.size.height/2.0];
    // Do any additional setup after loading the view from its nib.
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

-(void)dealloc
{

}

- (IBAction)backButtonAction:(id)sender {
    [UIView transitionWithView:self.navigationController.view
                      duration:0.75
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.navigationController popViewControllerAnimated:NO];
                    }
                    completion:nil];
}
@end
