//
//  ViewController.h
//  PrePaint
//
//  Created by Xi Zhang on 2/29/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *logoCenterYConstraint;
- (IBAction)startButtonAction:(UIButton *)sender;

@end

