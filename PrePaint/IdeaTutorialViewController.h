//
//  IdeaTutorialViewController.h
//  PrePaint
//
//  Created by Jing Tang on 4/10/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"

@interface IdeaTutorialViewController : UIViewController<UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIView *stepView;
@property (strong, nonatomic) IBOutlet UIImageView *xuanPaperImageView;
@property (strong, nonatomic) IBOutlet UIImageView *wolfImageView;
@property (strong, nonatomic) IBOutlet UIImageView *veinBrushImageView;
@property (strong, nonatomic) IBOutlet UIImageView *goatBrushImageView;
@property (strong, nonatomic) IBOutlet UIView *stepBarView;
@property (strong, nonatomic) IBOutlet UIButton *previousButton;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UILabel *stepNumberLabel;
@property (strong, nonatomic) IBOutlet UIView *tutorialBgView;
@property (strong, nonatomic) IBOutlet UIImageView *tutorialImageView;
@property (strong, nonatomic) IBOutlet UILabel *hintLabel;
@property (strong, nonatomic) IBOutlet UIView *rightPannel;

@property (strong, nonatomic) IBOutlet UIImageView *toolBgImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleStyleLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleFlowerLabel;

- (IBAction)backButtonAction:(id)sender;
- (IBAction)previousButtonAction:(id)sender;
- (IBAction)nextButtonAction:(id)sender;
- (IBAction)gotitButtonAction:(UIButton*)sender;

@end
