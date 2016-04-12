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
    [self loadInitialVC];
    [self.paintingStyleVC selectFirstButton];
    [self.view bringSubviewToFront:self.topNavView];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
    [self.paintingStyleVC animateEveryThingIntoScreen];
}


-(void)setupNavigationOptions
{
    [self.toolsButton setResponseDelegate:self];
    [self.toolsButton setButtonType:PPNavationOptionTypeTools];
    [self.toolsButton setIsSelected:YES];
    
    [self.neededButton setResponseDelegate:self];
    [self.neededButton setButtonType:PPNavationOptionTypeNeeded];
    [self.neededButton setIsSelected:NO];
    
    [self.getItButton setResponseDelegate:self];
    [self.getItButton setButtonType:PPNavationOptionTypeGetIt];
    [self.getItButton setIsSelected:NO];
    
    [self.wishlistButton setResponseDelegate:self];
    [self.wishlistButton setButtonType:PPNavationOptionTypeWishList];
    [self.wishlistButton setIsSelected:NO];
    
}

-(void)loadInitialVC
{
    PPStyleViewController *styleVC = [[PPStyleViewController alloc] init];
    CGRect frame = [self.contentView bounds];
    [styleVC.view setFrame:frame];
    [self.contentView addSubview:styleVC.view];
    self.paintingStyleVC = styleVC;
    [self addChildViewController:self.paintingStyleVC];
    self.currentViewController = self.paintingStyleVC;
/*    FourTreasuresViewController *ftVC = [[FourTreasuresViewController alloc] init];
    CGRect frame = [self.contentView bounds];
    [ftVC.view setFrame:frame];
    [self.contentView addSubview:ftVC.view];
    self.fourTreasuresVC = ftVC;
 */
}

-(void)removeStyleVCAndloadFourTreasureVC
{
    if (self.currentViewController == self.paintingStyleVC) {
        

    FourTreasuresViewController *ftVC = [[FourTreasuresViewController alloc] init];
    CGRect frame = [self.contentView bounds];
    frame.origin.x = self.contentView.bounds.size.width;
    [ftVC.view setFrame:frame];
    [self.contentView addSubview:ftVC.view];
    self.fourTreasuresVC = ftVC;
    frame.origin.x = self.contentView.bounds.origin.x;
    CGRect rect = self.paintingStyleVC.view.frame;
    rect.origin.x = -rect.size.width;
    [self addChildViewController:self.fourTreasuresVC];
        [self.contentView bringSubviewToFront:ftVC.view];
    [self.toolsButton setIsSelected:NO];
    [self.neededButton setIsSelected:YES];
    [self.getItButton setIsSelected:NO];
    [self.wishlistButton setIsSelected:NO];
    
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
    if (self.currentViewController == self.fourTreasuresVC) {
        
   
    PPStyleViewController *styleVC = [[PPStyleViewController alloc] init];
    CGRect frame = [self.contentView bounds];
    frame.origin.x = -frame.size.width;
    [styleVC.view setFrame:frame];
    [self.contentView addSubview:styleVC.view];
    self.paintingStyleVC = styleVC;
    [self addChildViewController:self.paintingStyleVC];
    [self.contentView bringSubviewToFront:styleVC.view];
    CGRect rect = self.fourTreasuresVC.view.frame;
    rect.origin.x = rect.size.width;
    frame.origin.x = 0;
    
    [self.toolsButton setIsSelected:YES];
    [self.neededButton setIsSelected:NO];
    [self.getItButton setIsSelected:NO];
    [self.wishlistButton setIsSelected:NO];
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

//options delegate
-(void)optionSelected:(PPNavigationOptionsView*)optionView
{
    if (optionView == self.toolsButton) {
        [self.toolsButton setIsSelected:YES];
        [self.neededButton setIsSelected:NO];
        [self.getItButton setIsSelected:NO];
        [self.wishlistButton setIsSelected:NO];
        [self removeFourTreasureVCAndloadStyleVC];
    }
    else if (optionView == self.neededButton) {
        [self.toolsButton setIsSelected:NO];
        [self.neededButton setIsSelected:YES];
        [self.getItButton setIsSelected:NO];
        [self.wishlistButton setIsSelected:NO];
        [self removeStyleVCAndloadFourTreasureVC];
    }
    else if (optionView == self.getItButton) {
        [self.toolsButton setIsSelected:NO];
        [self.neededButton setIsSelected:NO];
        [self.getItButton setIsSelected:YES];
        [self.wishlistButton setIsSelected:NO];
    }
    else if (optionView == self.wishlistButton) {
        [self.toolsButton setIsSelected:NO];
        [self.neededButton setIsSelected:NO];
        [self.getItButton setIsSelected:NO];
        [self.wishlistButton setIsSelected:YES];
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
            ToolTutorialViewController *ttVC = [[ToolTutorialViewController alloc] init];
            vc = ttVC;
        }
            break;
        case 3:
        {
            ToolTutorialViewController *ttVC = [[ToolTutorialViewController alloc] init];
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
