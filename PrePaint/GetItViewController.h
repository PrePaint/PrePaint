//
//  GetItViewController.h
//  PrePaint
//
//  Created by Jing Tang on 4/22/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "PPFourTreasuresView.h"

@interface GetItViewController : UIViewController<MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic) IBOutlet PPFourTreasuresView *contourView;
@property (strong, nonatomic) IBOutlet PPFourTreasuresView *ideaView;
@property (strong, nonatomic) IBOutlet PPFourTreasuresView *detailView;
@property (strong, nonatomic) IBOutlet PPFourTreasuresView *combinationView;




- (IBAction)shareAction:(id)sender;

@end
