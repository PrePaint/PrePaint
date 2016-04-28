//
//  FourTreasuresViewController.h
//  PrePaint
//
//  Created by Jing Tang on 3/7/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPBrushesView.h"
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
@property (strong, nonatomic) id baseVC;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *PPTreasureViewHeightContraint;
@property (strong, nonatomic) IBOutlet UIImageView *bottomBarImageViewBrush;
@property (strong, nonatomic) IBOutlet UIImageView *bottomBarImageViewPaper;
@property (strong, nonatomic) IBOutlet UIImageView *bottomBarImageViewHolder;
@property (strong, nonatomic) IBOutlet UIImageView *bottomBarImageViewInk;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomBarTopConstraint;
@property (strong, nonatomic) IBOutletCollection(PPBrushesView) NSArray *brushViews;
@property (strong, nonatomic) IBOutlet UIView *paperContentView;
@property (strong, nonatomic) IBOutlet UIView *inkContentView;
@property (strong, nonatomic) IBOutlet UIView *colorContentView;
@property (strong, nonatomic) IBOutlet UIView *brushContentView;
@property (strong, nonatomic) IBOutletCollection(PPBrushesView) NSArray *brushToolViews;

@property (strong, nonatomic) IBOutletCollection(PPBrushesView) NSArray *paperViews;
@property (strong, nonatomic) IBOutletCollection(PPBrushesView) NSArray *inkViews;
@property (strong, nonatomic) IBOutletCollection(PPBrushesView) NSArray *colorViews;

-(void)treasureSelected:(PPFourTreasuresView*)treasureView;
-(void)scrollDidMoveToTag:(NSInteger)tag;
-(void)removeSelection;
@end
