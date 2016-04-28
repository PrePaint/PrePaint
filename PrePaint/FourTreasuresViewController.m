//
//  FourTreasuresViewController.m
//  PrePaint
//
//  Created by Jing Tang on 3/7/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import "FourTreasuresViewController.h"
#import "BaseViewController.h"

@interface FourTreasuresViewController (){
    UIImageView *_selectionView;
    UIView *currentBottomContentView;
}
@property (strong, nonatomic) PPFourTreasuresView *selectedTreasure;

@end

@implementation FourTreasuresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTreasureViews];
    [self setupBottomBar];
    [self addTapGestureForBrushViews];
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

-(void)setupBottomBar
{
    UIImage *barImage = [[UIImage imageNamed:@"bottomGradientBar"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0];
    [self.bottomBarImageViewBrush setImage:barImage];
    [self.bottomBarImageViewPaper setImage:barImage];
    [self.bottomBarImageViewHolder setImage:barImage];
    [self.bottomBarImageViewInk setImage:barImage];
}

-(void)treasureSelected:(PPFourTreasuresView*)treasureView
{
    [self.view setUserInteractionEnabled:NO];
    if (treasureView == self.selectedTreasure) {
        if (treasureView.buttonType == PPTreasureTypeBrush || treasureView.buttonType == PPTreasureTypeHolder) {
            [treasureView setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
        }
        else{
            [treasureView setBackgroundColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0]];
        }
        
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.PPTreasureViewHeightContraint setConstant:443];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                [self.brushTextView setAlpha:1.0];
                [self.paperTextView setAlpha:1.0];
                [self.holderTextView setAlpha:1.0];
                [self.inkTextView setAlpha:1.0];
            } completion:^(BOOL finished) {
                self.selectedTreasure = nil;
                [self.view setUserInteractionEnabled:YES];
            }];
        }];
        
    }
    else{
        if (self.selectedTreasure == nil) {
            [treasureView setBackgroundColor:SelectedBlueColor];
            [UIView animateWithDuration:0.5 animations:^{
                [self.brushTextView setAlpha:0.0];
                [self.paperTextView setAlpha:0.0];
                [self.holderTextView setAlpha:0.0];
                [self.inkTextView setAlpha:0.0];
            } completion:^(BOOL finished) {
                [currentBottomContentView removeFromSuperview];
                CGRect rect = self.bottomSlideView.bounds;
                UIView *view;
                if (treasureView.buttonType == PPTreasureTypeBrush) {
                    view = self.brushContentView;
                }
                else if (treasureView.buttonType == PPTreasureTypePaper) {
                    view = self.paperContentView;
                }
                else if (treasureView.buttonType == PPTreasureTypeHolder) {
                    view = self.inkContentView;
                }
                else{
                    view = self.colorContentView;
                }
                [view setFrame:rect];
                [self.bottomSlideView addSubview:view];
                currentBottomContentView = view;
                
                
                
                [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    
                    
                    [self.PPTreasureViewHeightContraint setConstant:treasureView.frame.size.height-self.bottomSlideView.frame.size.height - 20.0];
                    [self.view layoutIfNeeded];
                } completion:^(BOOL finished) {
                    self.selectedTreasure = treasureView;
                    [self.view setUserInteractionEnabled:YES];
                }];
            }];
            
        }
        else{
            if (self.selectedTreasure.buttonType == PPTreasureTypeBrush || self.selectedTreasure.buttonType == PPTreasureTypeHolder) {
                [self.selectedTreasure setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
            }
            else{
                [self.selectedTreasure setBackgroundColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0]];
            }
            [treasureView setBackgroundColor:SelectedBlueColor];
            [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                [self.bottomBarTopConstraint setConstant:190];
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                [currentBottomContentView removeFromSuperview];
                CGRect rect = self.bottomSlideView.bounds;
                UIView *view;
                if (treasureView.buttonType == PPTreasureTypeBrush) {
                    view = self.brushContentView;
                }
                else if (treasureView.buttonType == PPTreasureTypePaper) {
                    view = self.paperContentView;
                }
                else if (treasureView.buttonType == PPTreasureTypeHolder) {
                    view = self.inkContentView;
                }
                else{
                    view = self.colorContentView;
                }
                [view setFrame:rect];
                [self.bottomSlideView addSubview:view];
                currentBottomContentView = view;
                [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    
                    [self.bottomBarTopConstraint setConstant:20];
                    [self.view layoutIfNeeded];
                } completion:^(BOOL finished) {
                    
                    self.selectedTreasure = treasureView;
                    [self.view setUserInteractionEnabled:YES];
                }];
            }];
        }
    }
}

-(void)addTapGestureForBrushViews
{
    
    for (PPBrushesView *brushView in self.brushViews) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnBrushView:)];
        [brushView addGestureRecognizer:tapGesture];
    }
    
}


-(void)handleTapOnBrushView:(UITapGestureRecognizer*)gesture
{
    [(BaseViewController*)self.baseVC brushViewSelected:(int)gesture.view.tag withTreasureType:self.selectedTreasure.buttonType];
    [self moveSelection:gesture.view];
}

-(void)scrollDidMoveToTag:(NSInteger)tag
{
    UIView *view;
    if (self.selectedTreasure.buttonType == PPTreasureTypeBrush) {
        for (PPBrushesView *brushView in self.brushToolViews) {
            if (brushView.tag == tag) {
                view = brushView;
                break;
            }
        }
    }
    else if(self.selectedTreasure.buttonType == PPTreasureTypePaper){
        for (PPBrushesView *paperView in self.paperViews) {
            if (paperView.tag == tag) {
                view = paperView;
                break;
            }
        }
    }
    
    else if(self.selectedTreasure.buttonType == PPTreasureTypeHolder){
        for (PPBrushesView *inkView in self.inkViews) {
            if (inkView.tag == tag) {
                view = inkView;
                break;
            }
        }
        
    }
    else if(self.selectedTreasure.buttonType == PPTreasureTypeInk){
        for (PPBrushesView *colorView in self.colorViews) {
            if (colorView.tag == tag) {
                view = colorView;
                break;
            }
        }
    }
    
    [self moveSelection:view];
}

-(void)moveSelection:(UIView*)view
{
    if (_selectionView == nil) {
        CGRect rect = view.bounds;
        rect.origin.x+=10;
        rect.size.width-=20;
        rect.size.height-=25;
        rect.origin.y+=25;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
        _selectionView = imageView;
        [imageView setImage:[UIImage imageNamed:@"toolselection"]];
        [view addSubview:imageView];
        [view sendSubviewToBack:imageView];
    }
    else{
        [_selectionView removeFromSuperview];
        CGRect rect = view.bounds;
        rect.origin.x+=10;
        rect.size.width-=20;
        rect.size.height-=25;
        rect.origin.y+=25;
        [_selectionView setFrame:rect];
        [view addSubview:_selectionView];
        [view sendSubviewToBack:_selectionView];
    }
    
}

-(void)removeSelection
{
    [_selectionView removeFromSuperview];
    _selectionView = nil;
}


-(void)changeBottomImage
{
    
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
