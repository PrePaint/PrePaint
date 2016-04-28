//
//  BaseViewController.m
//  PrePaint
//
//  Created by Jing Tang on 3/7/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationOptions];
    switch (self.intialVCTag) {
        case 0:
        {
            [self loadInitialVC];
            [self.paintingStyleVC selectFirstButton];
        }
            break;
        case 1:
        {
            [self loadPaintingStyleVC];
           
        }
            break;
        case 2:
        {
            [self loadGetitVC];
        }
            break;
            
        default:
            break;
    }
    
    [self.view bringSubviewToFront:self.topNavView];
    UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToMainView:)];
    [self.backTouchView addGestureRecognizer:tapGesture];
    // Do any additional setup after loading the view from its nib.
}

-(void)backToMainView:(UIGestureRecognizer*)gesture
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
//    [self.paintingStyleVC animateEveryThingIntoScreen];
}


-(void)setupNavigationOptions
{
    [self.toolsButton setResponseDelegate:self];
    [self.toolsButton setButtonType:PPNavationOptionTypeTools];
    [self.toolsButton setIsSelected:NO];
    
    [self.neededButton setResponseDelegate:self];
    [self.neededButton setButtonType:PPNavationOptionTypeNeeded];
    [self.neededButton setIsSelected:YES];
    
    [self.getItButton setResponseDelegate:self];
    [self.getItButton setButtonType:PPNavationOptionTypeGetIt];
    [self.getItButton setIsSelected:NO];
    
}

-(void)loadInitialVC
{
//    PPStyleViewController *styleVC = [[PPStyleViewController alloc] init];
//    CGRect frame = [self.contentView bounds];
//    [styleVC.view setFrame:frame];
//    [self.contentView addSubview:styleVC.view];
//    self.paintingStyleVC = styleVC;
//    [self addChildViewController:self.paintingStyleVC];
//    self.currentViewController = self.paintingStyleVC;
    FourTreasuresViewController *ftVC = [[FourTreasuresViewController alloc] init];
    CGRect frame = [self.contentView bounds];
    [ftVC.view setFrame:frame];
    [self.contentView addSubview:ftVC.view];
    self.fourTreasuresVC = ftVC;
    self.currentViewController = self.fourTreasuresVC;
    [ftVC setBaseVC:self];
}

-(void)loadPaintingStyleVC
{
    [self removeCurrentVCAndloadStyleVCWithoutAnimation];
}

-(void)loadGetitVC
{
    [self removeCurrentVCAndloadGetItVCWithoutAnimation];
}


-(void)removeStyleVCAndloadFourTreasureVC
{
    if (self.currentViewController == self.paintingStyleVC&&self.fourTreasuresVC==nil) {
        
        
        FourTreasuresViewController *ftVC = [[FourTreasuresViewController alloc] init];
        [ftVC setBaseVC:self];
        CGRect frame = [self.contentView bounds];
        frame.origin.x = -frame.size.width;
        [ftVC.view setFrame:frame];
        [self.contentView addSubview:ftVC.view];
        self.fourTreasuresVC = ftVC;
        frame.origin.x = self.contentView.bounds.origin.x;
        CGRect rect = self.paintingStyleVC.view.frame;
        rect.origin.x = rect.size.width;
        [self addChildViewController:self.fourTreasuresVC];
        [self.contentView bringSubviewToFront:ftVC.view];
        [self.toolsButton setIsSelected:NO];
        [self.neededButton setIsSelected:YES];
        [self.getItButton setIsSelected:NO];
  
        [UIView animateWithDuration:0.5 animations:^{
            [self.paintingStyleVC.view setFrame:rect];
            [self.fourTreasuresVC.view setFrame:frame];
        } completion:^(BOOL finished) {
            [self.paintingStyleVC removeFromParentViewController];
            [self.paintingStyleVC.view removeFromSuperview];
            self.paintingStyleVC = nil;
            [self optionSelected:self.neededButton];
            self.currentViewController = self.fourTreasuresVC;
            
        }];
    }
}

-(void)removeFourTreasureVCAndloadStyleVC
{
    if (self.currentViewController == self.fourTreasuresVC&&self.paintingStyleVC == nil) {
        
        
        PPStyleViewController *styleVC = [[PPStyleViewController alloc] init];
        CGRect frame = [self.contentView bounds];
        frame.origin.x = frame.size.width;
        [styleVC.view setFrame:frame];
        [self.contentView addSubview:styleVC.view];
        self.paintingStyleVC = styleVC;
        [self addChildViewController:self.paintingStyleVC];
        [self.contentView bringSubviewToFront:styleVC.view];
        CGRect rect = self.fourTreasuresVC.view.frame;
        rect.origin.x = -rect.size.width;
        frame.origin.x = 0;
        
        [self.toolsButton setIsSelected:YES];
        [self.neededButton setIsSelected:NO];
        [self.getItButton setIsSelected:NO];
       
        [self.paintingStyleVC.rightIntroPanel setHidden:YES];
        
        [UIView animateWithDuration:0.5 animations:^{
            [self.paintingStyleVC.view setFrame:frame];
            [self.fourTreasuresVC.view setFrame:rect];
        } completion:^(BOOL finished) {
            [self.fourTreasuresVC removeFromParentViewController];
            [self.fourTreasuresVC.view removeFromSuperview];
            self.fourTreasuresVC = nil;
            self.currentViewController = self.paintingStyleVC;
            [self.paintingStyleVC.rightIntroPanel setHidden:NO];
            [self.paintingStyleVC selectFirstButton];
            [self.paintingStyleVC animateEveryThingIntoScreen];
        }];
    }
}

-(void)removeCurrentVCAndloadGetItVC
{
    if (self.getitVC == nil) {
        
        
        GetItViewController *styleVC = [[GetItViewController alloc] init];
        CGRect frame = [self.contentView bounds];
        frame.origin.x = frame.size.width;
        [styleVC.view setFrame:frame];
        [self.contentView addSubview:styleVC.view];
        self.getitVC = styleVC;
        [self addChildViewController:self.getitVC];
        [self.contentView bringSubviewToFront:styleVC.view];
        CGRect rect = self.currentViewController.view.frame;
        rect.origin.x = -rect.size.width;
        frame.origin.x = 0;
        
        [self.toolsButton setIsSelected:NO];
        [self.neededButton setIsSelected:NO];
        [self.getItButton setIsSelected:YES];
       
//        [self.paintingStyleVC.rightIntroPanel setHidden:YES];
        
        [UIView animateWithDuration:0.5 animations:^{
            [self.getitVC.view setFrame:frame];
            [self.currentViewController.view setFrame:rect];
        } completion:^(BOOL finished) {
            [self.currentViewController removeFromParentViewController];
            [self.currentViewController.view removeFromSuperview];
            self.fourTreasuresVC = nil;
            self.paintingStyleVC = nil;
            self.currentViewController = self.getitVC;
       
        }];
    }
}

-(void)removeCurrentVCAndloadStyleVC
{
    if (self.paintingStyleVC == nil) {
        
        
        PPStyleViewController *styleVC = [[PPStyleViewController alloc] init];
        CGRect frame = [self.contentView bounds];
        if ([self.currentViewController isKindOfClass:[GetItViewController class]]) {
            frame.origin.x = -frame.size.width;
        }
        else{
            frame.origin.x = frame.size.width;
        }
        
        [styleVC.view setFrame:frame];
        [self.contentView addSubview:styleVC.view];
        self.paintingStyleVC = styleVC;
        [self addChildViewController:self.paintingStyleVC];
        [self.contentView bringSubviewToFront:styleVC.view];
        CGRect rect = self.currentViewController.view.frame;
        if ([self.currentViewController isKindOfClass:[GetItViewController class]]) {
            rect.origin.x = rect.size.width;
        }
        else{
            rect.origin.x = -rect.size.width;
        }
       
        frame.origin.x = 0;
        
        [self.toolsButton setIsSelected:YES];
        [self.neededButton setIsSelected:NO];
        [self.getItButton setIsSelected:NO];
        
               [self.paintingStyleVC.rightIntroPanel setHidden:YES];
        
        [UIView animateWithDuration:0.5 animations:^{
            [self.paintingStyleVC.view setFrame:frame];
            [self.currentViewController.view setFrame:rect];
        } completion:^(BOOL finished) {
            [self.currentViewController removeFromParentViewController];
            [self.currentViewController.view removeFromSuperview];
            self.fourTreasuresVC = nil;
            self.getitVC = nil;
            self.currentViewController = self.paintingStyleVC;
            [self.paintingStyleVC.rightIntroPanel setHidden:NO];
            [self.paintingStyleVC selectFirstButton];
            [self.paintingStyleVC animateEveryThingIntoScreen];
        }];
    }
}


-(void)removeCurrentVCAndloadFourTreasuresVC
{
    if (self.fourTreasuresVC == nil) {
        
        
        FourTreasuresViewController *styleVC = [[FourTreasuresViewController alloc] init];
        CGRect frame = [self.contentView bounds];
       
            frame.origin.x = -frame.size.width;

        
        
        [styleVC.view setFrame:frame];
        [self.contentView addSubview:styleVC.view];
        self.fourTreasuresVC = styleVC;
        [styleVC setBaseVC:self];
        [self addChildViewController:self.fourTreasuresVC];
        [self.contentView bringSubviewToFront:styleVC.view];
        CGRect rect = self.currentViewController.view.frame;

        rect.origin.x = rect.size.width;
      
        
        frame.origin.x = 0;
        
        [self.toolsButton setIsSelected:NO];
        [self.neededButton setIsSelected:YES];
        [self.getItButton setIsSelected:NO];
     
        [UIView animateWithDuration:0.5 animations:^{
            [self.fourTreasuresVC.view setFrame:frame];
            [self.currentViewController.view setFrame:rect];
        } completion:^(BOOL finished) {
            [self.currentViewController removeFromParentViewController];
            [self.currentViewController.view removeFromSuperview];
            self.paintingStyleVC = nil;
            self.getitVC = nil;
            self.currentViewController = self.fourTreasuresVC;
     
        }];
    }
}


-(void)removeCurrentVCAndloadGetItVCWithoutAnimation
{
    if (self.getitVC == nil) {
        
        
        GetItViewController *styleVC = [[GetItViewController alloc] init];
        CGRect frame = [self.contentView bounds];
        frame.origin.x = frame.size.width;
        [styleVC.view setFrame:frame];
        [self.contentView addSubview:styleVC.view];
        self.getitVC = styleVC;
        [self addChildViewController:self.getitVC];
        [self.contentView bringSubviewToFront:styleVC.view];
        CGRect rect = self.currentViewController.view.frame;
        rect.origin.x = -rect.size.width;
        frame.origin.x = 0;
        
        [self.toolsButton setIsSelected:NO];
        [self.neededButton setIsSelected:NO];
        [self.getItButton setIsSelected:YES];
        
        //        [self.paintingStyleVC.rightIntroPanel setHidden:YES];
        
//        [UIView animateWithDuration:0.5 animations:^{
            [self.getitVC.view setFrame:frame];
            [self.currentViewController.view setFrame:rect];
//        } completion:^(BOOL finished) {
            [self.currentViewController removeFromParentViewController];
            [self.currentViewController.view removeFromSuperview];
            self.fourTreasuresVC = nil;
            self.paintingStyleVC = nil;
            self.currentViewController = self.getitVC;
            
//        }];
    }
}

-(void)removeCurrentVCAndloadStyleVCWithoutAnimation
{
    if (self.paintingStyleVC == nil) {
        
        
        PPStyleViewController *styleVC = [[PPStyleViewController alloc] init];
        CGRect frame = [self.contentView bounds];
        if ([self.currentViewController isKindOfClass:[GetItViewController class]]) {
            frame.origin.x = -frame.size.width;
        }
        else{
            frame.origin.x = frame.size.width;
        }
        
        [styleVC.view setFrame:frame];
        [self.contentView addSubview:styleVC.view];
        self.paintingStyleVC = styleVC;
        [self addChildViewController:self.paintingStyleVC];
        [self.contentView bringSubviewToFront:styleVC.view];
        CGRect rect = self.currentViewController.view.frame;
        if ([self.currentViewController isKindOfClass:[GetItViewController class]]) {
            rect.origin.x = rect.size.width;
        }
        else{
            rect.origin.x = -rect.size.width;
        }
        
        frame.origin.x = 0;
        
        [self.toolsButton setIsSelected:YES];
        [self.neededButton setIsSelected:NO];
        [self.getItButton setIsSelected:NO];
        
        [self.paintingStyleVC.rightIntroPanel setHidden:YES];
        
//        [UIView animateWithDuration:0.5 animations:^{
            [self.paintingStyleVC.view setFrame:frame];
            [self.currentViewController.view setFrame:rect];
//        } completion:^(BOOL finished) {
            [self.currentViewController removeFromParentViewController];
            [self.currentViewController.view removeFromSuperview];
            self.fourTreasuresVC = nil;
            self.getitVC = nil;
            self.currentViewController = self.paintingStyleVC;
            [self.paintingStyleVC.rightIntroPanel setHidden:NO];
            [self.paintingStyleVC selectFirstButton];
            [self.paintingStyleVC animateEveryThingIntoScreen];
//        }];
    }
}


-(void)removeCurrentVCAndloadFourTreasuresVCWithoutAnimation
{
    if (self.fourTreasuresVC == nil) {
        
        
        FourTreasuresViewController *styleVC = [[FourTreasuresViewController alloc] init];
        CGRect frame = [self.contentView bounds];
        
        frame.origin.x = -frame.size.width;
        
        
        
        [styleVC.view setFrame:frame];
        [self.contentView addSubview:styleVC.view];
        self.fourTreasuresVC = styleVC;
        [styleVC setBaseVC:self];
        [self addChildViewController:self.fourTreasuresVC];
        [self.contentView bringSubviewToFront:styleVC.view];
        CGRect rect = self.currentViewController.view.frame;
        
        rect.origin.x = rect.size.width;
        
        
        frame.origin.x = 0;
        
        [self.toolsButton setIsSelected:NO];
        [self.neededButton setIsSelected:YES];
        [self.getItButton setIsSelected:NO];
        
//        [UIView animateWithDuration:0.5 animations:^{
            [self.fourTreasuresVC.view setFrame:frame];
            [self.currentViewController.view setFrame:rect];
//        } completion:^(BOOL finished) {
            [self.currentViewController removeFromParentViewController];
            [self.currentViewController.view removeFromSuperview];
            self.paintingStyleVC = nil;
            self.getitVC = nil;
            self.currentViewController = self.fourTreasuresVC;
            
//        }];
    }
}



//-(void)removeStyleVCAndloadFourTreasureVC
//{
//    if (self.currentViewController == self.paintingStyleVC) {
//        
//
//    FourTreasuresViewController *ftVC = [[FourTreasuresViewController alloc] init];
//    [ftVC setBaseVC:self];
//    CGRect frame = [self.contentView bounds];
//    frame.origin.x = self.contentView.bounds.size.width;
//    [ftVC.view setFrame:frame];
//    [self.contentView addSubview:ftVC.view];
//    self.fourTreasuresVC = ftVC;
//    frame.origin.x = self.contentView.bounds.origin.x;
//    CGRect rect = self.paintingStyleVC.view.frame;
//    rect.origin.x = -rect.size.width;
//    [self addChildViewController:self.fourTreasuresVC];
//        [self.contentView bringSubviewToFront:ftVC.view];
//    [self.toolsButton setIsSelected:NO];
//    [self.neededButton setIsSelected:YES];
//    [self.getItButton setIsSelected:NO];
//    [self.wishlistButton setIsSelected:NO];
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        [self.paintingStyleVC.view setFrame:rect];
//        [self.fourTreasuresVC.view setFrame:frame];
//    } completion:^(BOOL finished) {
//        [self.paintingStyleVC removeFromParentViewController];
//        [self.paintingStyleVC.view removeFromSuperview];
//        self.paintingStyleVC = nil;
//        [self optionSelected:self.neededButton];
//        self.currentViewController = self.fourTreasuresVC;
//        
//
//    }];
//  }
//}
//
//-(void)removeFourTreasureVCAndloadStyleVC
//{
//    if (self.currentViewController == self.fourTreasuresVC) {
//        
//   
//    PPStyleViewController *styleVC = [[PPStyleViewController alloc] init];
//    CGRect frame = [self.contentView bounds];
//    frame.origin.x = -frame.size.width;
//    [styleVC.view setFrame:frame];
//    [self.contentView addSubview:styleVC.view];
//    self.paintingStyleVC = styleVC;
//    [self addChildViewController:self.paintingStyleVC];
//    [self.contentView bringSubviewToFront:styleVC.view];
//    CGRect rect = self.fourTreasuresVC.view.frame;
//    rect.origin.x = rect.size.width;
//    frame.origin.x = 0;
//    
//    [self.toolsButton setIsSelected:YES];
//    [self.neededButton setIsSelected:NO];
//    [self.getItButton setIsSelected:NO];
//    [self.wishlistButton setIsSelected:NO];
//    [self.paintingStyleVC.rightIntroPanel setHidden:YES];
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        [self.paintingStyleVC.view setFrame:frame];
//        [self.fourTreasuresVC.view setFrame:rect];
//    } completion:^(BOOL finished) {
//        [self.fourTreasuresVC removeFromParentViewController];
//        [self.fourTreasuresVC.view removeFromSuperview];
//        self.fourTreasuresVC = nil;
//        self.currentViewController = self.paintingStyleVC;
//        [self.paintingStyleVC.rightIntroPanel setHidden:NO];
//        [self.paintingStyleVC selectFirstButton];
//        [self.paintingStyleVC animateEveryThingIntoScreen];
//    }];
//   }
//}

//options delegate
-(void)optionSelected:(PPNavigationOptionsView*)optionView
{
    if (optionView == self.toolsButton) {
//        [self.toolsButton setIsSelected:YES];
//        [self.neededButton setIsSelected:NO];
//        [self.getItButton setIsSelected:NO];
        [self removeCurrentVCAndloadStyleVC];
//        [self removeFourTreasureVCAndloadStyleVC];
    }
    else if (optionView == self.neededButton) {
//        [self.toolsButton setIsSelected:NO];
//        [self.neededButton setIsSelected:YES];
//        [self.getItButton setIsSelected:NO];
        [self removeCurrentVCAndloadFourTreasuresVC];
//        [self removeStyleVCAndloadFourTreasureVC];
    }
    else if (optionView == self.getItButton) {
//        [self.toolsButton setIsSelected:NO];
//        [self.neededButton setIsSelected:NO];
//        [self.getItButton setIsSelected:YES];
        [self removeCurrentVCAndloadGetItVC];
    }

}


-(void)flipToToolTutorialPage:(NSInteger)tutorialTag
{
    UIViewController *vc;
    switch (tutorialTag) {
        case 0:
        {
          ToolTutorialViewController *ttVC = [[ToolTutorialViewController alloc] init];
                vc = ttVC;
        }
            break;
        case 1:
        {
            DetailTutorialViewController *ttVC = [[DetailTutorialViewController alloc] init];
            vc = ttVC;
        }
            break;
        case 2:
        {
            IdeaTutorialViewController *ttVC = [[IdeaTutorialViewController alloc] init];
            vc = ttVC;
        }
            break;
        case 3:
        {
            CombinationTutorialViewController *ttVC = [[CombinationTutorialViewController alloc] init];
            vc = ttVC;
        }
            break;
            
        default:
            break;
    }
    
  
    [UIView transitionWithView:self.navigationController.view
                      duration:0.75
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [self.navigationController pushViewController:vc animated:NO];
                    }
                    completion:nil];

 
}


-(void)brushViewSelected:(int)tag
{
    if (!self.slideShowVC) {
        SlideShowViewController *slideVC = [[SlideShowViewController alloc] init];
        self.slideShowVC = slideVC;
        [self.slideShowVC setResponseDelegate:self];
        CGRect rect = CGRectMake(0, -kSlideShowViewHeight, self.view.bounds.size.width, kSlideShowViewHeight);
        CGRect targetRect = CGRectMake(0, 0, self.view.bounds.size.width, kSlideShowViewHeight);
        [slideVC setSelectedTag:tag-1];
        [slideVC.view setFrame:rect];
        [self.view addSubview:slideVC.view];
        [self.view bringSubviewToFront:slideVC.view];
        [UIView animateWithDuration:0.5 animations:^{
            [slideVC.view setFrame:targetRect];
        } completion:^(BOOL finished) {
       
        }];
    }
    else{
        [self.slideShowVC selectedBrush:tag-1];
    }

}

-(void)closeSlideView
{
    if (self.slideShowVC) {
        [self.fourTreasuresVC removeSelection];
        CGRect rect = self.slideShowVC.view.frame;
        rect.origin.y = -self.slideShowVC.view.frame.size.height;
        [UIView animateWithDuration:0.5 animations:^{
            [self.slideShowVC.view setFrame:rect];
        } completion:^(BOOL finished) {
            [self.slideShowVC.view removeFromSuperview];
            self.slideShowVC = nil;
        }];
    }
   
}

-(void)didScrollToBrush:(NSInteger)tag
{
    if (self.fourTreasuresVC) {
        [self.fourTreasuresVC scrollDidMoveToTag:tag+1];
    }
}


-(void)dealloc
{
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
