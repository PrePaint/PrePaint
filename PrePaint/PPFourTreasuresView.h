//
//  PPFourTreasuresView.h
//  PrePaint
//
//  Created by Jing Tang on 3/7/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"

@interface PPFourTreasuresView : UIView

@property(nonatomic) PPTreasureType buttonType;
@property(nonatomic,assign)BOOL isSelected;
@property(weak,nonatomic) id responseDelegate;

@property(strong,nonatomic) UIImageView *mainImageView;
@property(strong,nonatomic) UIImageView *textImageView;
@property(strong,nonatomic) UILabel *buttonLabel;

@end
