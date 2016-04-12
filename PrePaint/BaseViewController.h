//
//  BaseViewController.h
//  PrePaint
//
//  Created by Jing Tang on 3/7/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPNavigationOptionsView.h"
#import "FourTreasuresViewController.h"
#import "PPStyleViewController.h"
#import "ToolTutorialViewController.h"
#import "DetailTutorialViewController.h"
#import "IdeaTutorialViewController.h"
#import "CombinationTutorialViewController.h"


@interface BaseViewController : UIViewController
@property (strong, nonatomic) IBOutlet PPNavigationOptionsView *toolsButton;
@property (strong, nonatomic) IBOutlet PPNavigationOptionsView *neededButton;
@property (strong, nonatomic) IBOutlet PPNavigationOptionsView *getItButton;
@property (strong, nonatomic) IBOutlet PPNavigationOptionsView *wishlistButton;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) FourTreasuresViewController *fourTreasuresVC;
@property (strong, nonatomic) PPStyleViewController *paintingStyleVC;
@property (strong, nonatomic) IBOutlet UIView *topNavView;
@property (strong, nonatomic) UIViewController *currentViewController;

-(void)optionSelected:(PPNavigationOptionsView*)optionView;
-(void)removeStyleVCAndloadFourTreasureVC;
-(void)flipToToolTutorialPage:(NSInteger)tutorialTag;

@end
