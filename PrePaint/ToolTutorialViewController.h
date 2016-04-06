//
//  ToolTutorialViewController.h
//  PrePaint
//
//  Created by Jing Tang on 3/29/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToolTutorialViewController : UIViewController<UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIView *stepView;
@property (strong, nonatomic) IBOutlet UIImageView *xuanPaperImageView;
@property (strong, nonatomic) IBOutlet UIImageView *pencilImageView;
@property (strong, nonatomic) IBOutlet UIImageView *veinBrushImageView;
@property (strong, nonatomic) IBOutlet UIView *stepBarView;
@property (strong, nonatomic) IBOutlet UIButton *previousButton;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UILabel *stepNumberLabel;
@property (strong, nonatomic) IBOutlet UIView *tutorialBgView;
@property (strong, nonatomic) IBOutlet UIImageView *tutorialImageView;



- (IBAction)backButtonAction:(id)sender;
- (IBAction)previousButtonAction:(id)sender;
- (IBAction)nextButtonAction:(id)sender;
- (IBAction)gotitButtonAction:(UIButton*)sender;


@end
