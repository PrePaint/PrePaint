//
//  FourTreasuresViewController.h
//  PrePaint
//
//  Created by Xi Zhang on 3/7/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPFourTreasuresView.h"

@interface FourTreasuresViewController : UIViewController
@property (strong, nonatomic) IBOutlet PPFourTreasuresView *brushView;
@property (strong, nonatomic) IBOutlet PPFourTreasuresView *paperView;
@property (strong, nonatomic) IBOutlet PPFourTreasuresView *holderView;
@property (strong, nonatomic) IBOutlet PPFourTreasuresView *inkView;
@property (strong, nonatomic) IBOutlet UIView *bottomSlideView;
@property (strong, nonatomic) IBOutlet UIImageView *brushTextView;
@property (strong, nonatomic) IBOutlet UIImageView *paperTextView;
@property (strong, nonatomic) IBOutlet UIImageView *holderTextView;
@property (strong, nonatomic) IBOutlet UIImageView *inkTextView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *PPTreasureViewHeightContraint;
@property (strong, nonatomic) IBOutlet UIImageView *bottomBarImageView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomBarTopConstraint;

-(void)treasureSelected:(PPFourTreasuresView*)treasureView;

@end
