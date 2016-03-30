//
//  ToolTutorialViewController.h
//  PrePaint
//
//  Created by Xi Zhang on 3/29/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToolTutorialViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIView *stepView;
- (IBAction)backButtonAction:(id)sender;

@end
