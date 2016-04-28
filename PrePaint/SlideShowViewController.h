//
//  SlideShowViewController.h
//  PrePaint
//
//  Created by Jing Tang on 4/17/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMCPagingScrollView.h"
#import "AppConstants.h"

@interface SlideShowViewController : UIViewController<GMCPagingScrollViewDataSource,GMCPagingScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) GMCPagingScrollView *pagingScrollView;
@property (assign, nonatomic) NSInteger selectedTag;

@property (assign, nonatomic) PPTreasureType currentTreasureType;
@property (weak, nonatomic) id responseDelegate;


- (IBAction)leftButtonAction:(id)sender;
- (IBAction)rightButtonAction:(id)sender;
- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)pageDidSelected:(UIPageControl *)sender;
-(void)selectedBrush:(NSInteger)brushTag;

@end
