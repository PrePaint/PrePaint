//
//  PPStyleViewController.h
//  PrePaint
//
//  Created by Jing Tang on 3/16/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPIntroductionView.h"

@interface PPStyleViewController : UIViewController
@property(strong,nonatomic) NSMutableArray *stylesArray;

@property (strong, nonatomic) IBOutlet PPIntroductionView *rightPanelView;
@property (strong, nonatomic) IBOutlet UIButton *tryToolButtons;
@property (strong, nonatomic) IBOutlet UIScrollView *styleScrollView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topPanelConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rightPanelConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomPanelConstraint;
@property (strong, nonatomic) IBOutlet UIView *topPanel;
@property (strong, nonatomic) IBOutlet UIView *bottomPanel;
@property (strong, nonatomic) IBOutlet UIView *rightIntroPanel;
@property (strong, nonatomic) NSMutableArray *styleButtonArray;
@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;
@property (strong, nonatomic) IBOutlet UIImageView *bottomBGImageView;

- (IBAction)tryToolButtonAction:(UIButton *)sender;

-(void)animateEveryThingIntoScreen;
-(void)selectFirstButton;
-(void)setupRightPanelShadow;
@end
