//
//  FourTreasuresViewController.m
//  PrePaint
//
//  Created by Xi Zhang on 3/7/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import "FourTreasuresViewController.h"

@interface FourTreasuresViewController (){

}
@property (strong, nonatomic) PPFourTreasuresView *selectedTreasure;

@end

@implementation FourTreasuresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTreasureViews];
    // Do any additional setup after loading the view from its nib.
}

-(void)setupTreasureViews
{
    [self.brushView setButtonType:PPTreasureTypeBrush];
    [self.brushView setResponseDelegate:self];
    
    [self.paperView setButtonType:PPTreasureTypePaper];
    [self.paperView setResponseDelegate:self];
    
    [self.holderView setButtonType:PPTreasureTypeHolder];
    [self.holderView setResponseDelegate:self];
    
    [self.inkView setButtonType:PPTreasureTypeInk];
    [self.inkView setResponseDelegate:self];
}

-(void)treasureSelected:(PPFourTreasuresView*)treasureView
{
    if (treasureView == self.selectedTreasure) {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.PPTreasureViewHeightContraint setConstant:420];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                [self.brushTextView setAlpha:1.0];
                [self.paperTextView setAlpha:1.0];
                [self.holderTextView setAlpha:1.0];
                [self.inkTextView setAlpha:1.0];
            } completion:^(BOOL finished) {
                self.selectedTreasure = nil;
            }];
        }];

    }
    else{
        if (self.selectedTreasure == nil) {
            [UIView animateWithDuration:0.5 animations:^{
                [self.brushTextView setAlpha:0.0];
                [self.paperTextView setAlpha:0.0];
                [self.holderTextView setAlpha:0.0];
                [self.inkTextView setAlpha:0.0];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self.PPTreasureViewHeightContraint setConstant:treasureView.frame.size.height-self.bottomSlideView.frame.size.height - 20.0];
                    [self.view layoutIfNeeded];
                } completion:^(BOOL finished) {
                    self.selectedTreasure = treasureView;
                }];
            }];

        }
        else{
            
            [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.PPTreasureViewHeightContraint setConstant:420];
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self.PPTreasureViewHeightContraint setConstant:treasureView.frame.size.height-self.bottomSlideView.frame.size.height - 20.0];
                    [self.view layoutIfNeeded];
                } completion:^(BOOL finished) {
                    self.selectedTreasure = treasureView;
                }];
            }];
        }
    }
}


-(void)dealloc
{
    NSLog(@"4treasuresVC dealloc");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
