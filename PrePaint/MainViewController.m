//
//  ViewController.m
//  PrePaint
//
//  Created by Jing Tang on 2/29/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import "MainViewController.h"
#import "BaseViewController.h"
#import "OptionsViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logoCenterYConstraint.constant = 0;
    [self.view layoutIfNeeded];
    [self.titleLabel setAlpha:0.0];
    [self.subtitleLabel setAlpha:0.0];
    [self.startButton setAlpha:0.0];
    [self.startButton.layer setBorderColor:SelectedBlueColor.CGColor];
    [self.startButton.layer setBorderWidth:1.5];
    [self.startButton.layer setCornerRadius:self.startButton.frame.size.height/2.0];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self animateLogo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)animateLogo
{
    [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.logoCenterYConstraint.constant = -131.0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            [self.titleLabel setAlpha:1.0];
            [self.subtitleLabel setAlpha:1.0];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                [self.startButton setAlpha:1.0];
                } completion:^(BOOL finished) {
            }];
        }];
    }];

}

- (IBAction)startButtonAction:(UIButton *)sender {
    OptionsViewController *optionVC = [[OptionsViewController alloc] init];
    
    
    [UIView transitionWithView:self.navigationController.view
                      duration:1.0
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self.navigationController pushViewController:optionVC animated:NO];
                    }
                    completion:nil];
    
//    CATransition* transition = [CATransition animation];
//    
//    transition.duration = 1.0;
//    transition.type = kCATransitionFade;
//    
//    [[self navigationController].view.layer addAnimation:transition forKey:kCATransition];
//    [[self navigationController] pushViewController:optionVC animated:NO];
}

//- (IBAction)startButtonAction:(UIButton *)sender {
//    BaseViewController *baseVC = [[BaseViewController alloc] init];
//    [self.navigationController pushViewController:baseVC animated:YES];
//}


@end
