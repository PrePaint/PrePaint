//
//  BaseViewController.h
//  PrePaint
//
//  Created by Xi Zhang on 3/7/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPNavigationOptionsView.h"
#import "FourTreasuresViewController.h"


@interface BaseViewController : UIViewController
@property (strong, nonatomic) IBOutlet PPNavigationOptionsView *toolsButton;
@property (strong, nonatomic) IBOutlet PPNavigationOptionsView *neededButton;
@property (strong, nonatomic) IBOutlet PPNavigationOptionsView *getItButton;
@property (strong, nonatomic) IBOutlet PPNavigationOptionsView *wishlistButton;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) FourTreasuresViewController *fourTreasuresVC;

-(void)optionSelected:(PPNavigationOptionsView*)optionView;

@end
