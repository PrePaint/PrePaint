//
//  ToolTutorialViewController.m
//  PrePaint
//
//  Created by Jing Tang on 3/29/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import "ToolTutorialViewController.h"

@interface ToolTutorialViewController (){
    CGRect _initialFrameOfObject;
    UIImageView *_tempImageView;
    BOOL _isXuanPaperOnScreen;
}

@end

@implementation ToolTutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetFlags];
    [self.stepView.layer setCornerRadius:self.stepView.frame.size.height/2.0];
    [self addGestureRecognizersForImageView:self.xuanPaperImageView];
    [self addGestureRecognizersForImageView:self.pencilImageView];
    [self addGestureRecognizersForImageView:self.veinBrushImageView];
    // Do any additional setup after loading the view from its nib.
}

-(void)resetFlags
{
    _isXuanPaperOnScreen = NO;
}

-(void)addGestureRecognizersForImageView:(UIImageView*)view
{
    
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureHandler:)];
    [view setUserInteractionEnabled:YES];
    [longGesture setMinimumPressDuration:0.1];
    [longGesture setDelegate:self];
    [view addGestureRecognizer:longGesture];
}

-(void)longPressGestureHandler:(UILongPressGestureRecognizer *)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            
            _initialFrameOfObject = gesture.view.frame;
            UIImageView *copiedImageView = [[UIImageView alloc] initWithFrame:_initialFrameOfObject];
            [copiedImageView setImage:[(UIImageView*)gesture.view image]];
            [copiedImageView setContentMode:[(UIImageView*)gesture.view contentMode]];
            [gesture.view.superview addSubview:copiedImageView];
            [gesture.view.superview sendSubviewToBack:copiedImageView];
            [self addGestureRecognizersForImageView:copiedImageView];
            _tempImageView = copiedImageView;
            CGRect rectInGlobalView = [self.view convertRect:gesture.view.frame fromView:gesture.view.superview];
            
//            [gesture.view removeFromSuperview];
            [self.view addSubview:gesture.view];
            [gesture.view setFrame:rectInGlobalView];
            [self.view bringSubviewToFront:gesture.view];
            
            [UIView animateWithDuration:0.5 animations:^{
                [gesture.view setAlpha:0.5];
                [gesture.view setCenter:[gesture locationInView:gesture.view.superview]];
                if (gesture.view == self.pencilImageView || gesture.view == self.veinBrushImageView) {
                    gesture.view.transform = CGAffineTransformMakeRotation(-M_PI_4);
                }
            } completion:^(BOOL finished) {
                
            }];
            
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [gesture.view setCenter:[gesture locationInView:gesture.view.superview]];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            
            if (gesture.view == self.xuanPaperImageView) {
                [self.xuanPaperImageView setImage:[UIImage imageNamed:@"tool_xuan_fullsize"]];
                _isXuanPaperOnScreen = YES;
                [UIView animateWithDuration:0.3 animations:^{
                    [gesture.view setAlpha:1.0];
                    
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.5 animations:^{
                        [gesture.view setFrame:CGRectMake(27, CGRectGetMaxY(self.stepBarView.frame)+75, 854, 635)];
                        
                    } completion:^(BOOL finished) {
                        [gesture.view removeGestureRecognizer:[gesture.view.gestureRecognizers firstObject]];
                        [gesture.view setUserInteractionEnabled:NO];
                        self.xuanPaperImageView = _tempImageView;
                        _tempImageView = nil;
                        
                    }];
                    
                }];
            }
            
            else if(gesture.view == self.pencilImageView){
                [UIView animateWithDuration:0.5 animations:^{
                    [gesture.view setAlpha:0.0];
                    
                } completion:^(BOOL finished) {
                    self.pencilImageView = _tempImageView;
                    _tempImageView = nil;
                }];
            }
            else{
                [UIView animateWithDuration:0.5 animations:^{
                    [gesture.view setAlpha:0.0];
                    
                } completion:^(BOOL finished) {
                    self.veinBrushImageView = _tempImageView;
                    _tempImageView = nil;
                }];
            }

            
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            NSLog(@"cancelled");
        }
            break;
            
        case UIGestureRecognizerStateFailed:
        {
            NSLog(@"failed");
        }
            break;
            
        default:
            break;
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.view == self.xuanPaperImageView) {
        if (_isXuanPaperOnScreen) {
            return NO;
        }
    }
    
    return YES;
}


-(void)viewDidLayoutSubviews
{
//    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
//    NSLog(@"sdf");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)dealloc
{

}

- (IBAction)backButtonAction:(id)sender {
    [UIView transitionWithView:self.navigationController.view
                      duration:0.75
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.navigationController popViewControllerAnimated:NO];
                    }
                    completion:nil];
}
@end
