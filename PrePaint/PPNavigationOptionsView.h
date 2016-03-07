//
//  PPNavigationOptionsView.h
//  PrePaint
//
//  Created by Xi Zhang on 3/7/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"

@interface PPNavigationOptionsView : UIView

@property(nonatomic) PPNavationOptionType buttonType;
@property(nonatomic,assign)BOOL isSelected;
@property(weak,nonatomic) id responseDelegate;

@end
