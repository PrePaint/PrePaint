//
//  BaseViewController.m
//  PrePaint
//
//  Created by Jing Tang on 3/7/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

//3个STEP页的共用页， 3个页面之间的跳转和动画， 还有读去公有原素

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
    
}

//配置右上角的3个STEP按钮
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
//读取初始的STEP页， 默认是文房四宝页， 加入3个元素的选择页后目前已不太需要
-(void)loadInitialVC
{
    FourTreasuresViewController *ftVC = [[FourTreasuresViewController alloc] init];
    CGRect frame = [self.contentView bounds];
    [ftVC.view setFrame:frame];
    [self.contentView addSubview:ftVC.view];
    self.fourTreasuresVC = ftVC;
    self.currentViewController = self.fourTreasuresVC;
    [ftVC setBaseVC:self];
}

//读取STYLE页
-(void)loadPaintingStyleVC
{
    [self removeCurrentVCAndloadStyleVCWithoutAnimation];
}

//读取GET IT页
-(void)loadGetitVC
{
    [self removeCurrentVCAndloadGetItVCWithoutAnimation];
}

//移除当前的VIEW CONTROLLER控制的页面 并且读取GET IT页
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

//移除当前的VIEW CONTROLLER控制的页面 并且读取STYLE页
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

//移除当前的VIEW CONTROLLER控制的页面 并且读取文房四宝页
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

//移除当前的VIEW CONTROLLER控制的页面 并且读取GET IT页（无动画效果）
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
        
        [self.getitVC.view setFrame:frame];
        [self.currentViewController.view setFrame:rect];
        [self.currentViewController removeFromParentViewController];
        [self.currentViewController.view removeFromSuperview];
        self.fourTreasuresVC = nil;
        self.paintingStyleVC = nil;
        self.currentViewController = self.getitVC;
        
    }
}
//移除当前的VIEW CONTROLLER控制的页面 并且读取STYLE页 （无动画效果）
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
        
        [self.paintingStyleVC.view setFrame:frame];
        [self.currentViewController.view setFrame:rect];
        [self.currentViewController removeFromParentViewController];
        [self.currentViewController.view removeFromSuperview];
        self.fourTreasuresVC = nil;
        self.getitVC = nil;
        self.currentViewController = self.paintingStyleVC;
        [self.paintingStyleVC.rightIntroPanel setHidden:NO];
        [self.paintingStyleVC selectFirstButton];
        [self.paintingStyleVC animateEveryThingIntoScreen];
    }
}

//移除当前的VIEW CONTROLLER控制的页面 并且读取文房四宝页（无动画效果）
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
        
        [self.fourTreasuresVC.view setFrame:frame];
        [self.currentViewController.view setFrame:rect];
        [self.currentViewController removeFromParentViewController];
        [self.currentViewController.view removeFromSuperview];
        self.paintingStyleVC = nil;
        self.getitVC = nil;
        self.currentViewController = self.fourTreasuresVC;
    }
}

//options delegate 当右上角的3个STEP按钮 其中一个被选择时候调用
-(void)optionSelected:(PPNavigationOptionsView*)optionView
{
    if (optionView == self.toolsButton) {
        [self removeCurrentVCAndloadStyleVC];
    }
    else if (optionView == self.neededButton) {
        [self removeCurrentVCAndloadFourTreasuresVC];
    }
    else if (optionView == self.getItButton) {
        [self removeCurrentVCAndloadGetItVC];
    }
}

//添加翻面动画， 翻入到绘画教程页
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

//当下方某只笔被选择后调用， 读取SLIDE页并添加动画移动到屏幕内， 被SLIDE CONTROLLER调用
-(void)brushViewSelected:(int)tag withTreasureType:(PPTreasureType)type
{
    if (!self.slideShowVC) {
        SlideShowViewController *slideVC = [[SlideShowViewController alloc] init];
        self.slideShowVC = slideVC;
        
        [slideVC setCurrentTreasureType:type];
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

//关闭SLIDE页，被SLIDE CONTROLLER调用
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

//用户手动滚动SLIDE
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
