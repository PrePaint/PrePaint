//
//  ToolTutorialViewController.h
//  PrePaint
//
//  Created by Xi Zhang on 3/29/16.
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



- (IBAction)backButtonAction:(id)sender;

@end
