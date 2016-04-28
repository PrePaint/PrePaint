//
//  OptionsViewController.h
//  PrePaint
//
//  Created by Jing Tang on 4/25/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *bgimageView;
@property (strong, nonatomic) IBOutlet UIButton *learnButton;
@property (strong, nonatomic) IBOutlet UIButton *exampleButton;
@property (strong, nonatomic) IBOutlet UIButton *getToolButton;
- (IBAction)learnButtonAction:(id)sender;
- (IBAction)exampleButtonAction:(id)sender;
- (IBAction)getToolButtonAction:(id)sender;

@end
